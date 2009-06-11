with C_String;
with Interfaces.C;
with Test;

procedure t_str1 is
  package C renames Interfaces.C;

  use type C.size_t;

  function term1 return C_String.String_Ptr_t;
  pragma Import (C, term1, "cstr_terminated1");

  procedure term2
    (Str : in C_String.String_Ptr_t);
  pragma Import (C, term2, "cstr_terminated2");

  procedure unterm1
    (Str  : out C_String.Char_Array_Ptr_t;
     Size : out C.size_t);
  pragma Import (C, unterm1, "cstr_unterminated1");

  procedure unterm2
    (Str  : in C_String.Char_Array_Ptr_t;
     Size : in C.size_t);
  pragma Import (C, unterm2, "cstr_unterminated2");

  Terminated   : C_String.String_Ptr_t;
  Unterminated : C_String.Char_Array_Ptr_t;
  Size         : aliased C.size_t;
  Hello_Length : constant := 5;
  Length       : C.size_t;
  Caught       : Boolean := False;

begin
  Terminated := term1;
  Length := C_String.Length (Terminated);

  -- Check conversion of terminated C strings to Ada strings.

  Test.Assert
    (Check        => Length = Hello_Length,
     Pass_Message => "term1 Length = " & C.size_t'Image (Length),
     Fail_Message => "term1 Length = " & C.size_t'Image (Length));

  declare
    Result : constant String := C_String.To_String (Terminated);
  begin
    Test.Assert
      (Check        => Result'Length = Hello_Length,
       Pass_Message => "term1 Result'Length = " & Integer'Image (Result'Length),
       Fail_Message => "term1 Result'Length = " & Integer'Image (Result'Length));
    Test.Assert
      (Check        => Result = "hello",
       Pass_Message => "term1 Result = " & Result,
       Fail_Message => "term1 Result = " & Result);
  end;

  -- Check conversion of unterminated C char arrays to Ada strings.

  unterm1 (Unterminated, Size);
  Test.Assert
    (Check        => Size = 5,
     Pass_Message => "unterm1 size = 5",
     Fail_Message => "unterm1 size = " & C.size_t'Image (Size));

  declare
    Result : constant String := C_String.To_String (Unterminated, Size);
  begin
    Test.Assert
      (Check        => Result'Length = Hello_Length,
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
    Source   : constant String := "hello" & ASCII.NUL & "hello";
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

  Caught := False;
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
    when C_String.Null_Termination_Error => Caught := True;
  end;

  Test.Assert
    (Check        => Caught,
     Pass_Message => "caught null_termination_error",
     Fail_Message => "failed to catch null_termination_error");

end t_str1;
