with Ada.Text_IO;
with C_String.Arrays;
with test;

procedure t_size1 is
  package IO renames Ada.Text_IO;

  function ccall return C_String.Arrays.Pointer_Array_t;
  pragma Import (c, ccall, "ccall");
begin
  IO.Put_Line ("-- Ada begin");

  test.assert
    (check        => C_String.Arrays.Size_Terminated (ccall) = 6,
     pass_message => "size " & Natural'Image (C_String.Arrays.Size_Terminated (ccall)) & " = 6",
     fail_message => "size " & Natural'Image (C_String.Arrays.Size_Terminated (ccall)) & " = 6");

  IO.Put_Line ("-- Ada exit");
end t_size1;
