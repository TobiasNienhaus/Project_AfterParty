

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
  
  Rect char1;
  boolean c1HasItem = false;
  boolean c1InDialogue = false;
  boolean c1IsFinished = false;
  
  Pickup p1, p2;
  
  HiddenItem glassesFrame;
  
  public LivingRoom()
  {
    super("Living Room", loadImage("livingroom.jpg"));
    toKitchen = new Rect(0, 0, width / 6f, height);
    
    char1 = new ImageRect(400, 400, 200, 600, "ph/character.png");
    p1 = new Pickup(400, 100, 40);
    p2 = new Pickup(1800, 500, 50);
    glassesFrame = new HiddenItem(800, 600, 50, 50, ItemType.GlassesFrame, "ph/glassesframe.png");
  }
  
  public void display()
  {
    super.display();
    toKitchen.display();
    if(!c1IsFinished) char1.display();
    p1.display();
    p2.display();
    glassesFrame.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(toKitchen))
      roomHandler.toKitchen();
    if(!c1HasItem && MouseInRect(char1)) {
      roomHandler.dHandler.startDialogue(roomHandler.dHandler.char1, null);
      c1InDialogue = true;
    }
    p1.checkClick();
    p2.checkClick();
    if(glassesFrame.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.Hat)
    {
      if(MouseInRect(char1))
      {
        c1HasItem = true;
        c1InDialogue = true;
        roomHandler.dHandler.startDialogue(roomHandler.dHandler.char1End,this);
        roomHandler.tHandler.getHatTask().fulfill();
        return true;
      }
    }
    return false;
  }
  
  void OnDialogueEnd()
  {
    if(c1InDialogue) c1IsFinished = true;
  }
}

public class Kitchen extends Room implements DialogueCallbackReceiver
{
  Rect toLiving;
  
  HiddenItem hat;
  HiddenItem glassesNoFrame;
  
  Pickup p1;
  
  Rect char2;
  boolean c2HasItem = false;
  boolean c2InEndDialogue = false;
  boolean c2IsFinished = false;
  
  public Kitchen()
  {
    super("Kitchen", loadImage("kitchen.jpg"));
    toLiving = new Rect(width-(width/6f), 0, width/6f, height);
    hat = new HiddenItem(width*.6f, height*.5, 100, 100, ItemType.Hat, "ph/hat.png");
    glassesNoFrame = new HiddenItem(1200, 700, 50, 50, ItemType.GlassesNoFrame, "ph/glassesnoframe.png");
    p1 = new Pickup(250, 700, 45);
    char2 = new ImageRect(200, 200, 200, 600, "ph/vampire.png");
  }
  
  public void display()
  {
    super.display();
    toLiving.display();
    if(!c2IsFinished) char2.display();
    hat.display();
    p1.display();
    glassesNoFrame.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(MouseInRect(toLiving))
      roomHandler.toLiving();
    if(hat.checkClick())
      roomHandler.dHandler.startDialogue(roomHandler.dHandler.hatPickup, this);
    if(!c2HasItem && MouseInRect(char2))
      roomHandler.dHandler.startDialogue(roomHandler.dHandler.char2, this);
    p1.checkClick();
    if(glassesNoFrame.checkClick());
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.GlassesComplete)
    {
      if(MouseInRect(char2))
      {
        c2HasItem = true;
        c2InEndDialogue = true;
        roomHandler.dHandler.startDialogue(roomHandler.dHandler.char2End,this);
        roomHandler.tHandler.getGlassesTask().fulfill();
        return true;
      }
    }
    return false;
  }
  
  void OnDialogueEnd()
  {
    if(c2InEndDialogue) c2IsFinished = true;
  }
}
