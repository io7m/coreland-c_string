with Ada.Text_IO;

package body Test is
  package IO renames Ada.Text_IO;

  procedure Sys_Exit (Code : Integer);
  pragma Import (c, Sys_Exit, "exit");

  procedure Assert
    (Check        : in Boolean;
     Pass_Message : in String := "Assertion passed";
     Fail_Message : in String := "Assertion failed") is
  begin
    if Check then
      IO.Put_Line (IO.Current_Error, "pass: " & Pass_Message);
    else
      IO.Put_Line (IO.Current_Error, "fail: " & Fail_Message);
      Sys_Exit (1);
    end if;
  end Assert;

end Test;
