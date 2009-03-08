with Ada.Strings.Unbounded;
with Ada.Text_IO;
with C_String.Arrays;
with Interfaces.C;
with test;

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
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 0, size => Natural (ccall_size))) = "abcdefgh",
       pass_message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 0, size => Natural (ccall_size))),
       fail_message => "tab (0) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 0, size => Natural (ccall_size))));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 1, size => Natural (ccall_size))) = "zyxwvuts",
       pass_message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 1, size => Natural (ccall_size))),
       fail_message => "tab (1) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 1, size => Natural (ccall_size))));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 2, size => Natural (ccall_size))) = "12345678",
       pass_message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 2, size => Natural (ccall_size))),
       fail_message => "tab (2) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 2, size => Natural (ccall_size))));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 3, size => Natural (ccall_size))) = "klmnopqr",
       pass_message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 3, size => Natural (ccall_size))),
       fail_message => "tab (3) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 3, size => Natural (ccall_size))));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 4, size => Natural (ccall_size))) = "@@@@@@@@",
       pass_message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 4, size => Natural (ccall_size))),
       fail_message => "tab (4) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 4, size => Natural (ccall_size))));
    test.assert
      (check        =>  UStrings.To_String (C_String.Arrays.Index (address, Index => 5, size => Natural (ccall_size))) = "&&&&&&&&",
       pass_message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 5, size => Natural (ccall_size))),
       fail_message => "tab (5) = " & UStrings.To_String (C_String.Arrays.Index (address, Index => 5, size => Natural (ccall_size))));
  end;

  IO.Put_Line ("-- Ada exit");
end t_Index2;
