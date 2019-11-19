
public class RoomHandler
{
  Room roomA;
  Room roomB;
  
  Room active;
  
  public void initRooms()
  {
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
  }
}
