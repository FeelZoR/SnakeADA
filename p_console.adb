with  Interfaces.C, Ada.Text_IO, Ada.Strings, Ada.Strings.Fixed;
use   Interfaces.C, Ada.Text_IO, Ada.Strings, Ada.Strings.Fixed;

package body p_console is
  procedure execute(command: in string) is
  -- {} => {Execute a command in the terminal}
    R: integer;
  begin
    R := execute(command);
  end execute;

  function execute(command: in string) return integer is
  -- {} => {result=return code of the executed command}
      function Sys (arg : Char_Array) return integer;
      pragma Import(C, Sys, "system");
  begin
      return Sys(To_C(command));
  end execute;

  procedure clear is
  -- {} => {Clears the console}
  begin
    execute("clear");
  end clear;

  procedure write(x, y: integer; text: string) is
  -- {} => {Writes the text at position (x;y)}
  begin
    execute("printf '\33[%d;%dH%s' '"
      & Trim(Integer'image(y), BOTH)
      & "' '"
      & Trim(Integer'image(x), BOTH)
      & "' '"
      & text
      & "'");
  end write;

  procedure hideCursor is
  -- {} => {Hides the cursor}
  begin
    execute("printf '\e[?25l'");
  end hideCursor;

  procedure showCursor is
  -- {} => {Shows the cursor}
  begin
    execute("printf '\e[?25h'");
  end showCursor;

  function getTerminalWidth return integer is
  -- {} => {result=number of columns in the terminal}

  resultFile: File_type;
  consoleWidth: natural;
  begin
    if width /= 0 then
      return width;
    end if;

    execute("tput cols >> tempConsole");

    open(resultFile,In_File,"tempConsole");
    consoleWidth := Integer'value(get_Line(resultFile));
    delete(resultFile);

    Put(Integer'image(consoleWidth));

    width := consoleWidth;
    return consoleWidth;
  end getTerminalWidth;


  function getTerminalHeight return integer is
  -- {} => {result=number of lines in the terminal}
    resultFile: File_type;
    consoleHeight: natural;
  begin
    if height /= 0 then
      return height;
    end if;

    execute("tput lines >> tempConsole");

    open(resultFile,In_File,"tempConsole");
    consoleHeight := Integer'value(get_Line(resultFile));
    delete(resultFile);

    height := consoleHeight;
    return consoleHeight;

  end getTerminalHeight;

end p_console;
