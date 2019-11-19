
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

void keyPressed()
{
  roomHandler.handleKeyPress();
}
