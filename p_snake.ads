package p_snake is
  procedure create;
  -- {} => {Create the snake}

  procedure append(x, y: positive);
  -- {} => {Create a new body part for the snake}

  procedure changeDirection(dir: character);
  -- {} => {Changes the direction with the character passed}

  procedure move;
  -- {} => {Moves the snake in the specified direction}

  procedure update;
  -- {} => {Updates the snake and draws it}

  procedure draw;
  -- {} => {Starts drawing the snake}

  function checkMovement(newX, newY: natural) return boolean;
  -- {} => {result=true if the movement is valid}

  function isAlive return boolean;
  -- {} => {result=true if the snake is alive}

  function getSize return positive;
  -- {} => {result=size of the snake}

  function getSpeed return float;
  -- {} => {result=time between two movements}

private
  DEFAULT_SIZE: constant positive := 3;
  DEFAULT_SPEED: constant float := 0.1;

  alive: boolean := true;
  size: positive;
  speed: float := DEFAULT_SPEED;

  type Direction is (NORTH, SOUTH, EAST, WEST, NONE);
  moveDirection: Direction;                             -- The current direction the snake is facing
  nextDirection: Direction := NONE;                     -- The direction to use in next update

  type Head is array(0..3) of character;
  HEAD_CHAR: constant Head := ('^', 'v', '>', '<');     -- All characters for the head
  BODY_CHAR: constant character := 'O';                 -- The character for the body parts

  type BodyPart;
  type T_Part is access all BodyPart;

  type BodyPart is
  record
    next: T_Part := null;
    x, y: natural;
  end record;

  First, Last: T_Part;                                  -- The first and last parts of the Snake

  ---------------
  -- Functions --
  --           --
  ---------------
  procedure setPartPos(part: T_Part; x, y: positive);
  -- {} => {Move the part and next parts}

  procedure drawParts(part: T_Part; recursive: boolean := true);
  -- {} => {Draw the part and next parts in the console}

end p_snake;
