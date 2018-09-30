package p_console is
  procedure execute(command: in string);
  -- {} => {Execute a command in the terminal}
  function execute(command: in string) return integer;
  -- {} => {result=return code of the executed command}

  procedure clear;
  -- {} => {Clears the console}

  procedure write(x, y: integer; text: string);
  -- {} => {Writes the text at position (x;y)}

  procedure hideCursor;
  -- {} => {Hides the cursor}

  procedure showCursor;
  -- {} => {Shows the cursor}

  function getTerminalWidth return integer;
  -- {} => {result=number of columns in the terminal}
  function getTerminalHeight return integer;
  -- {} => {result=number of lines in the terminal}

private
  width, height: natural := 0;
end p_console;
