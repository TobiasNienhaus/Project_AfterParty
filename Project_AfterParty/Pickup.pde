
public class Pickup
{
  PImage img;
  Rect area;
  
  float x, y, w, h;
  
  boolean picked = false;
  
  final String[] bottleFiles = new String[] {
    folder + "bottle.png"
  };
  
  public Pickup(float x, float y, float w)
  {
    String path = bottleFiles[int(random(bottleFiles.length))];
    area = new Rect(x, y, w, w*2);
    img = loadImage(path);
    
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
  
  boolean checkClick()
  {
    if(!picked)
    {
      if(MouseInRect(area))
      {
        gameHandler.inv.collectBottle();
        picked = true;
        return true;
      }
    }
    return false;
  }
}
