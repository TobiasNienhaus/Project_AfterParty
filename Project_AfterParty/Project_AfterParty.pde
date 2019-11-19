import processing.sound.*;

Room active;

RoomHandler roomHandler;

void setup()
{
  fullScreen(FX2D, 2);
  roomHandler = new RoomHandler();
  roomHandler.initRooms();
}

void draw()
{
  background(0);
  roomHandler.display();
}
