
public class RoomHandler
{
  Room roomA;
  Room roomB;
  Room roomC;
  
  Room active;
  
  Inventory inv;
  
  public void initRooms()
  {
    inv = new Inventory();
    roomA = new TestRoom();
    roomB = new TestRoom2();
    roomC = new TestRoom3();
    active = roomA;
  }
  
  public void setRoomAActive()
  {
    active = roomA;
  }
  
  public void setRoomBActive()
  {
    active = roomB;
  }
  
  public void setRoomCActive()
  {
    active = roomC;
  }
  
  void display()
  {
    active.display();
    inv.display();
  }
  
  void handleKeyPress()
  {
    active.handleKeyDown(Key.A);
  }
  
  void handleMousePress()
  {
    if(inv.onMousePress()) return;
    MouseButton b = MouseButton.Left;
    if      (mouseButton == LEFT)    b = MouseButton.Left;
    else if (mouseButton == RIGHT)   b = MouseButton.Right;
    else if (mouseButton == CENTER)  b = MouseButton.Middle;
    
    active.handleMouseDown(mouseX,mouseY,b);
  }
  
  void handleMouseUp()
  {
    if(inv.onMouseRelease()) return;
  }
  
  boolean dropItem(Item item)
  {
    return active.dropItem(item);
  }
}
