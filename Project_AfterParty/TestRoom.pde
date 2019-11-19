
public class TestRoom extends Room
{
  Rect clickArea1;
  
  public TestRoom()
  {
    super("Room1", loadImage("wallpaper.jpg"));
    clickArea1 = new Rect(width/2f-100f, height/2f-100f, 200f, 200f);
  }
  
  void display()
  {
    super.display();
    clickArea1.debugDisplay();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(PointInRect(x, y, clickArea1))
      roomHandler.setRoomBActive();
  }
  
  void handleKeyDown(Key k)
  {
    
  }
}

public class TestRoom2 extends Room
{
  Circle c;
  public TestRoom2()
  {
    super("Room2", loadImage("wallpaper2.jpg"));
    c = new Circle(400f, 500f, 100f);
  }
  
  void display()
  {
    super.display();
    c.debugDisplay();
  }
  
  void handleMouseDown(int x, int y, MouseButton button)
  {
    if(PointInCircle(x, y, c))
      roomHandler.setRoomAActive();
  }
  
  void handleKeyDown(Key k)
  {
    
  }
}
