
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
    gameHandler.handleMousePress();
  else
    exit();
}

void mouseReleased()
{
  gameHandler.handleMouseUp();
}

void keyPressed()
{
  gameHandler.handleKeyPress();
}
