import processing.sound.*;

Room active;

RoomHandler roomHandler;

void setup()
{
  fullScreen(FX2D);
  roomHandler = new RoomHandler();
  roomHandler.initRooms();
}

void draw()
{
  background(0);
  roomHandler.display();
}
