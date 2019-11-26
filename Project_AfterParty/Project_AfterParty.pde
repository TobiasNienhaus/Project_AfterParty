import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;

GameHandler gameHandler;
DialogueHandler.DialogueContainer dialogues;

PImage hand_selected;
PImage hand_closed;

public String folder = "ph/";

void setup()
{
  fullScreen(FX2D);
  hand_selected = loadImage("final/hand_selected.png");
  hand_closed = loadImage("final/hand_closed.png");
  gameHandler = new GameHandler();
  gameHandler.initRooms();
  dialogues = gameHandler.dHandler.createContainer();
}

void draw()
{
  background(0);
  cursor(hand_closed);
  if(!canClose()) 
    gameHandler.display();
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
  return (gameHandler.tHandler.allDone() && (!gameHandler.dHandler.hasDialogue));
}
