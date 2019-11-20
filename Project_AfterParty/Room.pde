

public abstract class Room
{
  public class HiddenItem
  {
    ItemType type;
    float x, y, w, h;
    Rect rect;
    
    PImage img;
    
    boolean found = false;
    
    public HiddenItem(float x, float y, float w, float h, ItemType type, String imgPath)
    {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.type = type;
      img = loadImage(imgPath);
      rect = new Rect(x, y, w, h);
    }
    
    void display()
    {
      if(found) return;
      rect.debugDisplay();
      image(img, x, y, w, h);
    }
    
    boolean checkClick()
    {
      if(found) return true;
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

public class LivingRoom extends Room
{
  public LivingRoom()
  {
    super("Living Room", loadImage("livingroom.png"));
  }
  
  public void display()
  {
    super.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    return false;
  }
}

public class Kitchen extends Room
{
  public Kitchen()
  {
    super("Kitchen", loadImage("kitchen.jpg"));
  }
  
  public void display()
  {
    super.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    return false;
  }
}
