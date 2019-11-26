boolean MouseInRect(Rect area)
{
  return (
    mouseX > area.x &&
    mouseX < area.x + area.w &&
    mouseY > area.y &&
    mouseY < area.y + area.h
  );
}

boolean PointInRect(float x, float y, Rect area)
{
  return (
    x > area.x &&
    x < area.x + area.w &&
    y > area.y &&
    y < area.y + area.h
  );
}

boolean MouseInCircle(Circle area)
{
  return dist(mouseX, mouseY, area.x, area.y) < area.r/2f;
}

boolean PointInCircle(float x, float y, Circle area)
{
  return dist(x, y, area.x, area.y) < area.r/2f;
}

public class Rect
{
  float x;
  float y;
  
  float w;
  float h;
  
  boolean changeCursor;
  
  public Rect(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    changeCursor = true;
  }
  
  public Rect(float x, float y, float w, float h, boolean changeCursor)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.changeCursor = changeCursor;
  }
  
  void display()
  {
    if(changeCursor && MouseInRect(this)) handSelected();
    if(!debug) return;
    pushStyle();
    fill(255,255,255,64);
    rect(x, y, w, h);
    popStyle();
  }
}

public class ImageRect extends Rect
{
  PImage img;
  boolean changeCursor;
  
  public ImageRect(float x, float y, float w , float h, PImage img)
  {
    super(x, y, w, h);
    this.img = img;
    changeCursor = true;
  }
  
  public ImageRect(float x, float y, float w, float h, String imgPath)
  {
    super(x, y, w, h);
    img = loadImage(imgPath);
    changeCursor = true;
  }
  
  public ImageRect(float x, float y, float w , float h, PImage img, boolean changeCursor)
  {
    super(x, y, w, h);
    this.img = img;
    this.changeCursor = changeCursor;
  }
  
  public ImageRect(float x, float y, float w, float h, String imgPath, boolean changeCursor)
  {
    super(x, y, w, h);
    img = loadImage(imgPath);
    this.changeCursor = changeCursor;
  }
  
  void display()
  {
    if(changeCursor && MouseInRect(this)) handSelected();
    image(img, x, y, w,h);
  }
}

public class Circle
{
  float x;
  float y;
  
  float r;
  
  public Circle(float x, float y, float r)
  {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void debugDisplay()
  {
    if(MouseInCircle(this)) handSelected();
    pushStyle();
    fill(255,255,255,64);
    circle(x, y, r);
    popStyle();
  }
}
