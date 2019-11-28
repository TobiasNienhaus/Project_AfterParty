
public class IntroHandler
{
  PImage[] images;
  int imageCount = 9;
  
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
    snd.playOneShot();
    if(curr == 2) snd.setMusic(Music.Intro);
    if(curr == 6) {
      snd.setMusic(Music.None);
      snd.playOneShot(Sound.Phone);
    }
    if(isFinished()) gameHandler.t.unblock();
  }
  
  public boolean isFinished()
  {
    return curr >= imageCount;
  }
}

public class OutroHandler
{
  PImage good, bad;
  int imageCount = 1;
  
  int curr = 0;
  
  public OutroHandler()
  {
    good = loadImage(folder + "outro/good.png");
    bad = loadImage(folder + "outro/bad.png");
  }
  
  public void displayGood()
  {
    if(!isFinished())
    {
      image(good, 0, 0, width, height);
      gameHandler.t.block();
      String timeLeft = "Time left: " + gameHandler.t.getTime();
      pushStyle();
      textSize(80);
      textLeading(80);
      textAlign(CENTER, CENTER);
      float w = textWidth(timeLeft);
      fill(0);
      rect(width/2f-w/2f, height/2f + 300, w+10, textAscent()+textDescent()+10);
      fill(255);
      text(timeLeft, width/2f-w/2f, height/2f + 300, w+10, textAscent()+textDescent()+10);
      popStyle();
    }
  }
  
  public void displayBad()
  {
    if(!isFinished())
    {
      image(bad, 0, 0, width, height);
      gameHandler.t.block();
    }
  }
  
  public void onMouse()
  {
    curr++;
    if(isFinished()) {
      gameHandler.t.unblock();
      exit();
    }
  }
  
  public boolean isFinished()
  {
    return curr >= imageCount;
  }
}
