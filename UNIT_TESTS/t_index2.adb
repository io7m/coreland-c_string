with Ada.Strings.Unbounded;
with Ada.Text_IO;
with C_String.Arrays;
with Interfaces.C;
with Test;

procedure t_Index2 is
  package c renames Interfaces.C;
  package IO renames Ada.Text_IO;
  package UStrings renames Ada.Strings.Unbounded;

  function ccall_size return c.int;
  pragma Import (c, ccall_size, "ccall_size");

  function ccall return C_String.Arrays.Pointer_Array_t;
  pragma Import (c, ccall, "ccall");
begin
  IO.Put_Line ("-- Ada begin");

  declare
    Address : constant C_String.Arrays.Pointer_Array_t := ccall;
  begin
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (Address, Index => 0, Size => Natural (ccall_size))) = "abcdefgh",
       Pass_Message => "Tab (0) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 0, Size => Natural (ccall_size))),
       Fail_Message => "Tab (0) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 0, Size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (Address, Index => 1, Size => Natural (ccall_size))) = "zyxwvuts",
       Pass_Message => "Tab (1) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 1, Size => Natural (ccall_size))),
       Fail_Message => "Tab (1) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 1, Size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (Address, Index => 2, Size => Natural (ccall_size))) = "12345678",
       Pass_Message => "Tab (2) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 2, Size => Natural (ccall_size))),
       Fail_Message => "Tab (2) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 2, Size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (Address, Index => 3, Size => Natural (ccall_size))) = "klmnopqr",
       Pass_Message => "Tab (3) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 3, Size => Natural (ccall_size))),
       Fail_Message => "Tab (3) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 3, Size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (Address, Index => 4, Size => Natural (ccall_size))) = "@@@@@@@@",
       Pass_Message => "Tab (4) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 4, Size => Natural (ccall_size))),
       Fail_Message => "Tab (4) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 4, Size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (Address, Index => 5, Size => Natural (ccall_size))) = "&&&&&&&&",
       Pass_Message => "Tab (5) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 5, Size => Natural (ccall_size))),
       Fail_Message => "Tab (5) = " & UStrings.To_String (C_String.Arrays.Index (Address, Index => 5, Size => Natural (ccall_size))));
  end;

  IO.Put_Line ("-- Ada exit");
end t_Index2;
