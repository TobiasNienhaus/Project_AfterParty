
public class TaskHandler
{
  Task[] tasks;
  
  public TaskHandler()
  {
    tasks = new Task[2];
    tasks[0] = new TestTask();
    tasks[1] = new TestTask2();
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
  
  int fulfilledCount()
  {
    int c = 0;
    for(int i = 0; i < tasks.length; i++)
    {
      if(tasks[i].fulfilled()) c++;
    }
    return c;
  }
  
  public TestTask getTask1()
  {
    return (TestTask)tasks[0];
  }
  
  public TestTask2 getTask2()
  {
    return (TestTask2)tasks[1];
  }
}

public abstract class Task
{
  protected Task() { }
  
  abstract boolean fulfilled();
  boolean[] requirements;
  int taskCount;
}

public class TestTask extends Task
{
  public TestTask()
  {
    super();
    taskCount = 2;
    requirements = new boolean[taskCount];
    for(int i = 0; i < requirements.length; i++)
      requirements[i] = false;
  }
  
  boolean fulfilled()
  {
    for(int i = 0; i < requirements.length; i++)
    {
      if(!requirements[i]) return false;
    }
    return true;
  }
  
  void fillReq1()
  {
    println("Fill Req 1");
    requirements[0] = true;
  }
  
  void fillReq2()
  {
    println("Fill Req 2");
    requirements[1] = true;
  }
}

public class TestTask2 extends Task
{
  public TestTask2()
  {
    super();
    taskCount = 2;
    requirements = new boolean[taskCount];
    for(int i = 0; i < requirements.length; i++)
      requirements[i] = false;
  }
  
  boolean fulfilled()
  {
    for(int i = 0; i < requirements.length; i++)
    {
      if(!requirements[i]) return false;
    }
    return true;
  }
  
  void fillReq1()
  {
    requirements[0] = true;
  }
  
  void fillReq2()
  {
    requirements[1] = true;
  }
}
