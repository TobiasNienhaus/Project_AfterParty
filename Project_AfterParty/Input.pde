
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
  if(!intro.isFinished()) intro.onMouse();
  else if(!canClose())
    gameHandler.handleMousePress();
  else if (!outro.isFinished()) outro.onMouse();
  else exit();
}

void mouseReleased()
{
  gameHandler.handleMouseUp();
}

void keyPressed()
{
  gameHandler.handleKeyPress();
}
