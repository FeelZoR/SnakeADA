generic
  type Element_Type is private;
package p_queue is
  type Queue is private;

  procedure push(list: in out Queue ; element: in Element_Type);
  -- {} => {Pushes an element at the end of the queue}

  function pop(list: in out Queue) return Element_Type;
  -- {Queue not empty} => {result=first element of the queue}

  function isEmpty(list: in Queue) return boolean;
  -- {} => {result=true if the queue is empty}

  EmptyError: exception;
private
  type QueueElement;
  type QueuePtr is access QueueElement;

  -- A queue is a FIFO list.
  type Queue is record
    head: QueuePtr := null;
    tail: QueuePtr := null;
  end record;

  type QueueElement is record
    value: Element_Type;
    next: QueuePtr := null;
  end record;

end p_queue;
