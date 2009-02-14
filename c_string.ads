with Interfaces.C;
with Interfaces.C.Strings;

package C_String is

  type String_t is access all Interfaces.C.char;
  pragma Convention (C, String_t);
  pragma No_Strict_Aliasing (String_t);

  type Char_Array_t is access all Interfaces.C.char;
  pragma Convention (C, Char_Array_t);
  pragma No_Strict_Aliasing (Char_Array_t);

  subtype String_Not_Null_t is not null String_t;
  subtype Char_Array_Not_Null_t is not null Char_Array_t;

  --
  -- Convert terminated or unterminated C string to Ada string.
  --

  function To_String
    (Item : in String_Not_Null_t) return string;
  function To_String
    (Item : in Char_Array_Not_Null_t;
     Size : in Interfaces.C.size_t) return string;

  --
  -- Convert Ada string to terminated or unterminated Ada string.
  --

  function To_C_String
    (Item : in not null Interfaces.C.Strings.char_array_access) return String_t;
  function To_C_Char_Array
    (Item : in not null Interfaces.C.Strings.char_array_access) return Char_Array_t;

  --
  -- Fetch character 'Index' from C string.
  --

  function Index
    (Item  : in String_Not_Null_t;
     Index : in Interfaces.C.size_t) return Interfaces.C.char;
  function Index
    (Item  : in Char_Array_Not_Null_t;
     Size  : in Interfaces.C.size_t;
     Index : in Interfaces.C.size_t) return Interfaces.C.char;

  --
  -- Get length of terminated C string.
  --

  function Length
    (Item : in String_Not_Null_t) return Interfaces.C.size_t;

  Null_Termination_Error : exception;

end C_String;
