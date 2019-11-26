
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
  
  Rect taskRect;
  
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
    float h = textAscent() + textDescent();//taskRect.h;
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
    textSize(60);
    textLeading(60);
    float lh = textAscent() + textDescent();
    fill(255, 0, 0);
    if(vaseTask) fill(0, 255, 0);
    text("Clean up the vase", width/2f, 200 + lh*0);
    fill(255, 0, 0);
    if(bottleTask) fill(0, 255, 0);
    text("Collect all bottles", width/2f, 200 + lh*1);
    fill(255, 0, 0);
    if(remoteTask) fill(0, 255, 0);
    text("Repair the remote", width/2f, 200 + lh*2);
    fill(255, 0, 0);
    if(mopTask) fill(0, 255, 0);
    text("Mop up the dirt", width/2f, 200 + lh*3);
    fill(255, 0, 0);
    if(lightTask) fill(0, 255, 0);
    text("Repair the night lamp", width/2f, 200 + lh*4);
    fill(255, 0, 0);
    if(coffeeTask) fill(0, 255, 0);
    text("Drink some coffee", width/2f, 200 + lh*5);
    fill(255, 0, 0);
    if(guestTask) fill(0, 255, 0);
    text("Throw out all of the guests", width/2f, 200 + lh*6);
    popStyle();
    popMatrix();
  }
  
  boolean allDone()
  {
    return vaseTask && bottleTask && remoteTask && mopTask && lightTask && coffeeTask;
  }
}
