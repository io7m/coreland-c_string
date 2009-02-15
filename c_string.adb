with Ada.Unchecked_Conversion;
with System.Storage_Elements;
with System;

package body C_String is
  package C renames Interfaces.C;
  package Storage_Elements renames System.Storage_Elements;

  use type C.char;
  use type C.size_t;
  use type Storage_Elements.Storage_Offset;
  use type System.Address;

  function To_Address is new Ada.Unchecked_Conversion
    (source => Char_Array_Ptr_t, Target => System.Address);

  function To_C_String is new Ada.Unchecked_Conversion
    (source => System.Address, Target => Char_Array_Ptr_t);
  function To_C_String is new Ada.Unchecked_Conversion
    (source => System.Address, Target => String_Ptr_t);

  --
  -- Item [Index], without checking for terminating null.
  --

  function Unsafe_Index
    (Item  : in Char_Array_Not_Null_Ptr_t;
     Index : in C.size_t) return C.char
  is
    Base_Address : constant System.Address := To_Address (Item);
    Offset       : constant Storage_Elements.Storage_Offset :=
                     Storage_Elements.Storage_Offset (Index);
    New_Address  : constant System.Address := Base_Address + Offset;
    New_Ptr      : constant Char_Array_Ptr_t := To_C_String (New_Address);
  begin
    return New_Ptr.all;
  end Unsafe_Index;
  pragma Inline (Unsafe_Index);

  function To_String
    (Item : String_Not_Null_Ptr_t) return string
  is
    Result : string (1 .. integer (Length (Item)));
  begin
    for I in Result'Range loop
      Result (I) := C.To_Ada (Unsafe_Index
        (Char_Array_Not_Null_Ptr_t (Item), C.size_t (I - 1)));
    end loop;
    return Result;
  end To_String;

  function To_String
    (Item : Char_Array_Not_Null_Ptr_t;
     Size : in C.size_t) return string
  is
    Result : string (1 .. integer (Size));
  begin
    for I in Result'Range loop
      Result (I) := C.To_Ada (Unsafe_Index (Item, C.size_t (I - 1)));
    end loop;
    return Result;
  end To_String;

  function Has_Null (Item : C.char_array) return boolean is
  begin
    for I in Item'Range loop
      if Item (I) = C.nul then
        return true;
      end if;
    end loop;
    return false;
  end Has_Null;

  function To_C_String
    (Item : not null C.Strings.char_array_access) return String_Ptr_t is
  begin
    if Has_Null (Item.all) then
      return To_C_String (Item (Item'First)'Address);
    else
      raise Null_Termination_Error;
    end if;
  end To_C_String;

  function To_C_Char_Array
    (Item : not null C.Strings.char_array_access) return Char_Array_Ptr_t is
  begin
    return To_C_String (Item (Item'First)'Address);
  end To_C_Char_Array;

  function Index
    (Item  : in String_Not_Null_Ptr_t;
     Index : in C.size_t) return C.char is
  begin
    if Index >= Length (Item) then
      raise Constraint_Error with "index out of range";
    end if;
    return Unsafe_Index (Char_Array_Not_Null_Ptr_t (Item), Index);
  end Index;

  function Index
    (Item  : in Char_Array_Not_Null_Ptr_t;
     Size  : in C.size_t;
     Index : in C.size_t) return C.char is
  begin
    if Index >= Size then
      raise Constraint_Error with "index out of range";
    end if;
    return Unsafe_Index (Item, Index);
  end Index;

  function Length
    (Item : String_Not_Null_Ptr_t) return C.size_t
  is
    char : C.char;
  begin
    for I in C.size_t'Range loop
      char := Unsafe_Index (Char_Array_Not_Null_Ptr_t (Item), I);
      if char = C.nul then
        return I;
      end if;
    end loop;
    raise Constraint_Error with "no terminating null found";
  end Length;

end C_String;
