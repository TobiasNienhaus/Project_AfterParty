

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
      if(currentLine > lines.length)
      {
        finished = true;
        return "Error";
      }
      return lines[currentLine];
    }
  }
  
  public boolean hasText = true;
  
  public DialogueHandler()
  {
    textIndex = 0;
    if(dialogue[textIndex] == "") hasText = false;
  }
  
  public void nextDialogue()
  {
    textIndex++;
    if(textIndex > dialogue.length) {
      hasText = false;
      return;
    }
    if(dialogue[textIndex] == "") hasText = false;
    else hasText = true;
  }
  
  String[] dialogue = {
    "",
    "Test1Test1Test1Test1Test1Test1\nTest1Test1Test1Test1Test1Test1",
    "",
    "Test2Test2Test2Test2Test2Test2\nTest2Test2Test2Test2Test2Test2"
  };
  int textIndex = 0;
  
  public void display()
  {
    if(!hasText) return;
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
    text(dialogue[textIndex], rectX, rectY, rectW, rectH);
    popStyle();
    popMatrix();
  }
  
  public boolean mousePress()
  {
    if(!hasText) return false;
    nextDialogue();
    return true;
  }
}
