interface DialogueCallbackReceiver
{
  public void OnDialogueEnd();
}

public class DialogueHandler
{
  public class Dialogue
  {
    String[] lines;
    int currentLine;
    boolean finished = false;
    
    public Dialogue(String[] lines)
    {
      this.lines = lines;
      currentLine = 0;
    }
    
    public String getLine()
    {
      if(finished) return "Error";
      if(currentLine >= lines.length || currentLine < 0)
      {
        finished = true;
        return "Error";
      }
      return lines[currentLine];
    }
    
    public void next() { currentLine++; if(currentLine >= lines.length) finished = true; }
    public void reset() { currentLine = 0; finished = false; }
  }
  
  public Dialogue createDialogue(String[] text) { return new Dialogue(text); }
  public Dialogue createDialogue(String text) { return createDialogue(new String[] { text }); }
  
  public boolean hasDialogue = false;
  
  public DialogueHandler()
  {
    
  }
  
  Dialogue current;
  
  public void display()
  {
    if(!hasDialogue) return;
    pushMatrix();
    pushStyle();
    fill(255);
    stroke(0);
    strokeWeight(3);
    textFont(fontDialogue);
    textSize(60);
    textLeading(60);
    float rectW = width * .8f;
    float rectX = (width - rectW) /2f;
    float rectH = height * .2f;
    float rectY = height - rectH - (rectH * .25f);
    rect(rectX, rectY, rectW, rectH, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(current.getLine(), rectX+10, rectY+10, rectW-20, rectH-20);
    popStyle();
    popMatrix();
  }
  
  DialogueCallbackReceiver receiver;
  
  public boolean startDialogue(Dialogue d, DialogueCallbackReceiver r)
  {
    if(!(current == null || current.finished)) return false;
    gameHandler.t.block();
    current = d;
    hasDialogue = true;
    receiver = r;
    return true;
  }
  
  public boolean mousePress()
  {
    if(!hasDialogue) return false;
    current.next();
    snd.playOneShot();
    if(current.finished)
    {
      hasDialogue = false;
      current.reset();
      current = null;
      if(receiver != null) receiver.OnDialogueEnd();
      receiver = null;
      gameHandler.t.unblock();
      return true;
    }
    return true;
  }
  
  public DialogueContainer createContainer()
  {
    return new DialogueContainer();
  }
  
  public class DialogueContainer
  {
    Dialogue vasePickup;
    Dialogue vaseFillup;
    
    Dialogue remoteDiscover;
    Dialogue remoteDrying;
    Dialogue remoteWrongCombine;
    Dialogue remoteBatteries;
    
    Dialogue mopLiving;
    
    Dialogue hangoverCureNeeded;
    Dialogue hangoverBeans;
    Dialogue hangoverCupBeforeBeans;
    Dialogue hangoverCure;
    
    Dialogue lampBroken;
    Dialogue lampBulb;
    Dialogue lampFix;
    
    Dialogue bottle1;
    Dialogue bottle2;
    Dialogue bottle3;
    Dialogue bottle4;
    Dialogue bottle5;
    Dialogue bottle6;
    
    Dialogue wendyStart;
    Dialogue wendyInbetween;
    Dialogue wendyComplete;
    Dialogue wendyLeave;
    Dialogue wendyFindHat;
    
    Dialogue maxStart;
    Dialogue maxInbetween;
    Dialogue maxComplete;
    
    Dialogue mikeStart;
    Dialogue mikeInbetween;
    Dialogue mikeComplete;
    
    Dialogue sarahStart;
    Dialogue sarahInbetween;
    Dialogue sarahComplete;
    
    Dialogue noMop;
    
    Dialogue necklace;
    Dialogue cup;
    Dialogue beans;
    Dialogue hairdryer;
    Dialogue mop;
    Dialogue badge;
    
    public DialogueContainer()
    {
      vasePickup = createDialogue(new String[]{
        "There's no water in this vase.",
        "If I place it back now they're going to notice."
      });
      vaseFillup = createDialogue("Now I can place it back on the desk.");
      
      remoteDiscover = createDialogue(new String[]{
        "The remote is wet and the batteries no longer work.",
        "I'll have to fix this."
      });
      remoteDrying = createDialogue("It's dry now, but the batteries still don't work");
      remoteWrongCombine = createDialogue("Probably not a good idea to add batteries if it's still wet.");
      remoteBatteries = createDialogue("Alright, that's done!");
      
      mopLiving = createDialogue("Finally, clean.");
      
      hangoverCureNeeded = createDialogue(new String[]{
        "I feel terrible after that party.",
        "I'm going to need some coffee if I don't want my parents noticing."
      });
      hangoverBeans = createDialogue("All ready, just the cup.");
      hangoverCupBeforeBeans = createDialogue(new String[]{
        "I don't want water with a vague hint of coffee, I want coffee.",
        "I should get some beans first."
      });
      hangoverCure = createDialogue("Ahh, coffee.");
      
      lampBroken = createDialogue("Oh no, is that broken too?");
      lampBulb = createDialogue("Yes, now I can fix the lamp!");
      lampFix = createDialogue("Aand it's fixed.");
      
      bottle1 = createDialogue("Ohh god, how many of these things are there?");
      bottle2 = createDialogue("Well, that's two.");
      bottle3 = createDialogue("Three now.");
      bottle4 = createDialogue("Four.");
      bottle5 = createDialogue("And that's five.");
      bottle6 = createDialogue("Looks like that's all of them.");
      
      noMop = createDialogue("I will need a mop for that...");
      necklace = createDialogue("Sarah's pendant, I should bring this to her.");
      cup = createDialogue("A coffee cup for a cup of coffee.");
      beans = createDialogue("Those are strong. Should be enough for a cup of good hangover coffee");
      hairdryer = createDialogue("Maybe this will work to dry the remote with?");
      mop = createDialogue("This should clean up the spillage in the living room");
      badge = createDialogue("Max' badge, I should bring this to him.");
      
      wendyStart = createDialogue(new String[]{
        "Player: Hey, Wendy, I’m sorry for breaking up the fun, but you have to leave.",
        "Wendy (panicky): No! I can’t leave without my hat – I will be cursed!",
        "Player: What? Cursed?",
        "Wendy: Yes! That was my Grandmother’s hat and if I don’t bring it back, she will curse me!",
        "Player: Ugh fine, I will find it. But after I do - you are going to leave."
      });
      wendyInbetween = createDialogue("Wendy: Have you found my hat yet?");
      wendyComplete = createDialogue(new String[]{
        "Player: Here you go, I found your little hat.",
        "Wendy: Oh, thank you! I will be free of my Grandmother’s curse!",
        "Player: Yeah and also you are free to leave this place now.",
        "Wendy: Yes, of course. I will be on my way. Goodbye!"
      });
      wendyLeave = createDialogue("Player (silently): What a weirdo.");
      wendyFindHat = createDialogue("There's Wendys hat!");
      
      maxStart = createDialogue(new String[]{
        "Player: Howdy, Max! Can I ask you to…",
        "Max: Man, have you seen my golden badge anywhere?",
        "Player: Badge? Man really…",
        "Max: Dude, I’m not going anywhere without it, it’s my dad’s.", 
        "He is going to lynch me if I come back without it!",
        "You should look somewhere in the living room for it.",
        "That’s the place, where I blacked out yesterday.",
        "Player: (silently) Jesus, why can’t he look for it himself?",
        "All right, here is the deal – when I find it you have to leave ASAP, okay?",
        "Max: You got it chief!"
      });
      maxInbetween = createDialogue("Max: Have you found my badge yet?");
      maxComplete = createDialogue(new String[]{
        "Player: Okay, partner. Here you go.",
        "Max: Thanks man! You’re a lifesaver.",
        "Player: Yeah, it’s on the house.",
        "Max: Happy trails (winks)."
      });
      
      mikeStart = createDialogue(new String[]{
        "Player: Mike? Mike! Come on wake-up man!",
        "Mike: ZZzzzzzZz…",
        "Player: Dammit Mike. How do I wake you up?",
        "Mike: ZzzZzzz…",
        "Player: Huh. How about some \"holy water\", eh?"
      });
      mikeInbetween = createDialogue("Mike: ZZzzzZzZzZZ...");
      mikeComplete = createDialogue(new String[]{
        "Mike: AAAAHHHH COLD, COLD!",
        "...",
        "Mike: Oh.",
        "Player: Morning Mike.",
        "Mike: Good morning.",
        "Player: It’s time to go, Mike.",
        "Mike: Alright dude. I’m heading out then.",
        "Player: Yeah, see you later man."
      });
      
      sarahStart = createDialogue(new String[]{
        "Player: Sarah, there you are.",
        "Sarah: Oh…hello there.",
        "Player: Why are you looking so sad?",
        "Sarah: I…I lost my cross necklace and I have to go to church tomorrow.",
        "I’m so ashamed of myself.",
        "Player: Hey now, don’t worry about I will help you out.",
        "But after that I will also have to ask you to leave, because my parents are coming back soon.",
        "Sarah: Yes of course, I can understand that.",
        "Last thing that I can remember clearly is that…I was pouring drinks in the kitchen.",
        "Player: Hmm, okay. I can look around in there."
      });
      sarahInbetween = createDialogue("Sarah: Please tell me, you found the necklace.");
      sarahComplete = createDialogue(new String[]{
        "Sarah: Dear Lord, you found it!",
        "Player: Yup, here you go Sarah.",
        "Sarah: God bless your soul and good luck with the parents!",
        "Player: Thanks! I really think that I will need it."
      });
    }
  }
}
