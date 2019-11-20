

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
  Rect toKitchen;
  Rect dialogueTest1;
  
  public LivingRoom()
  {
    super("Living Room", loadImage("livingroom.jpg"));
    toKitchen = new Rect(0, 0, width / 6f, height);
    dialogueTest1 = new Rect(width/2f - 100, height/2f - 100, 200, 200);
  }
  
  public void display()
  {
    super.display();
    toKitchen.debugDisplay();
    dialogueTest1.debugDisplay();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(toKitchen))
      roomHandler.toKitchen();
    if(MouseInRect(dialogueTest1))
      roomHandler.dHandler.startDialogue(roomHandler.dHandler.test1);
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
  Rect toLiving;
  Rect dialogueTest2;
  int dialogueCounter = 0;
  
  public Kitchen()
  {
    super("Kitchen", loadImage("kitchen.jpg"));
    toLiving = new Rect(width-(width/6f), 0, width/6f, height);
    dialogueTest2 = new Rect (width/4f-100, height/4f-100, 200,200);
  }
  
  public void display()
  {
    super.display();
    toLiving.debugDisplay();
    dialogueTest2.debugDisplay();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(toLiving))
      roomHandler.toLiving();
    if(MouseInRect(dialogueTest2))
    {
      if(dialogueCounter <= 0)
        roomHandler.dHandler.startDialogue(roomHandler.dHandler.test2);
      else if(dialogueCounter == 1)
        roomHandler.dHandler.startDialogue(roomHandler.dHandler.test3);
      dialogueCounter += dialogueCounter <= 0 ? 1 : 0;
    }
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    return false;
  }
}
