import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;

RoomHandler roomHandler;

PImage hand_selected;
PImage hand_closed;



void setup()
{
  fullScreen(FX2D);
  hand_selected = loadImage("final/hand_selected.png");
  hand_closed = loadImage("final/hand_closed.png");
  roomHandler = new RoomHandler();
  roomHandler.initRooms();
}

void draw()
{
  background(0);
  cursor(hand_closed);
  if(!canClose()) 
    roomHandler.display();
  else
  {
    pushStyle(); pushMatrix();
    textAlign(CENTER, CENTER);
    textSize(200);
    fill(255);
    text("DONE!", width/2f-300, height/2f-300, 600, 600);
    popStyle(); popMatrix();
  }
}

boolean canClose()
{
  return (roomHandler.tHandler.allDone() && (!roomHandler.dHandler.hasDialogue));
}
