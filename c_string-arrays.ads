with Ada.Strings.Unbounded;
with System;

package C_String.Arrays is

  subtype Pointer_Array_t is System.Address;
  null_ptr : constant Pointer_Array_t := System.Null_Address;

  type String_Array_t is array (Natural range <>) of
    Ada.Strings.Unbounded.Unbounded_String;

  type Allocated_Pointer_Array_t is new Pointer_Array_t;

  Length_Error : exception;

  --
  -- Find NULL
  --

  function Size_Terminated
    (Pointer : in Pointer_Array_t) return Natural;

  function Size_Terminated
    (Pointer : in Allocated_Pointer_Array_t) return Natural;

  --
  -- array_ptr [Index]
  --

  function Index
    (Pointer : in Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return String;

  function Index
    (Pointer : in Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return Ada.Strings.Unbounded.Unbounded_String;

  function Index_Terminated
    (Pointer : in Pointer_Array_t;
     Index   : in Natural) return String;

  function Index_Terminated
    (Pointer : in Pointer_Array_t;
     Index   : in Natural) return Ada.Strings.Unbounded.Unbounded_String;

  function Index
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return String;

  function Index
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural;
     Index   : in Natural) return Ada.Strings.Unbounded.Unbounded_String;

  function Index_Terminated
    (Pointer : in Allocated_Pointer_Array_t;
     Index   : in Natural) return String;

  function Index_Terminated
    (Pointer : in Allocated_Pointer_Array_t;
     Index   : in Natural) return Ada.Strings.Unbounded.Unbounded_String;

  --
  -- for (Index = 0; Index < Size; ++Index)
  --   output [Index] = Pointer [Index]
  --

  function Convert
    (Pointer : in Pointer_Array_t;
     Size    : in Natural) return String_Array_t;

  function Convert
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural) return String_Array_t;

  --
  -- Convert Ada -> C
  --

  function Convert_Terminated
    (Strings : in String_Array_t) return Allocated_Pointer_Array_t;

  function Convert
    (Strings : in String_Array_t) return Allocated_Pointer_Array_t;

  procedure Deallocate_Terminated
    (Pointer : in Allocated_Pointer_Array_t);

  procedure Deallocate
    (Pointer : in Allocated_Pointer_Array_t;
     Size    : in Natural);

end C_String.Arrays;
