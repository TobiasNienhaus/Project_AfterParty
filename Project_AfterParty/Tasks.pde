
public class TaskHandler
{
  Task[] tasks;
  
  public TaskHandler()
  {
    tasks = new Task[3];
    tasks[0] = new HatTask();
    tasks[1] = new BottleTask();
    tasks[2] = new GlassesTask();
    for(int i = 0; i < tasks.length; i++)
      if(tasks[i] == null)
        tasks[i] = new EmptyTask();
  }
  
  void display()
  {
    pushMatrix();
    pushStyle();
    textSize(60);
    textAlign(RIGHT, TOP);
    text("Tasks: " + fulfilledCount() + "/" + tasks.length, width, 0);
    popStyle();
    popMatrix();
  }
  
  public HatTask getHatTask()
  {
    return (HatTask)tasks[0];
  }
  
  public GlassesTask getGlassesTask()
  {
    return (GlassesTask)tasks[2];
  }
  
  int fulfilledCount()
  {
    int c = 0;
    for(int i = 0; i < tasks.length; i++)
    {
      if(tasks[i].fulfilled()) c++;
    }
    return c;
  }
  
  boolean allDone()
  {
    return tasks.length == fulfilledCount();
  }
}

public abstract class Task
{
  protected Task() { }
  
  abstract boolean fulfilled();
  boolean[] requirements;
  int taskCount;
}

public class EmptyTask extends Task
{
  public EmptyTask(){}
  public boolean fulfilled() { return false; }
}

public class HatTask extends Task
{
  public HatTask()
  {
    taskCount = 1;
    requirements = new boolean[taskCount];
  }
  
  public void fulfill()
  {
    requirements[0] = true;
  }
  
  public boolean fulfilled()
  {
    for(boolean b : requirements)
      if(!b) return false;
    return true;
  }
}

public class BottleTask extends Task
{
  public BottleTask() {}
  
  public boolean fulfilled()
  {
    return roomHandler.inv.bottleCount == roomHandler.inv.maxBottleCount;
  }
}

public class GlassesTask extends Task
{
  public GlassesTask()
  {
    taskCount = 1;
    requirements = new boolean[taskCount];
  }
  
  public void fulfill()
  {
    requirements[0] = true;
  }
  
  public boolean fulfilled()
  {
    return requirements[0];
  }
}
