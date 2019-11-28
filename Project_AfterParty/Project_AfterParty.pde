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

public String folder = "final/";

PFont fontDialogue;
PFont fontStraight;

boolean debug = false;

MainMenu menu;
boolean runMenu = true;
EndMenu endMenu;

SoundHandler snd;

void setup()
{
  fullScreen(FX2D);
  snd = new SoundHandler(this);
  c = new Cursor();
  noCursor();
  gameHandler = new GameHandler();
  gameHandler.initRooms();
  dialogues = gameHandler.dHandler.createContainer();
  intro = new IntroHandler();
  outro = new OutroHandler();
  fontDialogue = loadFont("fonts/IndieFlower-256.vlw");
  fontStraight = loadFont("fonts/Raleway-SemiBold-256.vlw");
  textFont(fontStraight);
  textSize(64);
  menu = new MainMenu();
  runMenu = true;
  endMenu = new EndMenu();
}

void draw()
{
  background(0);
  handClose();
  if(runMenu) {
    runMenu = !menu.run();
  }
  else if(!intro.isFinished()) {
    intro.display();
    //snd.setMusic(Music.Intro);
  }
  else if(!canClose()) {
    gameHandler.display();
    snd.setMusic(Music.Game);
  }
  else if(!outro.isFinished()) {
    if(!gameHandler.t.over()) {
      outro.displayGood();
      snd.setMusic(Music.None);
      snd.playOutroGood();
    }
    else {
      outro.displayBad();
      snd.setMusic(Music.None);
      snd.playOutroBad();
    }
  }
  //else {
  //  endMenu.setState(gameHandler.t.over());
  //  endMenu.run();
  //}
  /*
  {
    pushStyle(); pushMatrix();
    textAlign(CENTER, CENTER);
    textSize(200);
    fill(255);
    String t = "Won!\n"+gameHandler.t.getTime();
    if(gameHandler.t.over()) t = "Failed!";
    text(t, width/2f-300, height/2f-300, 600, 600);
    popStyle(); popMatrix();
  }
  */
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
  return (gameHandler.tHandler.allDone() && (!gameHandler.dHandler.hasDialogue)) || gameHandler.t.over();
}

public class Cursor
{
  PImage hand_selected;
  PImage hand_closed;
  
  float w = 64, h = 64;
  
  PImage current;
  
  public Cursor()
  {
    hand_selected = loadImage("final/hand_selected.png");
    hand_closed = loadImage("final/hand_closed.png");
    current = hand_closed;
  }
  
  public void show()
  {
    image(current, mouseX - w/2f, mouseY - h/2f, w, h);
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
