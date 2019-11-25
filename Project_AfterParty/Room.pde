

public abstract class Room
{
  public class HiddenItem
  {
    ItemType type;
    float x, y, w, h;
    ImageRect rect;
    
    boolean found = false;
    
    public HiddenItem(float x, float y, float w, float h, ItemType type, String imgPath)
    {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.type = type;
      rect = new ImageRect(x, y, w, h, imgPath);
    }
    
    void display()
    {
      if(found) return;
      rect.display();
    }
    
    boolean checkClick()
    {
      if(found) return false;
      if(MouseInRect(rect))
      {
        if(!roomHandler.inv.AddItem(type)) return false;
        found = true;
        return true;
      }
      return false;
    }
  }
  PImage background;
  String id;
  
  protected Room(String id, PImage img)
  {
    background = img;
    this.id = id;
  }
  
  void display()
  {
    image(background, 0, 0, width, height);
  }
  
  abstract void handleMouseDown(int x, int y, MouseButton button);
  abstract void handleKeyDown(Key k);
  
  boolean Compare(Room other)
  {
    return this.id == other.id;
  }
  
  abstract boolean dropItem(Item item);
}

public class LivingRoom extends Room implements DialogueCallbackReceiver
{
  Rect door;
  Rect staircase;
  Rect fishbowl_remote;
  Rect fishbowl_empty;
  boolean hasRemote = false;
  
  public LivingRoom()
  {
    super("Living Room", loadImage("livingroom.jpg"));
    door = new ImageRect(width - 400, 400, 300, 500, folder + "door.png");
    staircase = new ImageRect(100, 100, 1000, 500, folder + "staircase.png");
    fishbowl_remote = new ImageRect(1250, 500, 150, 150, folder + "fishbowl_remote.png");
    fishbowl_empty = new ImageRect(1250, 500, 150, 150, folder + "fishbowl_empty.png", false);
  }
  
  public void display()
  {
    super.display();
    door.display();
    staircase.display();
    if(!hasRemote) fishbowl_remote.display();
    else fishbowl_empty.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      roomHandler.toKitchen();
    if(MouseInRect(staircase))
      roomHandler.toHall();
    if(!hasRemote && MouseInRect(fishbowl_remote))
    {
      hasRemote = true;
      roomHandler.inv.AddItem(ItemType.RemoteWet);
    }
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    return false;
  }
  
  void OnDialogueEnd()
  {
    
  }
}

public class Kitchen extends Room implements DialogueCallbackReceiver
{
  Rect door;
  
  Rect cupboard;
  Rect cabinet;
  Rect drawer;
  Rect emptyDrawer;
  Rect tap;
  Rect coffeemachine;
  
  boolean hasBatteries;
  
  public Kitchen()
  {
    super("Kitchen", loadImage("kitchen.jpg"));
    door = new ImageRect(100, 400, 300, 500, folder + "door.png");
    
    cupboard = new ImageRect(500, 600, 200, 200, folder + "cupboard.png");
    cabinet = new ImageRect(550, 100, 300, 300, folder + "cabinet_closed.png");
    drawer = new ImageRect(800, 600, 140, 100, folder + "drawer_full.png");
    emptyDrawer = new ImageRect(800, 600, 140, 100, folder + "drawer_empty.png", false);
    tap = new ImageRect(1200, 450, 100, 100, folder + "tap.png");
    coffeemachine = new ImageRect(1500, 350, 200, 200, folder + "coffeemachine_empty.png");
  }
  
  public void display()
  {
    super.display();
    door.display();
    cupboard.display();
    cabinet.display();
    if(!hasBatteries) drawer.display();
    else emptyDrawer.display();
    tap.display();
    coffeemachine.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      roomHandler.toLiving();
    if(!hasBatteries && MouseInRect(emptyDrawer))
    {
      hasBatteries = true;
      roomHandler.inv.AddItem(ItemType.Batteries);
    } 
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.VaseEmpty && MouseInRect(tap)) {
      roomHandler.inv.AddItem(ItemType.VaseFull);
      roomHandler.dHandler.startDialogue(dialogues.vaseFillup,this);
      return true;
    }
    return false;
  }
  
  void OnDialogueEnd()
  {
    
  }
}

