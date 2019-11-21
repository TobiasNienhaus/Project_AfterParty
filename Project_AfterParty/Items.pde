enum ItemType
{
  Test1, Test2, Test3, Empty, Error, Hat, GlassesNoFrame, GlassesFrame, GlassesComplete
}

void printItemType(ItemType type)
{
  switch(type)
  {
  case Test1:
    println("Test1");
    break;
  case Test2:
    println("Test2");
    break;
  case Test3:
    println("Test3");
    break;
  case Empty:
    println("Empty");
    break;
  case Error:
    println("Error");
    break;
  case Hat:
    println("Hat");
    break;
  case GlassesNoFrame:
    println("GlassesNoFrame");
    break;
  case GlassesFrame:
    println("GlassesFrame");
    break;
  case GlassesComplete:
    println("GlassesComplete");
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
  case Test1:
    return new TestItem1(0f, 0f, 0f, 0f);
  case Test2:
    return new TestItem2(0f, 0f, 0f, 0f);
  case Test3:
    return new TestItem3(0f, 0f, 0f, 0f);
  case Hat:
    return new HatItem(0f, 0f, 0f, 0f);
  case GlassesNoFrame:
    return new GlassesNoFrameItem(0f, 0f, 0f, 0f);
  case GlassesFrame:
    return new GlassesFrameItem(0f, 0f, 0f, 0f);
  case GlassesComplete:
    return new GlassesCompleteItem(0f, 0f, 0f, 0f);
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

public class TestItem1 extends Item
{
  public TestItem1(float x, float y, float w, float h)
  {
    super(x, y, w, h, "item.jpg");
  }

  public ItemType getType() { 
    return ItemType.Test1;
  }

  public Item Combine(Item other)
  {
    switch(other.getType())
    {
    case Empty:
      return other;
    case Test1:
      return new EmptyItem();
    case Test2:
      return new TestItem3(x, y, w, h);
    default:
      return new ErrorItem();
    }
  }
}

public class TestItem2 extends Item
{
  public TestItem2(float x, float y, float w, float h)
  {
    super(x, y, w, h, "item2.png");
  }

  public ItemType getType() { 
    return ItemType.Test2;
  }

  public Item Combine(Item other)
  {
    switch(other.getType())
    {
    case Empty:
      return other;
    case Test1:
      return new TestItem3(x, y, w, h);
    case Test2:
      return new ErrorItem();
    default:
      return new ErrorItem();
    }
  }
}

public class TestItem3 extends Item
{
  public TestItem3(float x, float y, float w, float h)
  {
    super(x, y, w, h, "item3.jpg");
  }

  public ItemType getType() { 
    return ItemType.Test3;
  }

  public Item Combine(Item other)
  {
    switch(other.getType())
    {
    case Empty:
      return other;
    case Test1:
      return new ErrorItem();
    case Test2:
      return new ErrorItem();
    default:
      return new ErrorItem();
    }
  }
}

public class HatItem extends Item
{
  public HatItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, "ph/hat.png");
  }
  
  public ItemType getType() { return ItemType.Hat; }
  
  public Item Combine(Item other)
  {
    
    return new ErrorItem();
  }
}

public class GlassesNoFrameItem extends Item
{
  public GlassesNoFrameItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, "ph/glassesnoframe.png");
  }
  
  public ItemType getType() { return ItemType.GlassesNoFrame; }
  
  public Item Combine(Item other)
  {
    if(other.getType() == ItemType.GlassesFrame)
      return new GlassesCompleteItem(x, y, w, h);
    else return new ErrorItem();
  }
}

public class GlassesFrameItem extends Item
{
  public GlassesFrameItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, "ph/glassesframe.png");
  }
  
  public ItemType getType() { return ItemType.GlassesFrame; }
  
  public Item Combine(Item other)
  {
    if(other.getType() == ItemType.GlassesNoFrame)
      return new GlassesCompleteItem(x, y, w, h);
    else return new ErrorItem();
  }
}

public class GlassesCompleteItem extends Item
{
  public GlassesCompleteItem(float x, float y, float w, float h)
  {
    super(x, y, w, h, "ph/glassescomplete.png");
  }
  
  public ItemType getType() { return ItemType.GlassesComplete; }
  
  public Item Combine(Item other)
  {
    return new ErrorItem();
  }
}
