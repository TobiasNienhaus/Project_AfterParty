
public class Pickup
{
  PImage img;
  Rect area;
  
  float x, y, w, h;
  
  boolean picked = false;
  
  public Pickup(float x, float y, float w, float h)
  {
    area = new Rect(x, y, w, h);
    img = loadImage("bottle.jpg");
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display()
  {
    if(picked) return;
    area.debugDisplay();
    image(img, x, y, w, h);
  }
  
  void checkClick()
  {
    if(!picked)
    {
      if(MouseInRect(area))
      {
        roomHandler.inv.collectBottle();
        picked = true;
      }
    }
  }
}
