
public class IntroHandler
{
  PImage[] images;
  int imageCount = 4;
  
  int curr = 0;
  
  public IntroHandler()
  {
    images = new PImage[imageCount];
    for(int i = 0; i < imageCount; i++)
    {
      images[i] = loadImage(folder + "intro/" + (i+1) + ".png");
    }
  }
  
  public void display()
  {
    if(!isFinished())
    {
      image(images[curr], 0, 0, width, height);
      gameHandler.t.block();
    }
  }
  
  public void onMouse()
  {
    curr++;
    if(isFinished()) gameHandler.t.unblock();
  }
  
  public boolean isFinished()
  {
    return curr >= imageCount;
  }
}

public class OutroHandler
{
  PImage[] images;
  int imageCount = 2;
  
  int curr = 0;
  
  public OutroHandler()
  {
    images = new PImage[imageCount];
    for(int i = 0; i < imageCount; i++)
    {
      images[i] = loadImage(folder + "intro/" + (i+1) + ".png");
    }
  }
  
  public void displayGood()
  {
    if(!isFinished())
    {
      image(images[curr], 0, 0, width, height);
      gameHandler.t.block();
    }
  }
  
  public void displayBad()
  {
    if(!isFinished())
    {
      image(images[curr], 0, 0, width, height);
      gameHandler.t.block();
    }
  }
  
  public void onMouse()
  {
    curr++;
    if(isFinished()) gameHandler.t.unblock();
  }
  
  public boolean isFinished()
  {
    return curr >= imageCount;
  }
}
