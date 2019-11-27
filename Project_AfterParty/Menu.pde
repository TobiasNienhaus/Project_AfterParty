

public class MainMenu
{ 
  Rect start;
  Rect exit;
  
  public MainMenu()
  {
    start = new Rect(width/2f-200, height/2f-200, 400, 200);
    exit = new Rect(width/2f-200, height/2f+100, 400, 200);
  }
  
  boolean shouldStart = false;
  
  void onMouseDown()
  {
    if(MouseInRect(start)) shouldStart = true;
    if(MouseInRect(exit)) exit();
  }
  
  boolean run()
  {
    background(0);
    start.display();
    rect(start.x, start.y, start.w, start.h);
    exit.display();
    rect(exit.x, exit.y, exit.w, exit.h);
    return shouldStart;
  }
}

public class EndMenu
{
  public EndMenu()
  {
    
  }
}
