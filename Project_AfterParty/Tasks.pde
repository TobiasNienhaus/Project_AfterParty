
public class TaskHandler
{
  boolean[] tasks;
  int lastFinishedIndex = 0;
  
  public TaskHandler()
  {
    tasks = new boolean[5];
    for(int i = 0; i < tasks.length; i++)
      tasks[i] = false;
  }
  
  void display()
  {
    pushMatrix();
    pushStyle();
    fill(0);
    textSize(60);
    textAlign(RIGHT, TOP);
    text("Tasks: " + fulfilledCount() + "/" + tasks.length, width, 0);
    popStyle();
    popMatrix();
  }
  
  void finishTask()
  {
    if(lastFinishedIndex < tasks.length)
    {
      tasks[lastFinishedIndex] = true;
      lastFinishedIndex++;
    }
  }
  
  int fulfilledCount()
  {
    int c = 0;
    for(int i = 0; i < tasks.length; i++)
    {
      if(tasks[i]) c++;
    }
    return c;
  }
  
  boolean allDone()
  {
    return tasks.length == fulfilledCount();
  }
}
