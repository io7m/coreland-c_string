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
    Address : constant C_String.Arrays.Pointer_Array_t := ccall;
    Tab     : constant C_String.Arrays.String_Array_t :=
      C_String.Arrays.Convert
        (Pointer => Address,
         Size    => C_String.Arrays.Size_Terminated (Address));
  begin
    Test.Assert
      (Check        =>  UStrings.To_String (Tab (0)) = "abcdefgh",
       Pass_Message => "Tab (0) = " & UStrings.To_String (Tab (0)),
       Fail_Message => "Tab (0) = " & UStrings.To_String (Tab (0)));
    Test.Assert
      (Check        =>  UStrings.To_String (Tab (1)) = "zyxwvuts",
       Pass_Message => "Tab (1) = " & UStrings.To_String (Tab (1)),
       Fail_Message => "Tab (1) = " & UStrings.To_String (Tab (1)));
    Test.Assert
      (Check        =>  UStrings.To_String (Tab (2)) = "12345678",
       Pass_Message => "Tab (2) = " & UStrings.To_String (Tab (2)),
       Fail_Message => "Tab (2) = " & UStrings.To_String (Tab (2)));
    Test.Assert
      (Check        =>  UStrings.To_String (Tab (3)) = "klmnopqr",
       Pass_Message => "Tab (3) = " & UStrings.To_String (Tab (3)),
       Fail_Message => "Tab (3) = " & UStrings.To_String (Tab (3)));
    Test.Assert
      (Check        =>  UStrings.To_String (Tab (4)) = "@@@@@@@@",
       Pass_Message => "Tab (4) = " & UStrings.To_String (Tab (4)),
       Fail_Message => "Tab (4) = " & UStrings.To_String (Tab (4)));
    Test.Assert
      (Check        =>  UStrings.To_String (Tab (5)) = "&&&&&&&&",
       Pass_Message => "Tab (5) = " & UStrings.To_String (Tab (5)),
       Fail_Message => "Tab (5) = " & UStrings.To_String (Tab (5)));
  end;

  IO.Put_Line ("-- Ada exit");
end t_convert1;
