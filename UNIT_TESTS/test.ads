package test is

  procedure assert
    (check        : in boolean;
     pass_message : in string := "assertion passed";
     fail_message : in string := "assertion failed");

end test;
