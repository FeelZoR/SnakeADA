with  Ada.Text_IO, p_console, p_snake, p_apple, Ada.Characters.Latin_1;
use   Ada.Text_IO;

procedure main is
  package Console renames p_console;
  package Snake renames p_snake;
  package Apple renames p_apple;

  pause: boolean := false;
  finished: boolean := false;

  ----------------
  -- Procedures --
  --            --
  ----------------
  procedure pauseGame is
  -- {} => {Pauses the game}
  begin
    pause := true;
    Console.write(Console.getTerminalWidth / 2 - 5, Console.getTerminalHeight / 2, "P A U S E D");
  end pauseGame;

  procedure resumeGame is
  -- {} => {Resumes the game}
  begin
    Console.write(Console.getTerminalWidth / 2 - 5, Console.getTerminalHeight / 2, "           "); -- We replace the pause by empty characters
    Snake.draw;
    Apple.show;
    pause := false;
  end resumeGame;

  procedure togglePause is
  -- {} => {Toggles the pause status}
  begin
    if pause then
      resumeGame;
    else
      pauseGame;
    end if;
  end togglePause;

  ---------------
  ---  Tasks  ---
  ---         ---
  ---------------
  task getUserInput;
  task body getUserInput is
    ans: character;
  begin
    while not finished loop
      Get_Immediate(ans);
      if Snake.isAlive then
        if ans = Ada.Characters.Latin_1.Esc or
              ans = Ada.Characters.Latin_1.Space then
          togglePause;
        end if;

        Snake.changeDirection(ans);
      end if; -- alive
    end loop;
    Console.showCursor;
  end getUserInput;
begin
  Console.hideCursor;
  Snake.create;
  Apple.initialize;
  Console.clear;

  Snake.draw;

  while Snake.isAlive loop
    if not pause then
      Snake.update;
      Apple.show;
    end if;
    delay duration(Snake.getSpeed);
  end loop;

  Console.clear;
  Console.write(Console.getTerminalWidth / 2 - 8, Console.getTerminalHeight / 2 - 1, "G A M E  O V E R");
  Console.write(Console.getTerminalWidth / 2 - 5, Console.getTerminalHeight / 2 + 1, "Score :" & Integer'image(Snake.getSize));

  delay 0.5;
  Console.write(Integer'Max(Console.getTerminalWidth - 38, 1),
                Console.getTerminalHeight,
                "Appuyez sur une touche pour quitter...");
  finished := true;

end main;
