
public class RoomHandler
{
  Room kitchen;
  Room living;
  Room hall;
  Room bath;
  Room bedroom;
  
  Room active;
  
  Inventory inv;
  TaskHandler tHandler;
  DialogueHandler dHandler;
  
  Timer t;
  
  boolean driedRemote = false;
  
  public void initRooms()
  {
    inv = new Inventory();
    tHandler = new TaskHandler();
    dHandler = new DialogueHandler();
    
    kitchen = new Kitchen();
    living = new LivingRoom();
    hall = new Hall();
    bath = new Bathroom();
    bedroom = new Bedroom();
    
    active = living;
    t = new Timer();
  }
  
  public void toKitchen()
  {
    active = kitchen;
  }
  
  public void toLiving()
  {
    active = living;
  }
  
  public void toBath()
  {
    active = bath;
  }
  
  public void toBedroom()
  {
    active = bedroom;
  }
  
  public void toHall()
  {
    active = hall;
  }
  
  void display()
  {
    t.step();
    active.display();
    inv.display();
    tHandler.display();
    dHandler.display();
    t.display();
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
