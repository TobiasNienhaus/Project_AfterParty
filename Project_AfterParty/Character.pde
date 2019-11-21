
public abstract class Character implements DialogueCallbackReceiver
{
  ImageRect iRect;
  public Character(float x, float y, float w, float h, String imgPath)
  {
    iRect = new ImageRect(x, y, w, h, imgPath);
  }
  
  public void display()
  {
    iRect.display();
  }
}
