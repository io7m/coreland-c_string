with Ada.Text_IO;
with C_String.Arrays;
with Test;

procedure t_convert3 is
  package IO renames Ada.Text_IO;

  SA    : constant C_String.Arrays.String_Array_t (1 .. 0) := (others => <>);
  PA    : C_String.Arrays.Allocated_Pointer_Array_t;
  Error : Boolean;

begin
  IO.Put_Line ("-- Ada begin");

  begin
    Error := False;
    PA    := C_String.Arrays.Convert_To_C_Terminated (SA);
    pragma Assert (PA'Size > 0);
  exception
    when C_String.Arrays.Length_Error => Error := True;
  end;

  Test.Assert (Error);

  IO.Put_Line ("-- Ada exit");
end t_convert3;
