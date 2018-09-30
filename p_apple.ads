package p_apple is

  procedure initialize;
  -- {} => {Initialize the apple}

  function pickUp(posX, posY: positive) return boolean;
  -- {} => {Check if position is the same than apple and pick it up}

  procedure show;
  -- {} => {Shows the apple}

private
  x, y: positive;

  procedure replace;
  -- {} => {Place a new apple}

end p_apple;
