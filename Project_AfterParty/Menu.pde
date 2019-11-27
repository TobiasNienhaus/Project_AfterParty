

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
  boolean failed = true;
  Rect mainMenu;
  Rect exit;
  
  public EndMenu()
  {
    mainMenu = new Rect(width/2f - 200, height/2f + 150, 400, 200);
    exit = new Rect(width/2f - 75, height - 150, 150, 50);
  }
  
  public void run()
  {
    background(0);
    pushStyle();
    pushMatrix();
    if(failed) {
      textSize(200);
      textFont(fontStraight);
      textAlign(CENTER, CENTER);
      textLeading(200);
      float h = textAscent() + textDescent();
      float w = textWidth("FAILED!");
      noStroke();
      fill(0, 128);
      rect(width/2f - w/2f, 0, w, h);
      fill(255);
      text("FAILED!", width/2f - w/2f, 100, w, h);
    } else {
      textSize(200);
      textFont(fontStraight);
      textAlign(CENTER, CENTER);
      textLeading(100);
      float h = textAscent() + textDescent();
      float w = textWidth("WON!");
      noStroke();
      fill(0, 128);
      rect(width/2f - w/2f, 0, w, h);
      fill(255);
      text("WON!", width/2f - w/2f, 100, w, h);
      
      textSize(50);
      textLeading(50);
      float w2 = textWidth("444Time left: " + gameHandler.t.getTime());
      float h2 = textAscent() + textDescent();
      fill(0, 128);
      rect(width/2f - w2/2f, h, w2, h2);
      fill(255);
      text("Time left: " + gameHandler.t.getTime(), width/2f - w2/2f, h, w2, h2);
    }
    popMatrix();
    popStyle();
    mainMenu.display();
    rect(mainMenu.x, mainMenu.y, mainMenu.w, mainMenu.h);
    exit.display();
    rect(exit.x, exit.y, exit.w, exit.h);
  }
  
  public void onMouse()
  {
    if(MouseInRect(mainMenu)) frameCount = -1;
    if(MouseInRect(exit)) exit();
  }
  
  public void setState(boolean failed)
  {
    this.failed = failed;
  }
}
