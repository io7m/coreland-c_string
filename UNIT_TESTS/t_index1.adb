with Ada.Strings.Unbounded;
with Ada.Text_IO;
with C_String.Arrays;
with Test;

procedure t_Index1 is
  package IO renames Ada.Text_IO;
  package UStrings renames Ada.Strings.Unbounded;

  function ccall return C_String.Arrays.Pointer_Array_t;
  pragma Import (c, ccall, "ccall");
begin
  IO.Put_Line ("-- Ada begin");

  declare
    Address : constant C_String.Arrays.Pointer_Array_t := ccall;
    Caught  : Boolean := False;
  begin
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 0)) = "abcdefgh",
       Pass_Message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 0)),
       Fail_Message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 0)));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 1)) = "zyxwvuts",
       Pass_Message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 1)),
       Fail_Message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 1)));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 2)) = "12345678",
       Pass_Message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 2)),
       Fail_Message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 2)));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 3)) = "klmnopqr",
       Pass_Message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 3)),
       Fail_Message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 3)));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 4)) = "@@@@@@@@",
       Pass_Message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 4)),
       Fail_Message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 4)));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 5)) = "&&&&&&&&",
       Pass_Message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 5)),
       Fail_Message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index_Terminated (Address, 5)));

    -- Out of range.
    begin
      IO.Put_Line (C_String.Arrays.Index_Terminated (Address, 6));
    exception
      when Constraint_Error => Caught := True;
    end;

    Test.Assert
      (Check        => Caught,
       Pass_Message => "caught invalid index",
       Fail_Message => "failed to catch invalid index");
  end;

  IO.Put_Line ("-- Ada exit");
end t_Index1;
