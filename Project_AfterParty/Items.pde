enum ItemType
{
  Empty, Error, Hat,
  Batteries, Beans, Necklace,
  Badge, Hairdryer, Bulb,
  Mop, RemoteWet, RemoteDry,
  RemoteComplete, Tap, VaseEmpty,
  VaseFull, Cup
}

void printItemType(ItemType type)
{
  switch(type)
  {
  case Empty:
    println("Empty");
    break;
  case Error:
    println("Error");
    break;
  case Hat:
    println("Hat");
    break;
  case Batteries:
    println("Batteries");
    break;
  case Beans:
    println("Beans");
    break;
  case Necklace:
    println("Necklace");
    break;
  case Badge:
    println("Badge");
    break;
  case Hairdryer:
    println("Hairdryer");
    break;
  case Bulb:
    println("Bulb");
    break;
  case Mop:
    println("Mop");
    break;
  case RemoteWet:
    println("Remote Wet");
    break;
  case RemoteDry:
    println("Remote Dry");
    break;
  case RemoteComplete:
    println("Remote Complete");
    break;
  case Tap:
    println("Tap");
    break;
  case VaseEmpty:
    println("Vase empty");
    break;
  case VaseFull:
    println("Vase full");
    break;
  case Cup:
    println("Cup");
    break;
  default:
    println("default");
    break;
  }
}

Item createItemFromType(Item i)
{
  Item res = createItemFromType(i.getType());
  res.setPos(i.x,i.y);
  res.setSize(i.w,i.h);
  return res;
}

Item createItemFromType(ItemType type)
{
  switch(type)
  {
  case Hat:
    return new HatItem(0f, 0f, 0f, 0f);
  case Batteries:
    return new BatteriesItem(0f, 0f, 0f, 0f);
  case Beans:
    return new BeansItem(0f, 0f, 0f, 0f);
  case Necklace:
    return new NecklaceItem(0f, 0f, 0f, 0f);
  case Badge:
    return new BadgeItem(0f, 0f, 0f, 0f);
  case Hairdryer:
    return new HairdryerItem(0f, 0f, 0f, 0f);
  case Bulb:
    return new BulbItem(0f, 0f, 0f, 0f);
  case Mop:
    return new MopItem(0f, 0f, 0f, 0f);
  case RemoteWet:
    return new RemoteWetItem(0f, 0f, 0f, 0f);
  case RemoteDry:
    return new RemoteDryItem(0f, 0f, 0f, 0f);
  case RemoteComplete:
    return new RemoteCompleteItem(0f, 0f, 0f, 0f);
  case Tap:
    return new TapItem(0f, 0f, 0f, 0f);
  case VaseEmpty:
    return new VaseEmptyItem(0f, 0f, 0f, 0f);
  case VaseFull:
    return new VaseFullItem(0f, 0f, 0f, 0f);
  case Cup:
    return new CupItem(0f, 0f, 0f, 0f);
  case Empty:
    return new EmptyItem();
  case Error:
    return new ErrorItem();
  default:
    return new ErrorItem();
  }
}

public abstract class Item
{
  protected Item(float x, float y, float w, float h, String imgName)
  {
    if(imgName != "")
      img = loadImage(imgName);
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  PImage img;

  float x;
  float y;
  float w;
  float h;

  public abstract ItemType getType();
  public abstract Item Combine(Item other);
  
  public void display()
  {
    image(img, x, y, w, h);
  }
  
  public void setPos(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  public void setPos(float x, float y, boolean centered)
  {
    if(centered) {
      this.x = x - w/2f;
      this.y = y - h/2f;
    } else {
      setPos(x, y);
    }
  }
  
  public void setSize(float w, float h)
  {
    this.w = w;
    this.h = h;
  }
}

public class EmptyItem extends Item
{
  public EmptyItem() { super(0, 0, 0, 0, "error.gif"); }

  public ItemType getType() { return ItemType.Empty; }

  public Item Combine(Item other) { return this; }
}

public class ErrorItem extends Item
{
  public ErrorItem() { super(0, 0, 0, 0, "error.gif"); }

  public ItemType getType() { return ItemType.Error; }

  public Item Combine(Item other) { return this; }
}

public class HatItem extends Item
{
  PImage img;
  public HatItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "hat.png");
    ui = false;
    img = loadImage(folder + "hat_ui.png");
  }
  
