

public class DialogueHandler
{
  public DialogueHandler()
  {
    
  }
  
  public void nextDialogue()
  {
    pushStyle();
    fill(255);
    stroke(0);
    strokeWeight(10);
    float rectW = width * .8f;
    float rectX = (width - rectW) /2f;
    float rectH = height * .2f;
    float rectY = height - rectH - (rectH *1f);
    rect(rectX, rectY, rectW, rectH);
    popStyle();
  }
  
  public void display()
  {
    
  }
}
