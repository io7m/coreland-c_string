with Ada.Text_IO;

package body test is
  package IO renames Ada.Text_IO;

  procedure sys_exit (ecode : integer);
  pragma Import (c, sys_exit, "exit");

  procedure assert
    (check        : in boolean;
     pass_message : in string := "assertion passed";
     fail_message : in string := "assertion failed") is
  begin
    if check then
      IO.Put_Line (IO.Current_Error, "pass: " & pass_message);
    else
      IO.Put_Line (IO.Current_Error, "fail: " & fail_message);
      sys_exit (1);
    end if;
  end assert;

end test;