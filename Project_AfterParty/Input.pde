
enum MouseButton
{
  Left, Right, Middle
}

enum Key
{
  A, S, D, W
}

void mousePressed()
{
  if(!canClose())
    roomHandler.handleMousePress();
  else
    exit();
}

void mouseReleased()
{
  roomHandler.handleMouseUp();
}

void keyPressed()
{
  roomHandler.handleKeyPress();
}
