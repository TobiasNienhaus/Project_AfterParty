

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
        if(!gameHandler.inv.AddItem(type)) return false;
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
  
  Rect dirt;
  boolean clean = false;
  
  Pickup bottle1, bottle2;
  
  Guest wendy;
  
  public LivingRoom()
  {
    super("Living Room", loadImage("livingroom.jpg"));
    door = new ImageRect(width - 400, 400, 300, 500, folder + "door.png");
    staircase = new ImageRect(100, 100, 1000, 500, folder + "staircase.png");
    fishbowl_remote = new ImageRect(1250, 475, 150, 150, folder + "fishbowl_remote.png");
    fishbowl_empty = new ImageRect(1250, 475, 150, 150, folder + "fishbowl_empty.png", false);
    
    dirt = new ImageRect(150, 700, 750, 500, folder + "dirt.png");
    bottle1 = new Pickup(75, 900, 50);
    bottle2 = new Pickup(1150, 525, 50);
    
    wendy = new Wendy(450, 450, 210, 560);
  }
  
  public void display()
  {
    super.display();
    door.display();
    staircase.display();
    if(!hasRemote) fishbowl_remote.display();
    else fishbowl_empty.display();
    if(!clean) dirt.display();
    bottle1.display();
    bottle2.display();
    wendy.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      gameHandler.toKitchen();
    if(wendy.checkClick());
    else if(MouseInRect(staircase))
      gameHandler.toHall();
    if(!hasRemote && MouseInRect(fishbowl_remote))
    {
      if(gameHandler.inv.AddItem(ItemType.RemoteWet))
      {
        hasRemote = true;
        gameHandler.dHandler.startDialogue(dialogues.remoteDiscover,this);
      }
    }
    if(bottle1.checkClick());
    if(bottle2.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.Mop)
    {
      clean = true;
      gameHandler.tHandler.mopTask = true;
      gameHandler.dHandler.startDialogue(dialogues.mopLiving,this);
      return true;
    }
    if(wendy.dropItem(item)) return true;
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
  boolean cupboardIsOpen = false;
  Rect cupboardOpen;
  
  Rect cabinet;
  boolean cabinetIsOpen = false;
  Rect cabinetOpen;
  
  Rect drawer;
  boolean hasBatteries;
  Rect emptyDrawer;
  
  Rect tap;
  
  Rect coffeemachine;
  boolean coffeeHasBeans = false;
  boolean hasCoffee = false;
  Rect coffeemachineBeans;
  
  HiddenItem cupItem;
  
  Pickup bottle1;
  
  HiddenItem necklace;
  
  Guest maxChar;
  
  public Kitchen()
  {
    super("Kitchen", loadImage("kitchen.jpg"));
    door = new ImageRect(100, 400, 300, 500, folder + "door.png");
    
    cupboard = new ImageRect(500, 600, 200, 200, folder + "cupboard_closed.png");
    cupboardOpen = new ImageRect(500, 600, 200, 200, folder + "cupboard_open.png", false);
    
    cabinet = new ImageRect(550, 100, 300, 300, folder + "cabinet_closed.png");
    cabinetOpen = new ImageRect(550, 100, 300, 300, folder + "cabinet_open.png", false);
    
    drawer = new ImageRect(800, 600, 140, 100, folder + "drawer_full.png");
    emptyDrawer = new ImageRect(800, 600, 140, 100, folder + "drawer_empty.png", false);
    
    tap = new ImageRect(1200, 450, 100, 100, folder + "tap.png");
    
    coffeemachine = new ImageRect(1500, 350, 200, 200, folder + "coffeemachine_empty.png");
    coffeemachineBeans = new ImageRect(1500, 350, 200, 200, folder + "coffeemachine_beans.png");
    
    cupItem = new HiddenItem(750, 400, 75, 75, ItemType.Cup, folder + "cup.png");
    
    bottle1 = new Pickup(425, 375, 50);
    
    necklace = new HiddenItem(width-150, height-150, 100, 100, ItemType.Necklace, folder + "necklace.png");
    
    maxChar = new Max(950, 300, 210, 560);
  }
  
  public void display()
  {
    super.display();
    door.display();
    if(!cupboardIsOpen) cupboard.display();
    else cupboardOpen.display();
    if(!cabinetIsOpen) cabinet.display();
    else cabinetOpen.display();
    if(!hasBatteries) drawer.display();
    else emptyDrawer.display();
    tap.display();
    if(!coffeeHasBeans || hasCoffee) coffeemachine.display();
    else coffeemachineBeans.display();
    cupItem.display();
    bottle1.display();
    necklace.display();
    maxChar.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      gameHandler.toLiving();
    if(!cupboardIsOpen && MouseInRect(cupboard))
    {
      if(gameHandler.inv.AddItem(ItemType.Beans))
        cupboardIsOpen = true;
    }
    if(!cabinetIsOpen && MouseInRect(cabinet))
    {
      if(gameHandler.inv.AddItem(ItemType.Bulb))
      {
        cabinetIsOpen = true;
        gameHandler.dHandler.startDialogue(dialogues.lampBulb,this);
      }
    }
    if(!hasBatteries && MouseInRect(emptyDrawer))
    {
      if(gameHandler.inv.AddItem(ItemType.Batteries))
        hasBatteries = true;
    }
    if(!hasCoffee && MouseInRect(coffeemachine))
      gameHandler.dHandler.startDialogue(dialogues.hangoverCureNeeded,this);
    if(cupItem.checkClick());
    if(bottle1.checkClick());
    if(necklace.checkClick());
    if(maxChar.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.VaseEmpty && MouseInRect(tap)) {
      if(!gameHandler.inv.AddItem(ItemType.VaseFull)) return false;
      gameHandler.dHandler.startDialogue(dialogues.vaseFillup,this);
      return true;
    }
    if(!coffeeHasBeans && item.getType() == ItemType.Beans && MouseInRect(coffeemachine))
    {
      coffeeHasBeans = true;
      gameHandler.dHandler.startDialogue(dialogues.hangoverBeans,this);
      return true;
    }
    if(coffeeHasBeans && !hasCoffee
      && item.getType() == ItemType.Cup && MouseInRect(coffeemachineBeans))
    {
      hasCoffee = true;
      ((ImageRect)coffeemachine).changeCursor = false;
      gameHandler.dHandler.startDialogue(dialogues.hangoverCure, this);
      gameHandler.tHandler.coffeeTask = true;
      return true;
    }
    if(!coffeeHasBeans && !hasCoffee
      && item.getType() == ItemType.Cup && MouseInRect(coffeemachineBeans))
        gameHandler.dHandler.startDialogue(dialogues.hangoverCupBeforeBeans, this);
    if(maxChar.dropItem(item)) return true;
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
  boolean closetOpen = false;
  Rect closetOpened;
  
  Pickup bottle1;
  
  public Hall()
  {
    super("hall", loadImage("hall.png"));
    doorBed = new ImageRect(100, 400, 300, 500, folder + "door.png");
    doorBath = new ImageRect(width - 400, 400, 300, 500, folder + "door.png");
    staircase = new ImageRect(450, 200, 500, 300, folder + "staircase.png");
    closet = new ImageRect(1000, 200, 400, 500, folder + "closet_closed.png");
    closetOpened = new ImageRect(1000, 200, 400, 500, folder + "closet_open.png");
    bottle1 = new Pickup(1050, 800, 50);
  }
  
  public void display()
  {
    super.display();
    doorBed.display();
    doorBath.display();
    staircase.display();
    if(!closetOpen) closet.display();
    else closetOpened.display();
    bottle1.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(doorBed))
      gameHandler.toBedroom();
    if(MouseInRect(doorBath))
      gameHandler.toBath();
    if(MouseInRect(staircase))
      gameHandler.toLiving();
    if(!closetOpen && MouseInRect(closet))
    {
      if(gameHandler.inv.AddItem(ItemType.Mop))
        closetOpen = true;
    }
    if(bottle1.checkClick());
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
  
  Pickup bottle1;
  
  Mike mike;
  HiddenItem hat;
  
  public Bathroom()
  {
    super("Bathroom", loadImage("bath.png"));
    door = new ImageRect(100, 400, 300, 500, folder + "door.png");
    tap = new ImageRect(1300, 400, 100, 100, folder + "tap.png");
    hairdryer = new HiddenItem(1500, 600, 120, 120, ItemType.Hairdryer, folder + "hairdryer.png");
    hairdryerNoInteract = new ImageRect(1500, 600, 120, 120, folder + "hairdryer.png", false);
    
    bottle1 = new Pickup(1440, 550, 50);
    
    mike = new Mike();
    hat = new HiddenItem(800, 700, 100, 100, ItemType.Hat, folder + "hat.png");
  }
  
  public void display()
  {
    super.display();
    door.display();
    tap.display();
    hairdryer.display();
    if(gameHandler.driedRemote) hairdryerNoInteract.display();
    bottle1.display();
    mike.display();
    hat.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      gameHandler.toHall();
    if(hairdryer.checkClick());
    if(bottle1.checkClick());
    if(mike.checkClick());
    if(MouseInRect(tap))
    {
      mike.flood();
    }
    if(hat.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.VaseEmpty && MouseInRect(tap)) {
      if(!gameHandler.inv.AddItem(ItemType.VaseFull)) return false;
      gameHandler.dHandler.startDialogue(dialogues.vaseFillup,this);
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
  boolean lampIsFixed = false;
  Rect lampFixed;
  HiddenItem vase;
  
  Rect vaseSpot;
  boolean tookVase = false;
  boolean completedVase = false;
  Rect vaseFull;
  
  Pickup bottle1;
  
  HiddenItem badge;
  
  Guest sarah;
  
  public Bedroom()
  {
    super("Bedroom", loadImage("bedroom.png"));
    door = new ImageRect(width - 400, 400, 300, 500, folder + "door.png");
    lamp = new ImageRect(300, 500, 100, 100, folder + "lamp_broken.png");
    lampFixed = new ImageRect(300, 500, 100, 100, folder + "lamp_fixed.png");
    vase = new HiddenItem(width - 600, 400, 100, 229, ItemType.VaseEmpty, folder + "vase_empty.png");
    vaseSpot = new ImageRect(width - 600, 200, 150, 150, folder + "vase_spot.png");
    vaseFull = new ImageRect(width - 600, 200, 75, 171, folder + "vase_full.png", false);
    
    bottle1 = new Pickup(200, 800, 50);
    badge = new HiddenItem(50, height-150, 100, 100, ItemType.Badge, folder + "badge.png");
    
    sarah = new Sarah(1000, 300, 210, 560);
  }
  
  void display()
  {
    super.display();
    door.display();
    if(!lampIsFixed) lamp.display();
    else lampFixed.display();
    vase.display();
    if(!completedVase) vaseSpot.display();
    if(tookVase && completedVase) vaseFull.display();
    bottle1.display();
    badge.display();
    sarah.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      gameHandler.toHall();
    if(vase.checkClick())
    {
      gameHandler.dHandler.startDialogue(dialogues.vasePickup, this);
      tookVase = true;
    }
    if(!lampIsFixed && MouseInRect(lamp))
      gameHandler.dHandler.startDialogue(dialogues.lampBroken,this);
    if(bottle1.checkClick());
    if(badge.checkClick());
    if(sarah.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(tookVase && !completedVase && item.getType() == ItemType.VaseFull && MouseInRect(vaseSpot))
    {
      completedVase = true;
      gameHandler.tHandler.vaseTask = true;
      return true;
    }
    if(!lampIsFixed && item.getType() == ItemType.Bulb && MouseInRect(lamp))
    {
      lampIsFixed = true;
      gameHandler.tHandler.lightTask = true;
      gameHandler.dHandler.startDialogue(dialogues.lampFix,this);
      return true;
    }
    if(sarah.dropItem(item)) return true;
    return false;
  }
  
  void OnDialogueEnd()
  {
    
  }
}
