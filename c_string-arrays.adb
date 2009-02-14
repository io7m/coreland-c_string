with System.Storage_Elements;
with System.Address_To_Access_Conversions;

package body C_String.Arrays is
  package Storage_Elements renames System.Storage_Elements;
  package UStrings renames Ada.Strings.Unbounded;

  package Memory is new System.Address_To_Access_Conversions
    (object => C_String.String_t);

  use type C_String.String_t;
  use type Memory.Object_Pointer;
  use type System.Storage_Elements.Storage_Offset;

  Word_Size : constant := System.Word_Size / System.Storage_Unit;

  --
  -- iterate over an array of Pointers, checking for null
  --

  function Size_Terminated
    (Pointer : Pointer_Array_t) return natural
  is
    Current_Address : System.Address := Pointer;
    Obj_Pointer     : Memory.Object_Pointer;
    Size            : natural := 0;
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

  --
  -- array_ptr [Index]
  --

  function Index_Core
    (array_ptr : Pointer_Array_t;
     Size      : natural;
     Index     : natural) return string
  is
    Address_Offset  : constant Storage_Elements.Storage_Offset :=
      Storage_Elements.Storage_Offset (Index * Word_Size);
    Address_Base    : constant System.Address := array_ptr;
    Address_Current : constant System.Address := Address_Base + Address_Offset;
    Pointer   : Memory.Object_Pointer;
  begin
    Pointer := Memory.To_Pointer (Address_Current);
    if Pointer.all = null then
      return "";
    end if;
    return C_String.To_String (Pointer.all);
  end Index_Core;
  pragma Inline (Index_Core);

  function Index
    (Pointer : Pointer_Array_t;
     Size    : natural;
     Index   : natural) return string is
  begin
    if Size <= Index then
      raise Constraint_Error with "Index out of range";
    end if;
    return Index_Core
      (array_ptr => Pointer,
       Size      => Size,
       Index     => Index);
  end Index;
  pragma Inline (Index);

  function Index
    (Pointer : Pointer_Array_t;
     Size    : natural;
     Index : natural) return UStrings.Unbounded_String is
  begin
    if Size <= Index then
      raise Constraint_Error with "Index out of range";
    end if;
    return UStrings.To_Unbounded_String
      (Index_Core
        (array_ptr => Pointer,
         Size      => Size,
         Index     => Index));
  end Index;
  pragma Inline (Index);

  function Index_Terminated
    (Pointer : Pointer_Array_t;
     Index   : natural) return string is
  begin
    return Index_Core
      (array_ptr => Pointer,
       Size      => Size_Terminated (Pointer),
       Index     => Index);
  end Index_Terminated;
  pragma Inline (Index_Terminated);

  function Index_Terminated
    (Pointer : Pointer_Array_t;
     Index   : natural) return UStrings.Unbounded_String is
  begin
    return UStrings.To_Unbounded_String
      (Index_Core
        (array_ptr => Pointer,
         Size      => Size_Terminated (Pointer),
         Index     => Index));
  end Index_Terminated;
  pragma Inline (Index_Terminated);

  --
  -- for (Index = 0; Index < Size; ++Index)
  --   output [Index] = Pointer [Index]
  --

  function Convert
    (Pointer : Pointer_Array_t;
     Size    : natural) return String_Array_t
  is
    Table : String_Array_t (0 .. Size - 1);
  begin
    for Table_Index in Table'Range loop
      Table (Table_Index) := UStrings.To_Unbounded_String
        (Index_Core
          (array_ptr => Pointer,
           Size      => Size,
           Index     => Table_Index));
    end loop;
    return Table;
  end Convert;

end C_String.Arrays;
