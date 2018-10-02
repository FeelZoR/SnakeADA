with Ada.Numerics.Discrete_Random, p_console;
use p_console;

package body p_apple is
  package Console renames p_console;

  type random is range 1..Integer'Last;

  package generator is new Ada.Numerics.Discrete_Random(random);
  rand: generator.Generator;

  procedure initialize is
  -- {} => {Initialize the apple}
  begin
    generator.reset(rand);
    replace;
  end initialize;

  procedure replace is
  -- {} => {Place a new apple}
  begin
      x := Integer(generator.random(rand)) mod (Console.getTerminalWidth / 2) * 2 + 2;
      y := Integer(generator.random(rand)) mod (Console.getTerminalHeight) + 1;
  end replace;

  function pickUp(posX,posY: positive) return boolean is
  -- {} => {Check if position is the same than apple and pick it up}
  begin
    if x = posX and y = posY then
      replace;
      return true;
    else return false;
    end if;
  end pickUp;

  procedure show is
  -- {} => {Shows the apple}
  begin
    Console.write(x, y, "");
  end show;
end p_apple;
