with p_console, p_apple;

package body p_snake is
  package Console renames p_console;
  package Apple renames p_apple;

  procedure create is
  -- {} => {Create the base snake}
  i: natural;
  begin
    moveDirection := EAST;

    -- Initialization of first and last elements
    First := new BodyPart;
    First.all.x := DEFAULT_SIZE * 2;
    First.all.y := 1;
    Last := First;

    i := DEFAULT_SIZE * 2 - 2;
    while i >= 2 loop
      append(i, 1);
      i := i - 2;
    end loop;
    size := DEFAULT_SIZE;
  end create;

  procedure append(x, y: positive) is
  -- {} => {Create a new body part for the snake}
  newPart: T_Part;
  begin
    newPart := new BodyPart;
    newPart.all.x := x;
    newPart.all.y := y;

    Last.next := newPart;
    Last := newPart;        -- Replaces the last element by the newly created one
    size := size + 1;
    if size > DEFAULT_SIZE then
      speed := speed - 0.001 / float(size);
    end if;
  end append;

  procedure changeDirection(dir: character) is
  -- {} => {Changes the direction with the character passed}
  begin
    case dir is
      when 'z' => push(nextDirection, NORTH);
      when 'q' => push(nextDirection, WEST);
      when 's' => push(nextDirection, SOUTH);
      when 'd' => push(nextDirection, EAST);
      when others => return;
    end case;
  end changeDirection;

  procedure move is
  -- {} => {Moves the snake in the specified direction}
  x, y: natural;
  lastX, lastY: natural;
  begin
    lastX := Last.all.x;
    lastY := Last.all.y;

    x := First.all.x;
    y := First.all.y;
    case moveDirection is
      when WEST => x := x - 2;
      when EAST => x := x + 2;
      when NORTH => y := y - 1;
      when SOUTH => y := y + 1;
      when NONE => return;
    end case;

    if not checkMovement(x, y) then return; end if;

    setPartPos(First, x, y);
    drawParts(First, false);
    drawParts(First.all.next, false);

    if (Apple.pickUp(x, y)) then append(lastX, lastY);
    else Console.write(lastX, lastY, " ");
    end if;
  end move;

  procedure setPartPos(part: T_Part; x, y: positive) is
  -- {} => {Move the part and next parts}
  currX, currY: positive;
  begin
    currX := part.all.x;
    currY := part.all.y;
    part.all.x := x;
    part.all.y := y;

    if part.all.next /= null then setPartPos(part.all.next, currX, currY); end if;
  end setPartPos;

  procedure update is
  -- {} => {Updates the snake and draws it}
  begin
    updateDirection;
    move;
  end update;

  procedure updateDirection is
  -- {} => {Update the direction of the snake}
    currentDirection: Direction;
  begin
    currentDirection := moveDirection;
    while not isEmpty(nextDirection) loop
      moveDirection := pop(nextDirection);
      if not areDirectionsOpposed(moveDirection, currentDirection) then return; end if;
    end loop;

    moveDirection := currentDirection;
  end updateDirection;

  function areDirectionsOpposed(dir1, dir2: Direction) return boolean is
  -- {} => {result=true if directions are opposed}
  begin
    return (dir1 = NORTH and dir2 = SOUTH) or
      (dir1 = SOUTH and dir2 = NORTH) or
      (dir1 = EAST and dir2 = WEST) or
      (dir1 = WEST and dir2 = EAST);
  end areDirectionsOpposed;

  procedure draw is
  -- {} => {Starts drawing the snake}
  begin
    Console.clear;
    drawParts(First);
  end draw;

  procedure drawParts(part: T_Part; recursive: boolean := true) is
  -- {} => {Draw the part and next parts in the console}
  partChar: character;
  begin
    partChar := (if part = First then HEAD_CHAR(Direction'pos(moveDirection)) else BODY_CHAR);

    Console.write(part.all.x, part.all.y, "" & partChar);
    if part.all.next /= null and recursive then drawParts(part.all.next); end if;
  end drawParts;

  function checkMovement(newX, newY: natural) return boolean is
  -- {} => {result=true if the movement is valid}
  currentPart: T_Part;
  begin
      if (newX = 0 or newX > Console.getTerminalWidth or
          newY = 0 or newY > Console.getTerminalHeight) then
        alive := false;
        return false;
      end if;

      currentPart := First;
      while currentPart.all.next /= null loop
        currentPart := currentPart.all.next;
        if newX = currentPart.all.x and newY = currentPart.all.y then
          alive := false;
          return false;
        end if;
      end loop;

      return true;
  end checkMovement;

  function isAlive return boolean is
  -- {} => {result=true if the snake is alive}
  begin
    return alive;
  end isAlive;

  function getSize return positive is
  -- {} => {result=size of the snake}
  begin
    return size;
  end getSize;

  function getSpeed return float is
  -- {} => {result=time between two movements}
  begin
    return speed;
  end getSpeed;

end p_snake;
