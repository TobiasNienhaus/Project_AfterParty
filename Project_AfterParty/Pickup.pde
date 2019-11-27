
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
    area = new Rect(x, y, w, w);
    img = loadImage(path);
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = w;
  }
  
  public Pickup(float x, float y, float w, float h)
  {
    String path = bottleFiles[int(random(bottleFiles.length))];
    area = new Rect(x, y, w, h);
    img = loadImage(path);
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
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
        snd.playOneShot(Sound.Bottle);
        return true;
      }
    }
    return false;
  }
}
