with System.Storage_Elements;
with System.Address_To_Access_Conversions;
with Interfaces.C.Strings;

package body C_String.Arrays is
  package Storage_Elements renames System.Storage_Elements;
  package UB_Strings       renames Ada.Strings.Unbounded;
  package C                renames Interfaces.C;

  package Memory is new System.Address_To_Access_Conversions
    (Object => C_String.String_Ptr_t);

  use type C_String.String_Ptr_t;
  use type Memory.Object_Pointer;
  use type System.Storage_Elements.Storage_Offset;

  Word_Size : constant := System.Word_Size / System.Storage_Unit;

  --
  -- iterate over an array of Pointers, checking for null
  --

  function Size_Terminated
    (Pointer : in Pointer_Array_t) return Natural
  is
    Current_Address : System.Address := Pointer;
    Obj_Pointer     : Memory.Object_Pointer;
    Size            : Natural := 0;
  begin
    loop
      Obj_Pointer := Memory.To_Pointer (Current_Address);
      if Obj_Pointer.all = null then
        return Size;
      end if;
      Current_Address := Current_Address + Word_Size;
      Size := Size + 1;
    end loop;
  end Size_Terminated;

  function Size_Terminated
    (Pointer : in Allocated_Pointer_Array_t) return Natural is
  begin
    return Size_Terminated (Pointer_Array_t (Pointer));
  end Size_Terminated;

  --
  -- array_ptr [Index]
  --

  function Index_Address
    (Array_Pointer : in Pointer_Array_t;
     Size          : in Natural;
     Index         : in Natural) return System.Address
  is
    Address_Offset  : constant Storage_Elements.Storage_Offset :=
      Storage_Elements.Storage_Offset (Index * Word_Size);
    Address_Base    : constant System.Address := Array_Pointer;
    Address_Current : constant System.Address := Address_Base + Address_Offset;
  begin
    return Address_Current;
  end Index_Address;
  pragma Inline (Index_Address);

  function Index_Core
    (Array_Pointer : in Pointer_Array_t;
     Size          : in Natural;
     Index         : in Natural) return String
  is
    Address_Current : constant System.Address := Index_Address
      (Array_Pointer => Array_Pointer,
       Size          => Size,
       Index         => Index);
    Pointer         : Memory.Object_Pointer;
  begin
    Pointer := Memory.To_Pointer (Address_Current);
    if Pointer.all = null then
      return "";
    end if;
    return C_String.To_String (Pointer.all);
  end Index_Core;
  pragma Inline (Index_Core);

  function Index
    (Pointer : in Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return String is
  begin
    if Size <= Index then
      raise Constraint_Error with "Index out of range";
    end if;
    return Index_Core
      (Array_Pointer => Pointer,
       Size          => Size,
       Index         => Index);
  end Index;
  pragma Inline (Index);

  function Index
    (Pointer : in Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return UB_Strings.Unbounded_String is
  begin
    if Size <= Index then
      raise Constraint_Error with "Index out of range";
    end if;
    return UB_Strings.To_Unbounded_String
      (Index_Core
        (Array_Pointer => Pointer,
         Size          => Size,
         Index         => Index));
  end Index;
  pragma Inline (Index);

  function Index_Terminated
    (Pointer : in Pointer_Array_t;
     Index   : in Natural) return String
  is
    Size : constant Natural := Size_Terminated (Pointer);
  begin
    if Size <= Index then
      raise Constraint_Error with "Index out of range";
    end if;
    return Index_Core
      (Array_Pointer => Pointer,
       Size          => Size,
       Index         => Index);
  end Index_Terminated;
  pragma Inline (Index_Terminated);

  function Index_Terminated
    (Pointer : in Pointer_Array_t;
     Index   : in Natural) return UB_Strings.Unbounded_String
  is
    Size : constant Natural := Size_Terminated (Pointer);
  begin
    if Size <= Index then
      raise Constraint_Error with "Index out of range";
    end if;
    return UB_Strings.To_Unbounded_String
      (Index_Core
        (Array_Pointer => Pointer,
         Size          => Size,
         Index         => Index));
  end Index_Terminated;
  pragma Inline (Index_Terminated);

  function Index
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return String is
  begin
    return Arrays.Index
      (Pointer => Pointer_Array_t (Pointer),
       Size    => Size,
       Index   => Index);
  end Index;

  function Index
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return Ada.Strings.Unbounded.Unbounded_String is
  begin
    return Arrays.Index
      (Pointer => Pointer_Array_t (Pointer),
       Size    => Size,
       Index   => Index);
  end;

  function Index_Terminated
    (Pointer : in Allocated_Pointer_Array_t;
     Index   : in Natural) return String is
  begin
    return Index_Terminated
      (Pointer => Pointer_Array_t (Pointer),
       Index   => Index);
  end Index_Terminated;

  function Index_Terminated
    (Pointer : in Allocated_Pointer_Array_t;
     Index   : in Natural) return Ada.Strings.Unbounded.Unbounded_String is
  begin
    return Index_Terminated
      (Pointer => Pointer_Array_t (Pointer),
       Index   => Index);
  end Index_Terminated;

  --
  -- for (Index = 0; Index < Size; ++Index)
  --   output [Index] = Pointer [Index]
  --

  function Convert
    (Pointer : in Pointer_Array_t;
     Size    : in Natural) return String_Array_t
  is
    Table : String_Array_t (0 .. Size - 1);
  begin
    for Table_Index in Table'Range loop
      Table (Table_Index) := UB_Strings.To_Unbounded_String
        (Index_Core
          (Array_Pointer => Pointer,
           Size          => Size,
           Index         => Table_Index));
    end loop;
    return Table;
  end Convert;

  function Convert
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural) return String_Array_t is
  begin
    return Convert
      (Pointer => Pointer_Array_t (Pointer),
       Size    => Size);
  end Convert;

  --
  --
  --

  function Convert_To_C_Terminated
    (Strings : in String_Array_t) return Allocated_Pointer_Array_t is
  begin
    if Strings'Length = 0 then
      raise Length_Error;
    end if;

    declare
      type Table_t is array (Strings'First .. Strings'Last + 1) of String_Ptr_t;
      Pointer_Array : constant access Table_t := new Table_t;
    begin
      for Index in Pointer_Array.all'Range loop
        Pointer_Array.all (Index) := null;
      end loop;

      for Index in Pointer_Array.all'First .. Pointer_Array.all'Last - 1 loop
        declare
          New_String   : constant String                      := UB_Strings.To_String (Strings (Index));
          New_C_String : constant C.Strings.char_array_access := new C.char_array'(C.To_C (New_String));
        begin
          Pointer_Array.all (Index) := To_C_String (New_C_String);
        end;
      end loop;

      return Allocated_Pointer_Array_t (Pointer_Array.all (Strings'First)'Address);
    end;
  end Convert_To_C_Terminated;

  function Convert_To_C
    (Strings : in String_Array_t) return Allocated_Pointer_Array_t is
  begin
    if Strings'Length = 0 then
      raise Length_Error;
    end if;

    declare
      type Table_t is array (Strings'First .. Strings'Last) of String_Ptr_t;
      Pointer_Array : constant access Table_t := new Table_t;
    begin
      for Index in Pointer_Array.all'Range loop
        Pointer_Array.all (Index) := null;
      end loop;

      for Index in Pointer_Array.all'First .. Pointer_Array.all'Last - 1 loop
        declare
          New_String   : constant String                      := UB_Strings.To_String (Strings (Index));
          New_C_String : constant C.Strings.char_array_access := new C.char_array'(C.To_C (New_String));
        begin
          Pointer_Array.all (Index) := To_C_String (New_C_String);
        end;
      end loop;

      return Allocated_Pointer_Array_t (Pointer_Array.all (Strings'First)'Address);
    end;
  end Convert_To_C;

  procedure Deallocate_Terminated
    (Pointer : in Allocated_Pointer_Array_t) is
  begin
    null;
  end Deallocate_Terminated;

  procedure Deallocate
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural) is
  begin
    null;
  end Deallocate;

end C_String.Arrays;
