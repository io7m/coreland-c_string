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
    address : constant C_String.Arrays.Pointer_Array_t := ccall;
  begin
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 0, size => Natural (ccall_size))) = "abcdefgh",
       Pass_Message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 0, size => Natural (ccall_size))),
       Fail_Message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 0, size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 1, size => Natural (ccall_size))) = "zyxwvuts",
       Pass_Message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 1, size => Natural (ccall_size))),
       Fail_Message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 1, size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 2, size => Natural (ccall_size))) = "12345678",
       Pass_Message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 2, size => Natural (ccall_size))),
       Fail_Message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 2, size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 3, size => Natural (ccall_size))) = "klmnopqr",
       Pass_Message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 3, size => Natural (ccall_size))),
       Fail_Message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 3, size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 4, size => Natural (ccall_size))) = "@@@@@@@@",
       Pass_Message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 4, size => Natural (ccall_size))),
       Fail_Message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 4, size => Natural (ccall_size))));
    Test.Assert
      (Check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 5, size => Natural (ccall_size))) = "&&&&&&&&",
       Pass_Message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 5, size => Natural (ccall_size))),
       Fail_Message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 5, size => Natural (ccall_size))));
  end;

  IO.Put_Line ("-- Ada exit");
end t_Index2;
