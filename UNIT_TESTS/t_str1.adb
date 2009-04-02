with C_String;
with Interfaces.C;
with Test;

procedure t_str1 is
  package C renames Interfaces.C;

  use type C.size_t;

  function term1 return C_String.String_Ptr_t;
  pragma Import (C, term1, "cstr_terminated1");

  procedure term2
    (str : in C_String.String_Ptr_t);
  pragma Import (C, term2, "cstr_terminated2");

  procedure unterm1
    (str  : out C_String.Char_Array_Ptr_t;
     size : out C.size_t);
  pragma Import (C, unterm1, "cstr_unterminated1");

  procedure unterm2
    (str  : in C_String.Char_Array_Ptr_t;
     size : in C.size_t);
  pragma Import (C, unterm2, "cstr_unterminated2");

  terminated   : C_String.String_Ptr_t;
  unterminated : C_String.Char_Array_Ptr_t;
  size         : aliased C.size_t;
  hello_length : constant := 5;
  length       : C.size_t;
  caught       : Boolean := False;

begin
  terminated := term1;
  length := C_String.Length (terminated);

  -- Check conversion of terminated C strings to Ada strings.

  Test.Assert
    (Check        => length = hello_length,
     Pass_Message => "term1 Length = " & C.size_t'Image (length),
     Fail_Message => "term1 Length = " & C.size_t'Image (length));

  declare
    Result : constant String := C_String.To_String (terminated);
  begin
    Test.Assert
      (Check        => Result'Length = hello_length,
       Pass_Message => "term1 Result'Length = " & Integer'Image (Result'Length),
       Fail_Message => "term1 Result'Length = " & Integer'Image (Result'Length));
    Test.Assert
      (Check        => Result = "hello",
       Pass_Message => "term1 Result = " & Result,
       Fail_Message => "term1 Result = " & Result);
  end;

  -- Check conversion of unterminated C char arrays to Ada strings.

  unterm1 (unterminated, size);
  Test.Assert
    (Check        => size = 5,
     Pass_Message => "unterm1 size = 5",
     Fail_Message => "unterm1 size = " & C.size_t'Image (size));

  declare
    Result : constant String := C_String.To_String (unterminated, size);
  begin
    Test.Assert
      (Check        => Result'Length = hello_length,
       Pass_Message => "unterm1 Result'Length = " & Integer'Image (Result'Length),
       Fail_Message => "unterm1 Result'Length = " & Integer'Image (Result'Length));
    Test.Assert
      (Check        => Result = "hello",
       Pass_Message => "unterm1 Result = " & Result,
       Fail_Message => "unterm1 Result = " & Result);
  end;

  -- Check creation of terminated C strings.

  declare
    C_Array : aliased C.char_array := C.To_C ("hello", Append_Nul => True);
    C_Term  : constant C_String.String_Ptr_t := C_String.To_C_String (C_Array'Unchecked_Access);
    Result  : constant String := C_String.To_String (C_Term);
  begin
    term2 (C_Term);
    Test.Assert
      (Check        => Result'Length = 5,
       Pass_Message => "term2 Result'Length = " & Integer'Image (Result'Length),
       Fail_Message => "term2 Result'Length = " & Integer'Image (Result'Length));
    Test.Assert
      (Check        => Result = "hello",
       Pass_Message => "term2 Result = " & Result,
       Fail_Message => "term2 Result = " & Result);
  end;

  -- Check creation of unterminated character arrays.

  declare
    Source   : constant String := "hello" & ASCII.nul & "hello";
    C_Array  : aliased C.char_array := C.To_C (Source, Append_Nul => False);
    C_Unterm : constant C_String.Char_Array_Ptr_t := C_String.To_C_Char_Array (C_Array'Unchecked_Access);
    Result   : constant String := C_String.To_String (C_Unterm, C_Array'Length);
  begin
    unterm2 (C_Unterm, C_Array'Length);
    Test.Assert
      (Check        => Result'Length = Source'Length,
       Pass_Message => "term2 Result'Length = " & Integer'Image (Result'Length),
       Fail_Message => "term2 Result'Length = " & Integer'Image (Result'Length));
    Test.Assert
      (Check        => Result = Source,
       Pass_Message => "term2 Result = " & Result,
       Fail_Message => "term2 Result = " & Result);
  end;

  -- Check null termination error

  caught := False;
  begin
    declare
      C_Array : aliased C.char_array := C.To_C ("hello", Append_Nul => False);
      pragma Warnings (off);
      C_Term  : constant C_String.String_Ptr_t := C_String.To_C_String (C_Array'Unchecked_Access);
      pragma Warnings (on);
    begin
      null;
    end;
  exception
    when C_String.Null_Termination_Error =>
      caught := True;
  end;

  Test.Assert
    (Check        => caught,
     Pass_Message => "caught null_termination_error",
     Fail_Message => "failed to catch null_termination_error");

end t_str1;
