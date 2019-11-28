
public class TaskHandler
{
  // tasks should show individually
  // normally only show, how many tasks are done
  // when hovering over task counter, show all tasks and which of them are done
  
  int taskCount = 7;
  boolean vaseTask      =false;
  boolean remoteTask    =false;
  boolean mopTask       =false;
  boolean bottleTask    =false;
  boolean lightTask     =false;
  boolean coffeeTask    =false;
  boolean guestTask     =false;
  
  color green = color(90,164,53);
  color red = color(216,55,55);
  
  Rect taskRect;
  float rectW;
  
  public TaskHandler()
  {
    pushMatrix();
    pushStyle();
    fill(0);
    textSize(60);
    textLeading(60);
    textAlign(RIGHT, TOP);
    float w = textWidth("Tasks: 0/6--");
    float h = 100;
    taskRect = new Rect(width-w, -1, w+10,h+10);
    popStyle();
    popMatrix();
    rectW = biggestTextWidth();
  }
  
  void display()
  {
    pushMatrix();
    pushStyle();
    fill(0);
    textSize(60);
    textLeading(60);
    textAlign(RIGHT, TOP);
    float w = taskRect.w;
    float h = textAscent() + textDescent();
    text("Tasks: " + fulfilledCount() + "/" + taskCount, width-w-10, 10, w, h);
    if(MouseInRect(taskRect))
    {
      displayTasklist();
    }
    popStyle();
    popMatrix();
  }
  
  int fulfilledCount()
  {
    int c = 0;
    if(vaseTask) c++;
    if(bottleTask) c++;
    if(remoteTask) c++;
    if(mopTask) c++;
    if(lightTask) c++;
    if(coffeeTask) c++;
    if(guestTask) c++;
    return c;
  }
  
  void displayTasklist()
  {
    pushMatrix();
    pushStyle();
    textAlign(CENTER, TOP);
    textFont(fontDialogue);
    textSize(60);
    textLeading(60);
    
    float lh = textAscent() + textDescent();
    noStroke();
    fill(0,128);
    rect(width/2f - (rectW*1.1f)/2f, 200, rectW*1.1, lh*7);
    
    fill(red);
    if(vaseTask) fill(green);
    text("Clean up the vase", width/2f, 200 + lh*0);
    fill(red);
    if(bottleTask) fill(green);
    text("Collect all of the garbage (" + gameHandler.inv.bottleCount 
      + "/" + gameHandler.inv.maxBottleCount + ")", width/2f, 200 + lh*1);
    fill(red);
    if(remoteTask) fill(green);
    text("Repair the remote", width/2f, 200 + lh*2);
    fill(red);
    if(mopTask) fill(green);
    text("Mop up the dirt", width/2f, 200 + lh*3);
    fill(red);
    if(lightTask) fill(green);
    text("Repair the night lamp", width/2f, 200 + lh*4);
    fill(red);
    if(coffeeTask) fill(green);
    text("Drink some coffee", width/2f, 200 + lh*5);
    fill(red);
    if(guestTask) fill(green);
    text("Throw out all of the guests (" + gameHandler.guestsGone() + "/4)", width/2f, 200 + lh*6);
    popStyle();
    popMatrix();
  }
  
  float biggestTextWidth()
  {
    pushMatrix();
    pushStyle();
    textAlign(CENTER, TOP);
    textSize(60);
    textLeading(60);
    float res = 0f;
    float t1 = textWidth("Clean up the vase");
    float t2 = textWidth("Collect all of the garbage (7/74)");
    float t3 = textWidth("Repair the remote");
    float t4 = textWidth("Mop up the dirt");
    float t5 = textWidth("Repair the night lamp");
    float t6 = textWidth("Drink some coffee");
    float t7 = textWidth("Throw out all of the guests (444)");
    if(t1 > res) res = t1;
    if(t2 > res) res = t2;
    if(t3 > res) res = t3;
    if(t4 > res) res = t4;
    if(t5 > res) res = t5;
    if(t6 > res) res = t6;
    if(t7 > res) res = t7;
    popStyle();
    popMatrix();
    return res;
  }
  
  boolean allDone()
  {
    return vaseTask && bottleTask && remoteTask && mopTask && lightTask && coffeeTask && guestTask;
  }
}
