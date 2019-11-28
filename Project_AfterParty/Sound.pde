enum Music
{
  Intro, Game, None
}

enum Sound
{
  Click, Water, Bottle, Door, Hairdryer, Tap, Stairs
}

boolean muteMusic = false;

String clickSnd = "sound/click.mp3", 
  waterSnd = "sound/water.wav", 
  bottleSnd = "sound/bottle.mp3", 
  doorSnd = "sound/door.mp3", 
  hairdryerSnd = "sound/hairdryer.mp3",
  tapSnd = "sound/tap.mp3",
  stairsSnd = "sound/stairs.mp3";
  
String outroGoodSnd = "sound/outroGood.mp3";
String outroBadSnd = "sound/outroBad.mp3";
  
String introMsc = "sound/m/intro.mp3",
  gameMsc = "sound/m/game.wav";

public class SoundHandler
{
  Minim minim;
  AudioPlayer click;
  AudioPlayer water;
  AudioPlayer bottle;
  AudioPlayer door;
  AudioPlayer hairdryer;
  AudioPlayer tap;
  AudioPlayer stairs;
  
  AudioPlayer intro, game;
  
  AudioPlayer outroGood, outroBad;
  
  Music oldMusic = Music.None;
  
  public SoundHandler(Object obj)
  {
    minim = new Minim(obj);
    click = minim.loadFile(clickSnd);
    water = minim.loadFile(waterSnd);
    bottle = minim.loadFile(bottleSnd);
    door = minim.loadFile(doorSnd);
    hairdryer = minim.loadFile(hairdryerSnd);
    tap = minim.loadFile(tapSnd);
    stairs = minim.loadFile(stairsSnd);
    intro = minim.loadFile(introMsc);
    game = minim.loadFile(gameMsc);
    
    outroGood = minim.loadFile(outroGoodSnd);
    outroBad = minim.loadFile(outroBadSnd);
    
    intro.setGain(-16);
    game.setGain(-16);
    
    goodPlaying = false;
    badPlaying = false;
  }
  
  public void setMusic(Music m)
  {
    if(muteMusic) return;
    if(m == oldMusic) return;
    oldMusic = m;
    switch(m)
    {
    case Intro:
      intro.loop();
      game.rewind();
      game.pause();
      break;
    case Game:
      game.loop();
      intro.pause();
      intro.rewind();
      break;
    case None:
      intro.pause();
      intro.rewind();
      game.rewind();
      game.pause();
      break;
    }
  }
  
  public void playOneShot()
  {
    playOneShot(Sound.Click);
  }
  
  public void playOneShot(Sound s)
  {
    switch(s)
    {
    case Click:
      click.play(0);
      break;
    case Water:
      water.play(0);
      break;
    case Bottle:
      bottle.play(0);
      break;
    case Door:
      door.play(0);
      break;
    case Hairdryer:
      hairdryer.play(0);
      break;
    case Tap:
      tap.play(0);
      break;
    case Stairs:
      stairs.play(0);
      break;
    }
  }
  
  boolean goodPlaying = false;
  public void playOutroGood()
  {
    if(!goodPlaying)
    {
      goodPlaying = true;
      outroGood.play(0);
    }
  }
  
  boolean badPlaying = false;
  public void playOutroBad()
  {
    if(!badPlaying)
    {
      badPlaying = true;
      outroBad.play(0);
    }
  }
}
