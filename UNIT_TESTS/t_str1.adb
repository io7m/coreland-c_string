with C_String;
with Interfaces.C;
with test;

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
  caught       : boolean := false;

begin
  terminated := term1;
  length := C_String.Length (terminated);

  -- check conversion of terminated C strings to Ada strings.

  test.assert
    (check        => length = hello_length,
     pass_message => "term1 Length = " & C.size_t'Image (length),
     fail_message => "term1 Length = " & C.size_t'Image (length));

  declare
    Result : constant string := C_String.To_String (terminated);
  begin
    test.assert
      (check        => Result'Length = hello_length,
       pass_message => "term1 Result'Length = " & integer'Image (Result'Length),
       fail_message => "term1 Result'Length = " & integer'Image (Result'Length));
    test.assert
      (check        => Result = "hello",
       pass_message => "term1 Result = " & Result,
       fail_message => "term1 Result = " & Result);
  end;

  -- check conversion of unterminated C char arrays to Ada strings.

  unterm1 (unterminated, size);
  test.assert
    (check        => size = 5,
     pass_message => "unterm1 size = 5",
     fail_message => "unterm1 size = " & C.size_t'Image (size));

  declare
    Result : constant string := C_String.To_String (unterminated, size);
  begin
    test.assert
      (check        => Result'Length = hello_length,
       pass_message => "unterm1 Result'Length = " & integer'Image (Result'Length),
       fail_message => "unterm1 Result'Length = " & integer'Image (Result'Length));
    test.assert
      (check        => Result = "hello",
       pass_message => "unterm1 Result = " & Result,
       fail_message => "unterm1 Result = " & Result);
  end;

  -- check creation of terminated C strings.

  declare
    C_Array : aliased C.char_array := C.To_C ("hello", Append_Nul => True);
    C_Term  : constant C_String.String_Ptr_t := C_String.To_C_String (C_Array'Unchecked_Access);
    Result  : constant string := C_String.To_String (C_Term);
  begin
    term2 (C_Term);
    test.assert
      (check        => Result'Length = 5,
       pass_message => "term2 Result'Length = " & integer'Image (Result'Length),
       fail_message => "term2 Result'Length = " & integer'Image (Result'Length));
    test.assert
      (check        => Result = "hello",
       pass_message => "term2 Result = " & Result,
       fail_message => "term2 Result = " & Result);
  end;

  -- check creation of unterminated character arrays.

  declare
    Source   : constant string := "hello" & ASCII.nul & "hello";
    C_Array  : aliased C.char_array := C.To_C (Source, Append_Nul => False);
    C_Unterm : constant C_String.Char_Array_Ptr_t := C_String.To_C_Char_Array (C_Array'Unchecked_Access);
    Result   : constant string := C_String.To_String (C_Unterm, C_Array'Length);
  begin
    unterm2 (C_Unterm, C_Array'Length);
    test.assert
      (check        => Result'Length = Source'Length,
       pass_message => "term2 Result'Length = " & integer'Image (Result'Length),
       fail_message => "term2 Result'Length = " & integer'Image (Result'Length));
    test.assert
      (check        => Result = Source,
       pass_message => "term2 Result = " & Result,
       fail_message => "term2 Result = " & Result);
  end;

  -- check null termination error

  caught := false;
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
      caught := true;
  end;

  test.assert
    (check        => caught,
     pass_message => "caught null_termination_error",
     fail_message => "failed to catch null_termination_error");

end t_str1;
