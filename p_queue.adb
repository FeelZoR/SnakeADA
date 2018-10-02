with Ada.Unchecked_Deallocation;

package body p_queue is
  procedure push(list: in out Queue ; element: in Element_Type) is
  -- {} => {Pushes an element at the end of the queue}
  temp: QueuePtr := new QueueElement'(element, null);
  begin
    if list.tail = null then
      list.tail := temp;
    end if;
    if list.head /= null then
      list.head.next := temp;
    end if;
    list.head := temp;
  end push;

  function pop(list: in out Queue) return Element_Type is
  -- {Queue not empty} => {result=first element of the queue}
  procedure Free is new Ada.Unchecked_Deallocation(QueueElement, QueuePtr);
  temp: QueuePtr := list.tail;
  value: Element_Type;
  begin
    if isEmpty(list) then
      raise EmptyError;
    end if;

    value := list.tail.value;
    list.tail := list.tail.next;
    if list.tail = null then
      list.head := null;
    end if;
    Free(temp);

    return value;
  end pop;

  function isEmpty(list: in Queue) return boolean is
  -- {} => {result=true if the queue is empty}
  begin
    return list.head = null;
  end isEmpty;

end p_queue;
