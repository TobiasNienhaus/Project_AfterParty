
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
    oldMillis = 0;
  }
  
  public Timer(float min, float sec)
  {
    this.time = int(min * 60 + sec * 1000);
    oldMillis = 0;
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
    int minutes = time/1000/60;
    int seconds = (time/1000)%60;
    int millis = time%1000;
    String timeText = String.format(
      (java.util.Locale)null, "%02d:%02d", minutes, seconds);
    
    pushStyle();
    pushMatrix();
    textAlign(CENTER, CENTER);
    textSize(64);
    textLeading(64);
    float w = textWidth("44444") + 20;
    float h = textAscent() + textDescent();
    fill(0);
    //noStroke();
    rect(width/2f-w/2f,10,w,h);
    fill(255);
    //stroke(255);
    text(timeText,width/2f-w/2f, 10, w, h);
    popStyle();
    popMatrix();
  }
  
  public void block()
  {
    block = true;
  }
  
  public void unblock()
  {
    block = false;
    oldMillis = millis();
  }
  
  public boolean over()
  {
    return time <= 0;
  }
  
  public String getTime()
  {
    int minutes = time/1000/60;
    int seconds = (time/1000)%60;
    int millis = time%1000;
    return String.format(
      (java.util.Locale)null, "%02d:%02d", minutes, seconds); 
  }
}
