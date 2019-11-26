
public abstract class Guest implements DialogueCallbackReceiver
{
  ImageRect iRect;
  public Guest(float x, float y, float w, float h, String imgPath)
  {
    iRect = new ImageRect(x, y, w, h, imgPath);
  }
  
  public void display()
  {
    iRect.display();
  }
  
  public abstract boolean checkClick();
  public abstract boolean dropItem(Item item);
}

public class Wendy extends Guest
{
  boolean startedQuest = false;
  boolean finishedQuest = false;
  boolean left = false;
  
  public Wendy(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "wendy.png");
  }
  
  void display()
  {
    if(!left) super.display();
  }
  
  public boolean checkClick()
  {
    if(MouseInRect(iRect))
    {
      if(!startedQuest)
      {
        startedQuest = true;
        gameHandler.dHandler.startDialogue(dialogues.wendyStart,this);
        return true;
      }
      if(startedQuest && !finishedQuest)
      {
        gameHandler.dHandler.startDialogue(dialogues.wendyInbetween, this);
        return true;
      }
    }
    return false;
  }
  
  public boolean dropItem(Item item)
  {
    if(startedQuest && !left && !finishedQuest && item.getType() == ItemType.Hat)
    {
      finishedQuest = true;
      gameHandler.dHandler.startDialogue(dialogues.wendyComplete, this);
      return true;
    }
    return false;
  }
  
  public void OnDialogueEnd()
  {
    if(!left && finishedQuest)
    {
      left = true;
      gameHandler.dHandler.startDialogue(dialogues.wendyLeave,this);
    }
  }
}

public class Max extends Guest
{
  boolean startedQuest = false;
  boolean finishedQuest = false;
  boolean left = false;
  
  public Max(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "max.png");
  }
  
  void display()
  {
    if(!left) super.display();
  }
  
  public boolean checkClick()
  {
    if(MouseInRect(iRect))
    {
      if(!startedQuest)
      {
        startedQuest = true;
        gameHandler.dHandler.startDialogue(dialogues.maxStart,this);
        return true;
      }
      if(startedQuest && !finishedQuest)
      {
        gameHandler.dHandler.startDialogue(dialogues.maxInbetween, this);
        return true;
      }
    }
    return false;
  }
  
  public boolean dropItem(Item item)
  {
    if(startedQuest && !left && !finishedQuest && item.getType() == ItemType.Badge)
    {
      finishedQuest = true;
      gameHandler.dHandler.startDialogue(dialogues.maxComplete, this);
      return true;
    }
    return false;
  }
  
  public void OnDialogueEnd()
  {
    if(!left && finishedQuest)
    {
      left = true;
    }
  }
}

public class Mike extends Guest
{
  boolean startedQuest = false;
  boolean finishedQuest = false;
  boolean left = false;
  ImageRect secondState;
  
  public Mike()
  {
    super(600, 500, 560, 210, folder + "mike.png");
    secondState = new ImageRect(800, 300, 210, 560, folder + "mike.png");
  }
  
  void display()
  {
    if(!finishedQuest && !left) super.display();
    else if(finishedQuest && !left) secondState.display(); 
  }
  
  public boolean checkClick()
  {
    if(!startedQuest && !finishedQuest && MouseInRect(iRect))
    {
      startedQuest = true;
      gameHandler.dHandler.startDialogue(dialogues.mikeStart,this);
      return true;
    }
    if(startedQuest && !finishedQuest && MouseInRect(iRect))
    {
      gameHandler.dHandler.startDialogue(dialogues.mikeInbetween, this);
      return true;
    }
    return false;
  }
  
  public boolean dropItem(Item item)
  {
    return false;
  }
  
  public void flood()
  {
    if(startedQuest && !left && !finishedQuest)
    {
      finishedQuest = true;
      gameHandler.dHandler.startDialogue(dialogues.mikeComplete, this);
    }
  }
  
  public void OnDialogueEnd()
  {
    if(!left && finishedQuest)
    {
      left = true;
    }
  }
}

public class Sarah extends Guest
{
  boolean startedQuest = false;
  boolean finishedQuest = false;
  boolean left = false;
  
  public Sarah(float x, float y, float w, float h)
  {
    super(x, y, w, h, folder + "sarah.png");
  }
  
  void display()
  {
    if(!left) super.display();
  }
  
  public boolean checkClick()
  {
    if(MouseInRect(iRect))
    {
      if(!startedQuest)
      {
        startedQuest = true;
        gameHandler.dHandler.startDialogue(dialogues.sarahStart,this);
        return true;
      }
      if(startedQuest && !finishedQuest)
      {
        gameHandler.dHandler.startDialogue(dialogues.sarahInbetween, this);
        return true;
      }
    }
    return false;
  }
  
  public boolean dropItem(Item item)
  {
    if(startedQuest && !left && !finishedQuest && item.getType() == ItemType.Hat)
    {
      finishedQuest = true;
      gameHandler.dHandler.startDialogue(dialogues.sarahComplete, this);
      return true;
    }
    return false;
  }
  
  public void OnDialogueEnd()
  {
    if(!left && finishedQuest)
    {
      left = true;
    }
  }
}
