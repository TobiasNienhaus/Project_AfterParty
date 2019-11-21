

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
  Rect toKitchen;
  
  Guest c;
  
  Pickup p1, p2;
  
  HiddenItem glassesFrame;
  
  public LivingRoom()
  {
    super("Living Room", loadImage("livingroom.jpg"));
    toKitchen = new Rect(0, 0, width / 6f, height);
    
    c = new WitchTest(400, 400, 200, 600);
    p1 = new Pickup(400, 100, 40);
    p2 = new Pickup(1800, 500, 50);
    glassesFrame = new HiddenItem(800, 600, 50, 50, ItemType.GlassesFrame, "ph/glassesframe.png");
  }
  
  public void display()
  {
    super.display();
    toKitchen.display();
    p1.display();
    p2.display();
    c.display();
    glassesFrame.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(toKitchen))
      roomHandler.toKitchen();
    if(c.checkClick());
    p1.checkClick();
    p2.checkClick();
    if(glassesFrame.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(c.dropItem(item)) return true;
    return false;
  }
  
  void OnDialogueEnd()
  {
    
  }
}

public class Kitchen extends Room implements DialogueCallbackReceiver
{
  Rect toLiving;
  
  HiddenItem hat;
  HiddenItem glassesNoFrame;
  
  Pickup p1;
  
  Guest c;
  
  public Kitchen()
  {
    super("Kitchen", loadImage("kitchen.jpg"));
    toLiving = new Rect(width-(width/6f), 0, width/6f, height);
    hat = new HiddenItem(width*.6f, height*.5, 100, 100, ItemType.Hat, "ph/hat.png");
    glassesNoFrame = new HiddenItem(1200, 700, 50, 50, ItemType.GlassesNoFrame, "ph/glassesnoframe.png");
    p1 = new Pickup(450, 700, 45);
    c = new VampireTest(200, 200, 200, 600);
  }
  
  public void display()
  {
    super.display();
    toLiving.display();
    hat.display();
    p1.display();
    c.display();
    glassesNoFrame.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(toLiving))
      roomHandler.toLiving();
    if(hat.checkClick())
      roomHandler.dHandler.startDialogue(roomHandler.dHandler.hatPickup, this);
    c.checkClick();
    p1.checkClick();
    if(glassesNoFrame.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(c.dropItem(item)) return true;
    return false;
  }
  
  void OnDialogueEnd()
  {
    //if(c2InEndDialogue) c2IsFinished = true;
  }
}
