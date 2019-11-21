
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

public class VampireTest extends Guest
{
  boolean done = false;
  boolean inEndDialogue = false;
  DialogueHandler.Dialogue normal;
  DialogueHandler.Dialogue end;
  
  public VampireTest(float x, float y, float w, float h)
  {
    super(x, y, w, h, "ph/vampire.png");
    normal = roomHandler.dHandler.createDialogue(new String[]{
      "Im a vampire and I lost my glasses",
      "Could you maybe help me?"
    });
    end = roomHandler.dHandler.createDialogue(new String[]{
      "MY GLASSES!!!",
      "Thank you so much for helping me!"
    });
  }
  
  void display()
  {
    if(!done) super.display();
  }
  
  public boolean checkClick()
  {
    if(MouseInRect(iRect))
      roomHandler.dHandler.startDialogue(normal, this);
    return false;
  }
  
  public boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.GlassesComplete)
    {
      if(MouseInRect(iRect))
      {
        inEndDialogue = true;
        roomHandler.dHandler.startDialogue(end,this);
        roomHandler.tHandler.getGlassesTask().fulfill();
        return true;
      }
    }
    return false;
  }
  
  public void OnDialogueEnd()
  {
    if(inEndDialogue) done = true;
  }
}

public class WitchTest extends Guest
{
  boolean done = false;
  boolean inEndDialogue = false;
  DialogueHandler.Dialogue normal;
  DialogueHandler.Dialogue end;
  
  public WitchTest(float x, float y, float w, float h)
  {
    super(x, y, w, h, "ph/witch.png");
    normal = roomHandler.dHandler.createDialogue(new String[]{
      "Im a witch and I lost my hat",
      "Could you maybe help me?"
    });
    end = roomHandler.dHandler.createDialogue(new String[]{
      "MY HAT!!!",
      "Thank you so much for helping me!"
    });
  }
  
  void display()
  {
    if(!done) super.display();
  }
  
  public boolean checkClick()
  {
    if(MouseInRect(iRect))
      roomHandler.dHandler.startDialogue(normal, this);
    return false;
  }
  
  public boolean dropItem(Item item)
  {
    if(item.getType() == ItemType.Hat)
    {
      if(MouseInRect(iRect))
      {
        inEndDialogue = true;
        roomHandler.dHandler.startDialogue(end,this);
        roomHandler.tHandler.getHatTask().fulfill();
        return true;
      }
    }
    return false;
  }
  
  public void OnDialogueEnd()
  {
    if(inEndDialogue) done = true;
  }
}
