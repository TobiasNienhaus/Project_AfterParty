
public class TestRoom extends Room
{
  Rect clickArea1;
  Circle c;
  
  Rect testRect;
  boolean testDrop = false;
  
  Pickup p1;
  HiddenItem item;
  
  public TestRoom()
  {
    super("Room1", loadImage("wallpaper.jpg"));
    clickArea1 = new Rect(width/2f-100f, height/2f-100f, 200f, 200f);
    c = new Circle(1500, 400, 300);
    item = new HiddenItem(900, 700, 100, 100, ItemType.Test2, "item2.png");
    testRect = new Rect(100, 100, 200, 200);
    
    p1 = new Pickup(400, 300, 150, 100);
  }
  
  void display()
  {
    super.display();
    clickArea1.debugDisplay();
    c.debugDisplay();
    testRect.debugDisplay();
    if(testDrop)
    {
      pushStyle();
      fill(0,0,255);
      rect(100, 100, 200, 200);
      popStyle();
    }
    
    p1.display();
    item.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(PointInRect(x, y, clickArea1))
      roomHandler.setRoomBActive();
    if(PointInCircle(x, y, c))
      roomHandler.setRoomCActive();
    p1.checkClick();
    if(item.checkClick())
    {
      roomHandler.tHandler.getTask1().fillReq2();
      println("click on item");
    }
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    if(MouseInRect(testRect))
    {
      testDrop = true;
      return true;
    }
    return false;
  }
}

public class TestRoom2 extends Room
{
  Circle c;
  HiddenItem item;
  
  public TestRoom2()
  {
    super("Room2", loadImage("wallpaper2.jpg"));
    c = new Circle(400f, 500f, 100f);
    item = new HiddenItem(700, 600, 500, 500, ItemType.Test1, "item.jpg");
  }
  
  void display()
  {
    super.display();
    c.debugDisplay();
    item.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(PointInCircle(x, y, c))
      roomHandler.setRoomAActive();
    if(item.checkClick())
    {
      println("Click on Item");
      roomHandler.tHandler.getTask1().fillReq1();
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

public class TestRoom3 extends Room
{
  Circle c;
  Pickup p2;
  
  public TestRoom3()
  {
    super("Room3", loadImage("wallpaper3.jpg"));
    c = new Circle(1000, 800, 250f);
    
    p2 = new Pickup(100, 100, 50, 75);
  }
  
  void display()
  {
    super.display();
    c.debugDisplay();
    p2.display();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(PointInCircle(x, y, c))
      roomHandler.setRoomAActive();
    p2.checkClick();
  }
  
  void handleKeyDown(Key k)
  {
    
  }
  
  boolean dropItem(Item item)
  {
    return false;
  }
}
