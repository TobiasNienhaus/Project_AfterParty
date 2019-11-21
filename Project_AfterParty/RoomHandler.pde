
public class RoomHandler
{
  Room kitchen;
  Room living;
  
  Room active;
  
  Inventory inv;
  TaskHandler tHandler;
  DialogueHandler dHandler;
  
  public void initRooms()
  {
    inv = new Inventory();
    tHandler = new TaskHandler();
    dHandler = new DialogueHandler();
    
    kitchen = new Kitchen();
    living = new LivingRoom();
    
    active = living;
  }
  
  public void toKitchen()
  {
    active = kitchen;
  }
  
  public void toLiving()
  {
    active = living;
  }
  
  void display()
  {
    active.display();
    inv.display();
    tHandler.display();
    dHandler.display();
  }
  
  void handleKeyPress()
  {
    active.handleKeyDown(Key.A);
  }
  
  void handleMousePress()
  {
    if(dHandler.mousePress()) return;
    
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
