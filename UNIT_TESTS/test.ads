package Test is

  procedure Assert
    (Check        : in Boolean;
     Pass_Message : in String := "Assertion passed";
     Fail_Message : in String := "Assertion failed");

end Test;
