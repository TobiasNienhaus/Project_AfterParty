
public abstract class Guest implements DialogueCallbackReceiver
{
  Rect rect;
  PImage image;
  
  public Guest(float x, float y, float w, float h, String imgPath)
  {
    rect = new Rect(x, y, w, h);
    image = loadImage(imgPath);
  }
  
  public void display()
  {
    rect.display();
    image(image, rect.x, rect.y, rect.w, rect.h);
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
    if(MouseInRect(rect))
    {
      if(!startedQuest)
      {
        startedQuest = true;
        gameHandler.dHandler.startDialogue(dialogues.wendyStart,this);
        snd.playOneShot();
        return true;
      }
      if(startedQuest && !finishedQuest)
      {
        gameHandler.dHandler.startDialogue(dialogues.wendyInbetween, this);
        snd.playOneShot();
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
      gameHandler.wendyLeaves();
      gameHandler.dHandler.startDialogue(dialogues.wendyLeave,this);
    }
  }
}

public class Max extends Guest
{
  boolean startedQuest = false;
  boolean finishedQuest = false;
  boolean left = false;
  
  public Max()
  {
    super(1190, 399, 226, 651, folder + "c/max.png");
  }
  
  void display()
  {
    if(!left) {
      image(image, 0, 0, width, height);
      rect.display();
    }
  }
  
  public boolean checkClick()
  {
    if(MouseInRect(rect))
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
      gameHandler.maxLeaves();
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
    super(550, 448, 655, 283, folder + "c/mike_sleeping.png");
    secondState = new ImageRect(0, 0, 1920, 1080, folder + "c/mike_wet.png", false);
  }
  
  void display()
  {
    if(!finishedQuest && !left) {
      image(image, 0, 0, width, height);
      rect.display();
    }
    else if(finishedQuest && !left) secondState.display(); 
  }
  
  public boolean checkClick()
  {
    if(!startedQuest && !finishedQuest && MouseInRect(rect))
    {
      startedQuest = true;
      gameHandler.dHandler.startDialogue(dialogues.mikeStart,this);
      return true;
    }
    if(startedQuest && !finishedQuest && MouseInRect(rect))
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
  
  public boolean flood()
  {
    if(startedQuest && !left && !finishedQuest)
    {
      finishedQuest = true;
      gameHandler.dHandler.startDialogue(dialogues.mikeComplete, this);
      return true;
    }
    return false;
  }
  
  public void OnDialogueEnd()
  {
    if(!left && finishedQuest)
    {
      gameHandler.mikeLeaves();
      left = true;
    }
  }
}

public class Sarah extends Guest
{
  boolean startedQuest = false;
  boolean finishedQuest = false;
  boolean left = false;
  
  public Sarah()
  {
    super(1005, 483, 191, 445, folder + "c/sarah.png");
  }
  
  void display()
  {
    if(!left) {
      image(image, 0, 0, width, height);
      rect.display();
    }
  }
  
  public boolean checkClick()
  {
    if(MouseInRect(rect))
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
    if(startedQuest && !left && !finishedQuest && item.getType() == ItemType.Necklace)
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
      gameHandler.sarahLeaves();
      left = true;
    }
  }
}
