
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
  roomHandler.handleMousePress();
}

void mouseReleased()
{
  roomHandler.handleMouseUp();
}

void keyPressed()
{
  roomHandler.handleKeyPress();
}
