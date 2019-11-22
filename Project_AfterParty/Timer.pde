
public class Timer
{
  int time = int(5 * 60 * 1000 + 0 * 1000);
  int oldMillis = 0;
  boolean block = false;

  public Timer()
  {
  }
  
  public Timer(int time)
  {
    this.time = time;
  }
  
  public Timer(float min, float sec)
  {
    this.time = int(min * 60 + sec * 1000);
  }
  
  public void step()
  {
    if(!block)
    {
      int delta = millis() - oldMillis;
      time -= delta;
      oldMillis = millis();
    }
  }
  
  public void display()
  {
    String timeText = "" + time/1000/60;
    timeText += ":" + (time/1000)%60;
    //timeText += ":" + time%1000;
    text(timeText,width/2f, height/2f);
  }
  
  public void block()
  {
    block = true;
  }
  
  public void unblock()
  {
    block = false;
  }
}
