enum Music
{
  Intro, Game, Outro
}

enum Sound
{
  Click, Water, Bottle, Door, Hairdryer, Tap, Stairs;
}

String clickSnd = "sound/click.mp3", 
  waterSnd = "sound/water.wav", 
  bottleSnd = "sound/bottle.mp3", 
  doorSnd = "sound/door.mp3", 
  hairdryerSnd = "sound/hairdryer.mp3",
  tapSnd = "sound/tap.mp3",
  stairsSnd = "sound/stairs.mp3";
  
String introMsc = "sound/intro.mp3",
  gameMsc = "sound/game.mp3",
  outroMsc = "sound/outro.mp3";

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
  
  AudioPlayer intro, game, outro;
  
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
    outro = minim.loadFile(outroMsc);
    
    intro.setGain(-16);
    game.setGain(-16);
    outro.setGain(-16);
    
    intro.skip(75000);
  }
  
  public void setMusic(Music m)
  {
    switch(m)
    {
    case Intro:
      intro.play();
      game.rewind();
      game.pause();
      outro.rewind();
      outro.pause();
      break;
    case Game:
      game.play();
      intro.rewind();
      intro.pause();
      outro.rewind();
      outro.pause();
      break;
    case Outro:
      outro.play();
      intro.rewind();
      intro.pause();
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
}