class Hall extends Room implements DialogueCallbackReceiver
{
  Rect doorBed;
  Rect doorBath;
  Rect staircase;
  Rect closet;
  
  public Hall()
  {
    super("hall", loadImage("hall.png"));
    doorBed = new ImageRect(100, 400, 300, 500, folder + "door.png");
    doorBath = new ImageRect(width - 400, 400, 300, 500, folder + "door.png");
    staircase = new ImageRect(450, 200, 500, 300, folder + "staircase.png");
    closet = new ImageRect(1000, 200, 400, 500, folder + "closet_closed.png");
  }
  
  public void display()
  {
    super.display();
    doorBed.display();
    doorBath.display();
    staircase.display();
    closet.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(doorBed))
      roomHandler.toBedroom();
    if(MouseInRect(doorBath))
      roomHandler.toBath();
    if(MouseInRect(staircase))
      roomHandler.toLiving();
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    return false;
  }
  
  void OnDialogueEnd()
  {
    
  }
}

public class Bathroom extends Room implements DialogueCallbackReceiver
{
  Rect door;
  Rect tap;
  HiddenItem hairdryer;
  Rect hairdryerNoInteract;
  
  // Pick up Hairdryer, combine in inventory, hairdryer reappears
  
  public Bathroom()
  {
    super("Bathroom", loadImage("bath.png"));
    door = new ImageRect(100, 400, 300, 500, folder + "door.png");
    tap = new ImageRect(1300, 400, 100, 100, folder + "tap.png");
    hairdryer = new HiddenItem(1500, 600, 120, 120, ItemType.Hairdryer, folder + "hairdryer.png");
    hairdryerNoInteract = new ImageRect(1500, 600, 120, 120, folder + "hairdryer.png", false);
  }
  
  public void display()
  {
    super.display();
    door.display();
    tap.display();
    hairdryer.display();
    if(roomHandler.driedRemote)
      hairdryerNoInteract.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      roomHandler.toHall();
    if(hairdryer.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.VaseEmpty && MouseInRect(tap)) {
      roomHandler.inv.AddItem(ItemType.VaseFull);
      roomHandler.dHandler.startDialogue(dialogues.vaseFillup,this);
      return true;
    }
    return false;
  }
  
  void OnDialogueEnd()
  {
    
  }
}

class Bedroom extends Room implements DialogueCallbackReceiver
{
  Rect door;
  Rect lamp;
  HiddenItem vase;
  
  Rect vaseSpot;
  boolean tookVase = false;
  boolean completedVase = false;
  Rect vaseFull;
  
  public Bedroom()
  {
    super("Bedroom", loadImage("bedroom.png"));
    door = new ImageRect(width - 400, 400, 300, 500, folder + "door.png");
    lamp = new ImageRect(300, 500, 100, 100, folder + "lamp_broken.png");
    vase = new HiddenItem(width - 600, 400, 100, 229, ItemType.VaseEmpty, folder + "vase_empty.png");
    vaseSpot = new ImageRect(width - 600, 200, 150, 150, folder + "vase_spot.png");
    vaseFull = new ImageRect(width - 600, 200, 75, 171, folder + "vase_full.png", false);
  }
  
  void display()
  {
    super.display();
    door.display();
    lamp.display();
    vase.display();
    if(!completedVase) vaseSpot.display();
    if(tookVase && completedVase) vaseFull.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      roomHandler.toHall();
    if(vase.checkClick())
    {
      roomHandler.dHandler.startDialogue(dialogues.vasePickup, this);
      tookVase = true;
    }
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(tookVase && !completedVase)
    {
      if(item.getType() == ItemType.VaseFull && MouseInRect(vaseSpot))
      {
        completedVase = true;
        roomHandler.tHandler.finishTask();
        return true;
      }
    }
    return false;
  }
  
  void OnDialogueEnd()
  {
    
  }
}
