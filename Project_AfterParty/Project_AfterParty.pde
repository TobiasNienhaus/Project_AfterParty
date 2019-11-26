import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;

GameHandler gameHandler;
DialogueHandler.DialogueContainer dialogues;

IntroHandler intro;
OutroHandler outro;

PImage hand_selected;
PImage hand_closed;

public String folder = "ph/";

PFont fontDialogue;
PFont fontStraight;

void setup()
{
  fullScreen(FX2D);
  c = new Cursor();
  noCursor();
  gameHandler = new GameHandler();
  gameHandler.initRooms();
  dialogues = gameHandler.dHandler.createContainer();
  intro = new IntroHandler();
  outro = new OutroHandler();
  fontDialogue = loadFont("IndieFlower-256.vlw");
  fontStraight = loadFont("Raleway-SemiBold-256.vlw");
  textFont(fontStraight);
  textSize(64);
}

void draw()
{
  background(0);
  handClose();
  if(!intro.isFinished()) intro.display();
  else if(!canClose()) 
    gameHandler.display();
  else if(!outro.isFinished()) outro.display();
  else
  {
    pushStyle(); pushMatrix();
    textAlign(CENTER, CENTER);
    textSize(200);
    fill(255);
    text("DONE!", width/2f-300, height/2f-300, 600, 600);
    popStyle(); popMatrix();
  }
  c.show();
}

Cursor c;

public void handClose()
{
  c.setClosed();
}

public void handSelected()
{
  c.setSelected();
}

boolean canClose()
{
  return (gameHandler.tHandler.allDone() && (!gameHandler.dHandler.hasDialogue));
}

public class Cursor
{
  PImage hand_selected;
  PImage hand_closed;
  
  PImage current;
  
  public Cursor()
  {
    hand_selected = loadImage("final/hand_selected.png");
    hand_closed = loadImage("final/hand_closed.png");
    current = hand_closed;
  }
  
  public void show()
  {
    image(current, mouseX - 16, mouseY - 16, 32, 32);
  }
  
  public void setClosed()
  {
    current = hand_closed;
  }
  
  public void setSelected()
  {
    current = hand_selected;
  }
}
