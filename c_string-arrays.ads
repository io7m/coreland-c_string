with Ada.Strings.Unbounded;
with System;

package C_String.Arrays is

  subtype Pointer_Array_t is System.Address;
  null_ptr : constant Pointer_Array_t := System.Null_Address;

  type String_Array_t is array (Natural range <>) of
    Ada.Strings.Unbounded.Unbounded_String;

  --
  -- find NULL
  --

  function Size_Terminated
    (Pointer : Pointer_Array_t) return Natural;

  --
  -- array_ptr [Index]
  --

  function Index
    (Pointer : Pointer_Array_t;
     Size    : Natural;
     Index   : Natural) return String;

  function Index
    (Pointer : Pointer_Array_t;
     Size    : Natural;
     Index   : Natural) return Ada.Strings.Unbounded.Unbounded_String;

  function Index_Terminated
    (Pointer : Pointer_Array_t;
     Index   : Natural) return String;

  function Index_Terminated
    (Pointer : Pointer_Array_t;
     Index   : Natural) return Ada.Strings.Unbounded.Unbounded_String;

  --
  -- for (Index = 0; Index < Size; ++Index)
  --   output [Index] = Pointer [Index]
  --

  function Convert
    (Pointer : Pointer_Array_t;
     Size    : Natural) return String_Array_t;

end C_String.Arrays;
