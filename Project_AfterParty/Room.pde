
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
  PImage fixedRemote;
  
  Guest wendy;
  
  public LivingRoom()
  {
    super("Living Room", loadImage("bg/livingroom.png"));
    door = new Rect(1284, 334, 304, 452);
    staircase = new Rect(100, 100, 1100, 600);
    fishbowl_remote = new ImageRect(1780, 650, 100, 100, folder + "fishbowl_remote.png");
    fishbowl_empty = new ImageRect(1780, 650, 100, 100, folder + "fishbowl_empty.png", false);
    
    dirt = new ImageRect(180, 890, 150, 100, folder + "dirt.png");
    bottle1 = new Pickup(25, 925, 100);
    bottle2 = new Pickup(1700, 900, 80);
    
    fixedRemote = loadImage(folder + "remote_complete.png");
    
    wendy = new Wendy(485, 459, 146, 563);
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
    if(gameHandler.tHandler.remoteTask) image(fixedRemote, 750, 900, 50, 50);
    wendy.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
    {
      gameHandler.toKitchen();
      snd.playOneShot(Sound.Door);
    }
    if(wendy.checkClick());
    else if(MouseInRect(staircase))
    {
      gameHandler.toHall();
      snd.playOneShot(Sound.Stairs);
    }
    if(!hasRemote && MouseInRect(fishbowl_remote))
    {
      if(gameHandler.inv.AddItem(ItemType.RemoteWet))
      {
        hasRemote = true;
        gameHandler.dHandler.startDialogue(dialogues.remoteDiscover,this);
        snd.playOneShot();
      }
    }
    if(bottle1.checkClick());
    if(bottle2.checkClick());
    if(!clean && MouseInRect(dirt))
    {
      gameHandler.dHandler.startDialogue(dialogues.noMop, this);
    }
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
    
    cupboard = new Rect(1420, 625, 150, 130);
    
    cabinet = new Rect(1223, 190, 150, 153);
    
    drawer = new Rect(1668, 590, 106, 150);
    
    tap = new Rect(1540, 530, 86, 51);
    
    coffeemachine = new ImageRect(1680, 485, 100, 100, folder + "coffeemachine_empty.png");
    coffeemachineBeans = new ImageRect(1680, 485, 100, 100, folder + "coffeemachine_beans.png");
    
    cupItem = new HiddenItem(1485, 537, 40, 40, ItemType.Cup, folder + "cup.png");
    
    bottle1 = new Pickup(180, 950, 80);
    
    necklace = new HiddenItem(430, 792, 60, 80, ItemType.Necklace, folder + "necklace.png");
    
    maxChar = new Max();
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
    if(maxChar.checkClick()) {
      snd.playOneShot();
      return;
    }
    if(MouseInRect(door))
    {
      gameHandler.toLiving();
      snd.playOneShot(Sound.Door);
    }
    if(!cupboardIsOpen && MouseInRect(cupboard))
    {
      if(gameHandler.inv.AddItem(ItemType.Beans))
      {
        cupboardIsOpen = true;
        cupboard.changeCursor = false;
        snd.playOneShot();
        gameHandler.dHandler.startDialogue(dialogues.beans,this);
      }
    }
    if(!cabinetIsOpen && MouseInRect(cabinet))
    {
      if(gameHandler.inv.AddItem(ItemType.Bulb))
      {
        cabinetIsOpen = true;
        gameHandler.dHandler.startDialogue(dialogues.lampBulb,this);
        cabinet.changeCursor = false;
        snd.playOneShot();
      }
    }
    if(!hasBatteries && MouseInRect(drawer))
    {
      if(gameHandler.inv.AddItem(ItemType.Batteries))
      {
        hasBatteries = true;
        drawer.changeCursor = false;
        snd.playOneShot();
      }
    }
    if(!hasCoffee && MouseInRect(coffeemachine)) {
      gameHandler.dHandler.startDialogue(dialogues.hangoverCureNeeded,this);
      snd.playOneShot();
    }
    if(cupItem.checkClick()) {
      snd.playOneShot();
      gameHandler.dHandler.startDialogue(dialogues.cup,this);
    }
    if(bottle1.checkClick());
    if(necklace.checkClick()) {
      snd.playOneShot();
      gameHandler.dHandler.startDialogue(dialogues.necklace,this);
    }
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.VaseEmpty && MouseInRect(tap)) {
      if(!gameHandler.inv.AddItem(ItemType.VaseFull)) return false;
      gameHandler.dHandler.startDialogue(dialogues.vaseFillup,this);
      snd.playOneShot(Sound.Water);
      return true;
    }
    // TODO: order maybe shouldnt matter
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
      snd.playOneShot(Sound.Water);
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
    bottle1 = new Pickup(1200, 650, 80);
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
    {
      gameHandler.toBedroom();
      snd.playOneShot(Sound.Door);
    }
    if(MouseInRect(doorBath))
    {
      gameHandler.toBath();
      snd.playOneShot(Sound.Door);
    }
    if(MouseInRect(staircase))
    {
      gameHandler.toLiving();
      snd.playOneShot(Sound.Stairs);
    }
    if(!closetOpen && MouseInRect(closet))
    {
      if(gameHandler.inv.AddItem(ItemType.Mop))
      {
        closetOpen = true;
        closet.changeCursor = false;
        snd.playOneShot();
        gameHandler.dHandler.startDialogue(dialogues.mop,this);
      }
    }
    if(bottle1.checkClick()) snd.playOneShot();
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
  Rect shower;
  
  Mike mike;
  HiddenItem hat;
  
  Rect cabinet;
  boolean hasDryer = false;
  
  public Bathroom()
  {
    super("Bathroom", loadImage("bg/bath.png"));
    door = new Rect(136, 0, 276, 1080);
    tap = new Rect(1742, 507, 92, 86);
    cabinet = new Rect(1683, 639, 75, 355);
    shower = new Rect(522, 162, 170, 150);
    
    mike = new Mike();
    hat = new HiddenItem(1520, 967, 150, 91, ItemType.Hat, folder + "hat.png");
  }
  
  public void display()
  {
    super.display();
    door.display();
    tap.display();
    mike.display();
    hat.display();
    shower.display();
    cabinet.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
    {
      gameHandler.toHall();
      snd.playOneShot(Sound.Door);
    }
    if(mike.checkClick()) snd.playOneShot();
    if(MouseInRect(shower))
    {
      if(mike.flood()) shower.changeCursor = false;
      snd.playOneShot(Sound.Tap);
    }
    if(hat.checkClick()) 
    {
      snd.playOneShot();
      gameHandler.dHandler.startDialogue(dialogues.wendyFindHat, this);
    }
    if(!hasDryer && MouseInRect(cabinet)) {
      if(gameHandler.inv.AddItem(ItemType.Hairdryer)) {
        cabinet.changeCursor = false;
        hasDryer = true;
        snd.playOneShot();
        gameHandler.dHandler.startDialogue(dialogues.hairdryer,this);
      }
    }
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.VaseEmpty && MouseInRect(tap)) {
      if(!gameHandler.inv.AddItem(ItemType.VaseFull)) return false;
      gameHandler.dHandler.startDialogue(dialogues.vaseFillup,this);
      snd.playOneShot(Sound.Water);
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
  Pickup bottle2;
  
  HiddenItem badge;
  
  Guest sarah;
  
  public Bedroom()
  {
    super("Bedroom", loadImage("bg/bedroom.png"));
    door = new Rect(1740, 330, 110, 430);
    lamp = new ImageRect(150, 670, 150, 150, folder + "lamp_broken.png");
    lampFixed = new ImageRect(150, 670, 150, 150, folder + "lamp_fixed.png");
    vase = new HiddenItem(1195, 651, 115, 115, ItemType.VaseEmpty, folder + "vase_empty.png");
    vaseSpot = new Rect(1115, 510, 290, 90);
    vaseFull = new ImageRect(1153, 500, 115, 115, folder + "vase_full.png", false);
    
    bottle1 = new Pickup(1610, 725, 40);
    bottle2 = new Pickup(60, 960, 80, 80);
    badge = new HiddenItem(1820, 800, 50, 50, ItemType.Badge, folder + "badge.png");
    
    sarah = new Sarah();
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
    bottle2.display();
    badge.display();
    sarah.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(door))
    {
      gameHandler.toHall();
      snd.playOneShot(Sound.Door);
    }
    if(vase.checkClick())
    {
      gameHandler.dHandler.startDialogue(dialogues.vasePickup, this);
      tookVase = true;
      snd.playOneShot();
    }
    if(!lampIsFixed && MouseInRect(lamp)) {
      gameHandler.dHandler.startDialogue(dialogues.lampBroken,this);
      snd.playOneShot();
    }
    if(bottle1.checkClick());
    if(bottle2.checkClick());
    if(badge.checkClick()) {
      snd.playOneShot();
      gameHandler.dHandler.startDialogue(dialogues.badge,this);
    }
    if(sarah.checkClick()) snd.playOneShot();
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
