with Ada.Text_IO;
with C_String;
with Interfaces.C;
with Test;

procedure t_assume is
  package IO renames Ada.Text_IO;
  package C  renames Interfaces.C;

  use type C.int;

  function ccall_assume (Value : C_String.String_Ptr_t) return C.int;
  pragma Import (c, ccall_assume, "ccall_assume");
begin
  IO.Put_Line ("-- Ada begin");

  Test.Assert
    (Check        => ccall_assume (null) = 1,
     Pass_Message => "null  = String_Ptr'(null)",
     Fail_Message => "null /= String_Ptr'(null)");

  IO.Put_Line ("-- Ada exit");
end t_assume;
