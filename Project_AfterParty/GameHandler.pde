
public class GameHandler
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
  
  boolean maxLeft = false, mikeLeft = false, sarahLeft = false, wendyLeft = false;
  
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
  
  public boolean allGuestsLeft()
  {
    return mikeLeft && maxLeft && sarahLeft && wendyLeft;
  }
  
  public int guestsGone()
  {
    int c = 0;
    if(mikeLeft) c++;
    if(maxLeft) c++;
    if(sarahLeft) c++;
    if(wendyLeft) c++;
    return c;
  }
  
  void mikeLeaves()
  {
    mikeLeft = true;
    if(allGuestsLeft()) tHandler.guestTask = true;
  }
  
  void maxLeaves()
  {
    maxLeft = true;
    if(allGuestsLeft()) tHandler.guestTask = true;
  }
  
  void sarahLeaves()
  {
    sarahLeft = true;
    if(allGuestsLeft()) tHandler.guestTask = true;
  }
  
  void wendyLeaves()
  {
    wendyLeft = true;
    if(allGuestsLeft()) tHandler.guestTask = true;
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
