
enum MouseButton
{
  Left, Right, Middle
}

void mousePressed()
{
  if(runMenu) menu.onMouseDown();
  else if(!intro.isFinished()) intro.onMouse();
  else if(!canClose())
    gameHandler.handleMousePress();
  else if (!outro.isFinished()) outro.onMouse();
  else //endMenu.onMouse();
    exit();
}

void mouseReleased()
{
  gameHandler.handleMouseUp();
}
