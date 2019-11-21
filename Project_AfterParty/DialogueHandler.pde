interface DialogueCallbackReceiver
{
  public void OnDialogueEnd();
}

public class DialogueHandler
{
  class Dialogue
  {
    String[] lines;
    int currentLine;
    boolean finished = false;
    
    Dialogue(String[] lines)
    {
      this.lines = lines;
      currentLine = 0;
    }
    
    String getLine()
    {
      if(finished) return "Error";
      if(currentLine >= lines.length || currentLine < 0)
      {
        finished = true;
        return "Error";
      }
      return lines[currentLine];
    }
    
    void next() { currentLine++; if(currentLine >= lines.length) finished = true; }
    void reset() { currentLine = 0; finished = false; }
  }
  
  public boolean hasDialogue = false;
  
  public DialogueHandler()
  {
    loadDialogue();
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
      return true;
    }
    return true;
  }
  
  Dialogue char1;
  Dialogue char1End;
  
  Dialogue hatPickup;
  
  Dialogue char2;
  Dialogue char2End;
  
  void loadDialogue()
  {
    char1 = new Dialogue(new String[]{
      "This is a character",
      "He talks a bit",
      "Maybe a bit more"
    });
    char1End = new Dialogue(new String[]{
      "Thanks for getting back my stuff",
      "I will leave now"
    });
    hatPickup = new Dialogue(new String[]{
      "That must be [witch]'s hat",
      "Better get it back to her"
    });
    char2 = new Dialogue(new String[]{
      "I lost my glasses.\nCan you find them for me?"
    });
    char2End = new Dialogue(new String[]{
      "Oh you found my glasses!!",
      "Thank you so much!"
    });
  }
}
