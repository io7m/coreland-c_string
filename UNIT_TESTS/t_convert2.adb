with Ada.Strings.Unbounded;
with Ada.Text_IO;
with C_String.Arrays;
with Interfaces.C;
with Test;

procedure t_convert2 is
  package IO         renames Ada.Text_IO;
  package UB_Strings renames Ada.Strings.Unbounded;
  package C          renames Interfaces.C;

  use type C.unsigned;

  function ccall_input_term (Strings : in C_String.Arrays.Allocated_Pointer_Array_t)
    return C.unsigned;
  pragma Import (c, ccall_input_term, "ccall_input_term");

  SA : constant C_String.Arrays.String_Array_t :=
    (0 => UB_Strings.To_Unbounded_String ("string 0"),
     1 => UB_Strings.To_Unbounded_String ("string 1"),
     2 => UB_Strings.To_Unbounded_String ("string 2"),
     3 => UB_Strings.To_Unbounded_String ("string 3"),
     4 => UB_Strings.To_Unbounded_String ("string 4"));

  PA : C_String.Arrays.Allocated_Pointer_Array_t;

begin
  IO.Put_Line ("-- Ada begin");

  PA := C_String.Arrays.Convert_Terminated (SA);
  Test.Assert (ccall_input_term (PA) = 5);
  C_String.Arrays.Deallocate_Terminated (PA);

  PA := C_String.Arrays.Convert_Terminated (SA (2 .. 3));
  Test.Assert (ccall_input_term (PA) = 2);
  C_String.Arrays.Deallocate_Terminated (PA);

  PA := C_String.Arrays.Convert_Terminated (SA (3 .. 4));
  Test.Assert (ccall_input_term (PA) = 2);
  C_String.Arrays.Deallocate_Terminated (PA);

  IO.Put_Line ("-- Ada exit");
end t_convert2;
