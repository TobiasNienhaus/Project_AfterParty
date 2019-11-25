
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
