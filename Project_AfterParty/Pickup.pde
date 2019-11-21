
public class Pickup
{
  PImage img;
  Rect area;
  
  float x, y, w, h;
  
  boolean picked = false;
  
  public Pickup(float x, float y, float w)
  {
    area = new Rect(x, y, w, w*2);
    img = loadImage("ph/bottle.png");
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = w*2;
  }
  
  void display()
  {
    if(picked) return;
    area.display();
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
