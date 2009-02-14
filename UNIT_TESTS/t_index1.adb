with Ada.Strings.Unbounded;
with Ada.Text_IO;
with C_String.Arrays;
with test;

procedure t_Index1 is
  package IO renames Ada.Text_IO;
  package UStrings renames Ada.Strings.Unbounded;

  function ccall return C_String.Arrays.Pointer_Array_t;
  pragma Import (c, ccall, "ccall");
begin
  IO.Put_Line ("-- Ada begin");

  declare
    address : constant C_String.Arrays.Pointer_Array_t := ccall;
  begin
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (address, 0)) = "abcdefgh",
       pass_message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 0)),
       fail_message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 0)));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (address, 1)) = "zyxwvuts",
       pass_message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 1)),
       fail_message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 1)));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (address, 2)) = "12345678",
       pass_message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 2)),
       fail_message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 2)));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (address, 3)) = "klmnopqr",
       pass_message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 3)),
       fail_message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 3)));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (address, 4)) = "@@@@@@@@",
       pass_message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 4)),
       fail_message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 4)));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (address, 5)) = "&&&&&&&&",
       pass_message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 5)),
       fail_message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (address, 5)));
  end;

  IO.Put_Line ("-- Ada exit");
end t_Index1;
