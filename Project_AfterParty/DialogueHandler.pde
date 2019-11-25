interface DialogueCallbackReceiver
{
  public void OnDialogueEnd();
}

public class DialogueHandler
{
  public class Dialogue
  {
    String[] lines;
    int currentLine;
    boolean finished = false;
    
    public Dialogue(String[] lines)
    {
      this.lines = lines;
      currentLine = 0;
    }
    
    public String getLine()
    {
      if(finished) return "Error";
      if(currentLine >= lines.length || currentLine < 0)
      {
        finished = true;
        return "Error";
      }
      return lines[currentLine];
    }
    
    public void next() { currentLine++; if(currentLine >= lines.length) finished = true; }
    public void reset() { currentLine = 0; finished = false; }
  }
  
  public Dialogue createDialogue(String[] text) { return new Dialogue(text); }
  public Dialogue createDialogue(String text) { return createDialogue(new String[] { text }); }
  
  public boolean hasDialogue = false;
  
  public DialogueHandler()
  {
    
  }
  
  Dialogue current;
  
  public void display()
  {
    if(!hasDialogue) return;
    pushMatrix();
    pushStyle();
    fill(255);
    stroke(0);
    strokeWeight(10);
    float rectW = width * .8f;
    float rectX = (width - rectW) /2f;
    float rectH = height * .2f;
    float rectY = height - rectH - (rectH * .25f);
    rect(rectX, rectY, rectW, rectH);
    textAlign(CENTER, CENTER);
    textSize(60);
    fill(0);
    text(current.getLine(), rectX, rectY, rectW, rectH);
    popStyle();
    popMatrix();
  }
  
  DialogueCallbackReceiver receiver;
  
  public boolean startDialogue(Dialogue d, DialogueCallbackReceiver r)
  {
    if(!(current == null || current.finished)) return false;
    roomHandler.t.block();
    current = d;
    hasDialogue = true;
    receiver = r;
    return true;
  }
  
  public boolean mousePress()
  {
    if(!hasDialogue) return false;
    current.next();
    if(current.finished)
    {
      hasDialogue = false;
      current.reset();
      current = null;
      if(receiver != null) receiver.OnDialogueEnd();
      receiver = null;
      roomHandler.t.unblock();
      return true;
    }
    return true;
  }
  
  public DialogueContainer createContainer()
  {
    return new DialogueContainer();
  }
  
  public class DialogueContainer
  {
    Dialogue vasePickup;
    Dialogue vaseFillup;
    
    Dialogue remoteDiscover;
    Dialogue remoteDrying;
    Dialogue remoteWrongCombine;
    Dialogue remoteBatteries;
    
    Dialogue mopLiving;
    
    Dialogue hangoverCureNeeded;
    Dialogue hangoverBeans;
    Dialogue hangoverCupBeforeBeans;
    Dialogue hangoverCure;
    
    Dialogue lampBroken;
    Dialogue lampBulb;
    Dialogue lampFix;
    
    public DialogueContainer()
    {
      vasePickup = createDialogue(new String[]{
        "There's no water in this vase.",
        "If I place it back now they're going to notice"
      });
      vaseFillup = createDialogue("Now I can place it back");
      
      remoteDiscover = createDialogue(new String[]{
        "The remote is wet and the batteries no longer work.",
        "I'll have to fix this."
      });
      remoteDrying = createDialogue("It's dry now, but the batteries still don't work");
      remoteWrongCombine = createDialogue("Probably not a good idea to add batteries if it's still wet.");
      remoteBatteries = createDialogue("Alright, that's done!");
      
      mopLiving = createDialogue("Finally, clean.");
      
      hangoverCureNeeded = createDialogue(new String[]{
        "I feel terrible after that party.",
        "I'm going to need some coffee if I don't want my parents noticing."
      });
      hangoverBeans = createDialogue("All ready, just the cup.");
      hangoverCupBeforeBeans = createDialogue(new String[]{
        "I don't want water with a vague hint of coffee, I want coffee.",
        "I should get some beans first."
      });
      hangoverCure = createDialogue("Ahh, coffee.");
      
      lampBroken = createDialogue("Oh no, is that broken too?");
      lampBulb = createDialogue("Yes, now I can fix the lamp!");
      lampFix = createDialogue("Aand it's fixed.");
    }
  }
}
