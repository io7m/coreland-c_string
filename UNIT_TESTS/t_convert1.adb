with Ada.Strings.Unbounded;
with Ada.Text_IO;
with C_String.Arrays;
with Test;

procedure t_convert1 is
  package IO renames Ada.Text_IO;
  package UStrings renames Ada.Strings.Unbounded;

  function ccall return C_String.Arrays.Pointer_Array_t;
  pragma Import (c, ccall, "ccall");
begin
  IO.Put_Line ("-- Ada begin");

  declare
    address : constant C_String.Arrays.Pointer_Array_t := ccall;
    tab     : constant C_String.Arrays.String_Array_t :=
      C_String.Arrays.Convert
        (pointer => address,
         size    => C_String.Arrays.Size_Terminated (address));
  begin
    Test.Assert
      (Check        =>  UStrings.To_String (tab (0)) = "abcdefgh",
       Pass_Message => "tab (0) = " & UStrings.To_String (tab (0)),
       Fail_Message => "tab (0) = " & UStrings.To_String (tab (0)));
    Test.Assert
      (Check        =>  UStrings.To_String (tab (1)) = "zyxwvuts",
       Pass_Message => "tab (1) = " & UStrings.To_String (tab (1)),
       Fail_Message => "tab (1) = " & UStrings.To_String (tab (1)));
    Test.Assert
      (Check        =>  UStrings.To_String (tab (2)) = "12345678",
       Pass_Message => "tab (2) = " & UStrings.To_String (tab (2)),
       Fail_Message => "tab (2) = " & UStrings.To_String (tab (2)));
    Test.Assert
      (Check        =>  UStrings.To_String (tab (3)) = "klmnopqr",
       Pass_Message => "tab (3) = " & UStrings.To_String (tab (3)),
       Fail_Message => "tab (3) = " & UStrings.To_String (tab (3)));
    Test.Assert
      (Check        =>  UStrings.To_String (tab (4)) = "@@@@@@@@",
       Pass_Message => "tab (4) = " & UStrings.To_String (tab (4)),
       Fail_Message => "tab (4) = " & UStrings.To_String (tab (4)));
    Test.Assert
      (Check        =>  UStrings.To_String (tab (5)) = "&&&&&&&&",
       Pass_Message => "tab (5) = " & UStrings.To_String (tab (5)),
       Fail_Message => "tab (5) = " & UStrings.To_String (tab (5)));
  end;

  IO.Put_Line ("-- Ada exit");
end t_convert1;
