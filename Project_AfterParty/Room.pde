

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
    super("Living Room", loadImage("bg/livingroom.png"));
    door = new Rect(1284, 334, 304, 452);
    staircase = new Rect(100, 100, 1100, 600);
    fishbowl_remote = new ImageRect(1780, 635, 100, 100, folder + "fishbowl_remote.png");
    fishbowl_empty = new ImageRect(1780, 635, 100, 100, folder + "fishbowl_empty.png", false);
    
    dirt = new ImageRect(140, 850, 240, 160, folder + "dirt.png");
    bottle1 = new Pickup(75, 900, 50);
    bottle2 = new Pickup(1700, 800, 50);
    
    wendy = new Wendy(410, 450, 210, 560);
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
    super("Kitchen", loadImage("bg/kitchen.png"));
    door = new Rect(531, 306, 275, 400);
    
    cupboard = new Rect(1420, 625, 105, 130);
    
    cabinet = new Rect(1223, 190, 90, 153);
    
    drawer = new Rect(1668, 590, 106, 16);
    
    tap = new Rect(1540, 530, 86, 51);
    
    coffeemachine = new ImageRect(1663, 523, 55, 55, folder + "coffeemachine_empty.png");
    coffeemachineBeans = new ImageRect(1663, 523, 55, 55, folder + "coffeemachine_beans.png");
    
    cupItem = new HiddenItem(1500, 552, 25, 25, ItemType.Cup, folder + "cup.png");
    
    bottle1 = new Pickup(225, 900, 40);
    
    necklace = new HiddenItem(428, 792, 50, 50, ItemType.Necklace, folder + "necklace.png");
    
    maxChar = new Max(1250, 400, 210, 560);
  }
  
  public void display()
  {
    super.display();
    door.display();
    cupboard.display();
    cabinet.display();
    drawer.display();
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
    if(maxChar.checkClick()) return;
    if(MouseInRect(door))
      gameHandler.toLiving();
    if(!cupboardIsOpen && MouseInRect(cupboard))
    {
      if(gameHandler.inv.AddItem(ItemType.Beans))
      {
        cupboardIsOpen = true;
        cupboard.changeCursor = false;
      }
    }
    if(!cabinetIsOpen && MouseInRect(cabinet))
    {
      if(gameHandler.inv.AddItem(ItemType.Bulb))
      {
        cabinetIsOpen = true;
        gameHandler.dHandler.startDialogue(dialogues.lampBulb,this);
        cabinet.changeCursor = false;
      }
    }
    if(!hasBatteries && MouseInRect(drawer))
    {
      if(gameHandler.inv.AddItem(ItemType.Batteries))
      {
        hasBatteries = true;
        drawer.changeCursor = false;
      }
    }
    if(!hasCoffee && MouseInRect(coffeemachine))
      gameHandler.dHandler.startDialogue(dialogues.hangoverCureNeeded,this);
    if(cupItem.checkClick());
    if(bottle1.checkClick());
    if(necklace.checkClick());
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
  
  Pickup bottle1;
  
  public Hall()
  {
    super("hall", loadImage("bg/hallway.png"));
    doorBed = new Rect(459, 225, 98, 513);
    doorBath = new Rect(1410, 246, 176, 647);
    staircase = new Rect(593, 196, 269, 397);
    closet = new Rect(922, 302, 267, 328);
    bottle1 = new Pickup(1210, 548, 40);
  }
  
  public void display()
  {
    super.display();
    doorBed.display();
    doorBath.display();
    staircase.display();
    closet.display();
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
      {
        closetOpen = true;
        closet.changeCursor = false;
      }
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
  Rect shower;
  
  Pickup bottle1;
  
  Mike mike;
  HiddenItem hat;
  
  public Bathroom()
  {
    super("Bathroom", loadImage("bg/bath.png"));
    door = new Rect(136, 0, 276, 1080);
    tap = new Rect(1742, 507, 92, 86);
    hairdryer = new HiddenItem(1606, 510, 75, 75, ItemType.Hairdryer, folder + "hairdryer.png");
    hairdryerNoInteract = new ImageRect(1606, 510, 75, 75, folder + "hairdryer.png", false);
    shower = new Rect(522, 162, 170, 150);
    
    bottle1 = new Pickup(1515, 850, 40);
    
    mike = new Mike();
    hat = new HiddenItem(1662, 967, 100, 100, ItemType.Hat, folder + "hat.png");
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
    shower.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
      gameHandler.toHall();
    if(hairdryer.checkClick());
    if(bottle1.checkClick());
    if(mike.checkClick());
    if(MouseInRect(shower))
    {
      if(mike.flood()) shower.changeCursor = false;
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
    super("Bedroom", loadImage("bg/bedroom.png"));
    door = new Rect(1740, 330, 110, 430);
    lamp = new ImageRect(160, 710, 100, 100, folder + "lamp_broken.png");
    lampFixed = new ImageRect(160, 710, 100, 100, folder + "lamp_fixed.png");
    vase = new HiddenItem(1195, 651, 50, 115, ItemType.VaseEmpty, folder + "vase_empty.png");
    vaseSpot = new ImageRect(1115, 510, 290, 90, folder + "vase_spot.png");
    vaseFull = new ImageRect(1153, 487, 50, 115, folder + "vase_full.png", false);
    
    bottle1 = new Pickup(1610, 695, 20);
    badge = new HiddenItem(1820, 800, 25, 25, ItemType.Badge, folder + "badge.png");
    
    sarah = new Sarah(550, 385, 210, 560);
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
