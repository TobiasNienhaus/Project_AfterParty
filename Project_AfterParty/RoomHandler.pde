
public class RoomHandler
{
  Room roomA;
  Room roomB;
  
  Room active;
  
  Inventory inv;
  
  public void initRooms()
  {
    inv = new Inventory();
    roomA = new TestRoom();
    roomB = new TestRoom2();
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
    MouseButton b = MouseButton.Left;
    if      (mouseButton == LEFT)    b = MouseButton.Left;
    else if (mouseButton == RIGHT)   b = MouseButton.Right;
    else if (mouseButton == CENTER)  b = MouseButton.Middle;
    
    active.handleMouseDown(mouseX,mouseY,b);
    
    inv.onMousePress();
  }
  
  void handleMouseUp()
  {
    inv.onMouseRelease();
  }
}