  public boolean ui;
  
  public ItemType getType() { return ItemType.Hat; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
  
  void display()
  {
    if(ui) {
      image(img, x, y, w, h);
    } else {
      super.display();
    }
  }
}

//Batteries
public class BatteriesItem extends Item
{
  public BatteriesItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "batteries.png");
  }
  
  public ItemType getType() { return ItemType.Batteries; }
  
  public Item Combine(Item other)
  {
    if(other.getType() == ItemType.RemoteDry)
    {
      gameHandler.tHandler.remoteTask = true;
      gameHandler.dHandler.startDialogue(dialogues.remoteBatteries,null);
      return new RemoteCompleteItem(x, y, w, h);
    }
    if(other.getType() == ItemType.RemoteWet)
      gameHandler.dHandler.startDialogue(dialogues.remoteWrongCombine,null);
    return new ErrorItem();
  }
}

//Beans
public class BeansItem extends Item
{
  public BeansItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "beans.png");
  }
  
  public ItemType getType() { return ItemType.Beans; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//Necklace
public class NecklaceItem extends Item
{
  public NecklaceItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "necklace.png");
  }
  
  public ItemType getType() { return ItemType.Necklace; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//Badge
public class BadgeItem extends Item
{
  public BadgeItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "badge.png");
  }
  
  public ItemType getType() { return ItemType.Badge; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//Hairdryer
public class HairdryerItem extends Item
{
  public HairdryerItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "hairdryer.png");
  }
  
  public ItemType getType() { return ItemType.Hairdryer; }
  
  public Item Combine(Item other)
  {
    if(other.getType() == ItemType.RemoteWet)
    {
      gameHandler.driedRemote = true;
      gameHandler.dHandler.startDialogue(dialogues.remoteDrying,null);
      return new RemoteDryItem(x, y, w, h);
    }
    return new ErrorItem();
  }
}

//Bulb
public class BulbItem extends Item
{
  public BulbItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "lightbulb.png");
  }
  
  public ItemType getType() { return ItemType.Bulb; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//Mop
public class MopItem extends Item
{
  public MopItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "mop.png");
  }
  
  public ItemType getType() { return ItemType.Mop; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//RemoteWet
public class RemoteWetItem extends Item
{
  public RemoteWetItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "remote_wet.png");
  }
  
  public ItemType getType() { return ItemType.RemoteWet; }
  
  public Item Combine(Item other)
  {
    if(other.getType() == ItemType.Hairdryer)
    {
      gameHandler.dHandler.startDialogue(dialogues.remoteDrying,null);
      gameHandler.driedRemote = true;
      return new RemoteDryItem(x, y, w, h);
    }
    if(other.getType() == ItemType.Batteries)
      gameHandler.dHandler.startDialogue(dialogues.remoteWrongCombine,null);
    return new ErrorItem();
  }
}

//RemoteDry
public class RemoteDryItem extends Item
{
  public RemoteDryItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "remote_dry.png");
  }
  
  public ItemType getType() { return ItemType.RemoteDry; }
  
  public Item Combine(Item other)
  {
    if(other.getType() == ItemType.Batteries)
    {
      gameHandler.tHandler.remoteTask = true;
      gameHandler.dHandler.startDialogue(dialogues.remoteBatteries,null);
      return new RemoteCompleteItem(x, y, w, h);
    }
    return new ErrorItem();
  }
}

//RemoteComplete
public class RemoteCompleteItem extends Item
{
  public RemoteCompleteItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "remote_complete.png");
  }
  
  public ItemType getType() { return ItemType.RemoteComplete; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//Tap
public class TapItem extends Item
{
  public TapItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "tap.png");
  }
  
  public ItemType getType() { return ItemType.Tap; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//VaseEmpty
public class VaseEmptyItem extends Item
{
  public VaseEmptyItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "vase_empty.png");
  }
  
  public ItemType getType() { return ItemType.VaseEmpty; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//VaseFull
public class VaseFullItem extends Item
{
  public VaseFullItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "vase_full.png");
  }
  
  public ItemType getType() { return ItemType.VaseFull; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}

//Cup
public class CupItem extends Item
{
  public CupItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "cup.png");
  }
  
  public ItemType getType() { return ItemType.Cup; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}
