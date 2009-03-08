package test is

  procedure assert
    (check        : in Boolean;
     pass_message : in String := "assertion passed";
     fail_message : in String := "assertion failed");

end test;
