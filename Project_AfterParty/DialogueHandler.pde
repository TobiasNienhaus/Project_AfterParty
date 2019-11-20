

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
  
  Dialogue test1;
  Dialogue test2;
  Dialogue test3;
  
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
  
  public boolean startDialogue(Dialogue d)
  {
    if(!(current == null || current.finished)) return false;
    current = d;
    hasDialogue = true;
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
      return true;
    }
    return true;
  }
  
  void loadDialogue()
  {
    test1 = new Dialogue(new String[]{
      "Test\nThis is a test",
      "Test\nThis is the second line",
      "Test\nThis is the third line"
    });
    test2 = new Dialogue(new String[]{
      "This is a second test\nOne",
      "This is a second test\nTwo",
      "This is a second test\nThree",
    });
    test3 = new Dialogue(new String[]{
      "WOW, a third test!",
      "1", "2", "3", "4", "5", "6", "endless possibilities", "7", "9", "10"
    });
  }
}
