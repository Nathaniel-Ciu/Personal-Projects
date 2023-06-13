// global variables 
ArrayList<Balloon> balloons = new ArrayList<Balloon>();

private int balloonsPopped = 0; 
private int timer = 0;
private int ticks = 65; // not totally accurate but good enough

private int spawnRate = 1; // lower number = lower spawn time
private int goesUpBy = 30;
private int howOftenMoves = 30;
private int balloonLimit = 5;

private int bWidth = 50; 
private int bLength = 60; 
private color bcolor;
private color oldColor;

private color overrideBColor;
private int red = 0;
private int green = 0;
private int blue = 0;

private String gameState;

private int textSize = 50;

private int bTimerOverride = 0;
private int bTimer = 15; 

void setup() {
  size(1080, 720);
  background(211, 211, 211);
  gameState = "START";  
}

void reset() {
  balloons.clear();
  balloonsPopped = 0;
  timer = 0;
  if (bTimerOverride != 0) {
    bTimer = bTimerOverride;
  } else {
    bTimer = 15;
  }
}

void draw() {
  if (gameState == "START") {
    startScreen();
  } else if (gameState == "PLAY") {
    gamePlay();
  } else if (gameState == "ENDLESS") {
    gameEndless();
  } else if (gameState == "END") {
    gameEnd();
  } else if (gameState == "SETTINGS") {
    gameSettings();
  } else if (gameState == "SETTINGS1") {
    gameSettings1(); 
  } else if (gameState == "SETTINGS2") {
    gameSettings2(); 
  } else if (gameState == "SETTINGS3") {
    gameSettings3(); 
  } else if (gameState == "SETTINGS4") {
    gameSettings4();
  } else if (gameState == "SETTINGS5") {
    gameSettings5();
  } else if (gameState == "SETTINGS6") {
    gameSettings6(); 
  } else if (gameState == "RED") {
    gameSettingsRed();
  } else if (gameState == "BLUE") {
    gameSettingsBlue();
  } else if (gameState == "GREEN") {
    gameSettingsGreen();
  } else if (gameState == "RANDOMCOLORS") {
    gameSettingsRandomColor();
  } else if (gameState == "SETTINGS7") {
    gameSettings7(); 
  } else if (gameState == "SETTINGS8") {
    gameSettings8(); 
  } else if (gameState == "TIMECHALLENGE") { // time challenge code 
    timeChallenge(); 
  } else if (gameState == "PLAYTIME") {
   playTimeChallenge(); 
  } else if (gameState == "TIMEEND") {
   timeEnd(); 
  }
  if (keyPressed) {
    if (frameCount % 8 == 0) {
      if (key == '+') {
        textSize += 5;
        clearBackground();
      }
       if (key == '-') {
        textSize -= 5;
        clearBackground();
      }
    }
    if (key == 'e' && checkGameStateColor()) {
     gameState = "ENDLESS"; 
    }
    if (key == 'r' && checkGameStateColor()) {
      gameState = "START";
    }
    if (key == 's' && checkGameStateColor()) {
     gameState = "SETTINGS"; 
    } 
    if (key == 'q' && checkGameStateColor()) {
    gameState = "TIMECHALLENGE";
    }
  }
}

boolean checkGameStateColor() {
  return (gameState != "RED" && gameState != "GREEN" && gameState != "BLUE");  // note the balloon color setting doesn't work if it doesn't go back to the full RGB value screen (that's where the if statement is to set overrideBColor)
}

void clearBackground() {
  background(211, 211, 211);
}

void startScreen() {
  clearBackground();
  reset();
  textAlign(CENTER);
  textSize(textSize);
  fill(57, 73, 171);
  text("Click Anywhere to Play!", width/2,  height/2 - textSize);
  textSize(textSize - 20);
  text("Click on the balloons before they fly away!", width/2, height/2); 
  text("Click 'e' for endless mode, 'r' to reset, 'q' for time challenge, 's' for settings", width/2, height/2 + textSize);
  if (mousePressed == true) {
    gameState = "PLAY";
  }
}

void spawnBalloons() {
      Balloon temp;
      int x = (int) random(width - bWidth);
      int y = (int) random(height/2, height);
      if (overrideBColor == 0 && bcolor == oldColor) { 
        int r = (int) random(0, 255);
        int g = (int) random(0, 255);
        int b = (int) random(0, 255);
        bcolor = color(r, g, b);
        oldColor = bcolor;
      } else {
        bcolor = overrideBColor;
        oldColor = overrideBColor; // so if statement for colors can work
      } 
      balloons.add(temp = new Balloon(x, y, bWidth, bLength, bcolor)); 
}

void updateBalloons() {
   for (int index = 0; index < balloons.size(); index++) {
    balloons.get(index).balloonUpdate(goesUpBy);
    balloons.get(index).drawBalloon(); 
      if (balloons.get(index).ypos < - bLength && gameState == "PLAY") {
        gameState = "END";
      } else if (balloons.get(index).ypos < - bLength) {
        balloons.remove(index);
        index--; // because for ArrayList when you delete something the everything in front gets shifted down
      }
   }
}

void gamePlay() {
    if (frameCount % ticks == 0) {
      timer++; // not fully accurate of time passed 
    }
   if (frameCount % howOftenMoves == 0) {
      background(211, 211, 211);
      fill(57, 73, 171);
      textSize(textSize - 20);
      textAlign(CENTER);
      text("Time " + timer + " | BalloonsPopped " + balloonsPopped, 0 + textSize * 5, height - textSize / 4);
     if (frameCount % (spawnRate) == 0 && balloons.size() < balloonLimit) { 
         spawnBalloons();
      }
      updateBalloons();
   }
}

void gameEndless() {
  if (frameCount % howOftenMoves == 0) {
      background(211, 211, 211);
      fill(57, 73, 171);
      textSize(textSize);
      textAlign(CENTER);
      text("ENDLESS MODE", 0 + textSize * 4, height - textSize / 4);
      textSize(textSize - 20);
      text("Press 'r' to reset", 0 + textSize * 19, height - textSize / 4);
      if (frameCount % (spawnRate) == 0 && balloons.size() < balloonLimit) { 
        spawnBalloons();
      }
      updateBalloons();
   }
}

void timeChallenge() {
  clearBackground();
  reset();
  textAlign(CENTER);
  textSize(textSize);
  fill(57, 73, 171);
  text("Time Challenge! Click Anywhere to Play!", width/2,  height/2 - textSize);
  textSize(textSize - 20);
  text("Click as many balloons you can!", width/2, height/2); 
  text("Click 'e' for endless mode, 'r' to reset, 's' for settings", width/2, height/2 + textSize);
  textSize(textSize - 30);
  if (mousePressed == true) {
    gameState = "PLAYTIME";
  }
}


void playTimeChallenge() {
  if (frameCount % ticks == 0) {
       bTimer--; // not fully accurate of time passed 
   }
  if (frameCount % howOftenMoves == 0 && bTimer > 0) {
      background(211, 211, 211);
      fill(57, 73, 171);
      textSize(textSize - 20);
      textAlign(CENTER);
      text("Time " + bTimer + " | BalloonsPopped " + balloonsPopped, 0 + textSize * 5, height - textSize / 4);
      textSize(textSize - 20);
      text("Press 'r' to reset", 0 + textSize * 19, height - textSize / 4);
      if (frameCount % (spawnRate) == 0 && balloons.size() < balloonLimit) { 
        spawnBalloons();
       }
      updateBalloons();
   }
   if (bTimer == 0) {
     gameState = "TIMEEND";
   }
}

void timeEnd() {
  clearBackground();
  textAlign(CENTER);
  textSize(textSize);
  fill(57, 73, 171);
  text("Time's Up!", width/2,  height/2 - textSize);
  textSize(textSize - 20);
  if (bTimerOverride == 0) {
    text("You popped " + balloonsPopped + " balloons in 15 'seconds'", width/2, height/2); 
  } else {
    text("You popped " + balloonsPopped + " balloons in " + bTimerOverride + " 'seconds'", width/2, height/2); 
  }
  text("Press 'r' to reset to Main Screen, 'q' to Time Challenege Start", width/2, height/2 + textSize);
  if (frameRate % 10 == 0) {
    reset(); 
  }
}

void gameEnd() {
  clearBackground();
  textAlign(CENTER);
  textSize(textSize);
  fill(57, 73, 171);
  text("Game Over!", width/2,  height/2 - textSize);
  textSize(textSize - 20);
  text("You popped " + balloonsPopped + " balloons"  + " | You lasted " + timer, width/2, height/2); 
  text("Press 'r' to reset", width/2, height/2 + textSize);
  if (frameRate % 10 == 0) {
    reset(); 
  }
}

void gameSettings() {
  clearBackground(); 
  fill(57, 73, 171);
  textSize(textSize);
  textAlign(CENTER);
  text("Press # key correlated to setting you want to change", width/2, height/8);
  textAlign(RIGHT);
  text("1) Balloon Spawn Rate", width/2, height/8 + textSize);
  textAlign(CENTER);
  text("2) # of Balloon allowed on screen", width/2 - (textSize * 2.5), height/8 + (2 * textSize));
  textAlign(RIGHT);
  text("3) Balloon Speed", width/2 - (textSize * 2.44 - textSize * 0.16), height/8 + (3 * textSize));
  text("4) Balloon Width", width/2 - (textSize * 2.44), height/8 + (4 * textSize));
  text("5) Balloon Length", width/2 - (textSize * 2), height/8 + (5 * textSize));
  text("6) Balloon Color", width/2 - (textSize * 2.6 + textSize * .08), height/8 + (6 * textSize));
  textAlign(CENTER);
  text("7) Time given for Time Challenge", width/2 - (textSize * 2.55), height/8 + (7 * textSize));
  textAlign(RIGHT);
  text("8) Reset to Defaults", width/2 - (textSize + textSize / 3), height/8 + (8 * textSize));
  text("'r' to Start Menu", width/2, height/8 + (11 * textSize));
  
  if (key == '1') {
    gameState = "SETTINGS1"; 
  }
  if (key == '2') {
    gameState = "SETTINGS2";
  }
  if (key == '3') {
    gameState = "SETTINGS3";
  }
  if (key == '4') {
    gameState = "SETTINGS4"; 
  }
  if (key == '5') {
    gameState = "SETTINGS5";
  }
  if (key == '6') {
    gameState = "SETTINGS6";
  } 
  if (key == '7') {
    gameState = "SETTINGS7";
  } 
  if (key == '8') {
    gameState = "SETTINGS8";
  } 
}

void gameSettings1() {//SpawnTime
    clearBackground();
    textSize(textSize);
    textAlign(CENTER);
    text("Balloon Spawn Time: " + (spawnRate) + "\n (Lower the # the less time balloons take to spawn)",  width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 5,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 5, \n press 's' to go back to settings",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
        if (key == 'p') {
          spawnRate += 5; 
        }
        if (key == 'u') {
          spawnRate -= 5; 
        }
        if (key == 'o') {
          spawnRate += 1; 
        }
        if (key == 'i') {
          spawnRate -= 1; 
        } 
      }
    }
    if (spawnRate < 1) {
      spawnRate = 1;
    }
}

void gameSettings2() { //balloonLimit
    clearBackground();
    textSize(textSize);
    textAlign(CENTER);
    text("# of Balloons on Screen: " + (balloonLimit),  width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 5,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 5, \n press 's' to go back to settings",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
        if (key == 'p') {
          balloonLimit += 5; 
        }
        if (key == 'u') {
          balloonLimit -= 5; 
        }
        if (key == 'o') {
          balloonLimit += 1; 
        }
        if (key == 'i') {
          balloonLimit -= 1; 
        } 
      }
    }
    if (balloonLimit < 1) {
      balloonLimit = 1;
    }
}

void gameSettings3() { //balloon speed
    clearBackground();
    textSize(textSize);
    textAlign(CENTER);
    text("Balloon Speed: " + (goesUpBy) + "\n (Higher the # the faster balloons rise)",  width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 5,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 5, \n press 's' to go back to settings",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
        if (key == 'p') {
          goesUpBy += 5; 
        }
        if (key == 'u') {
          goesUpBy -= 5; 
        }
        if (key == 'o') {
          goesUpBy += 1; 
        }
        if (key == 'i') {
          goesUpBy -= 1; 
        } 
      }
    }
    if (goesUpBy < 1) {
      goesUpBy = 1;
    }
}

void gameSettings4() { //bWidth
  clearBackground();
    textSize(textSize);
    textAlign(CENTER);
    text("Balloon Width: " + (bWidth) + "\n (Higher the # the fatter balloons are)",  width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 5,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 5, \n press 's' to go back to settings",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
        if (key == 'p') {
          bWidth += 5; 
        }
        if (key == 'u') {
          bWidth -= 5; 
        }
        if (key == 'o') {
          bWidth += 1; 
        }
        if (key == 'i') {
          bWidth -= 1; 
        } 
      }
    }
    if (bWidth < 1) {
      bWidth = 1;
    }
}

void gameSettings5() {//bLength
    clearBackground();
    textSize(textSize);
    textAlign(CENTER);
    text("Balloon Length: " + (bLength) + "\n (Higher the # the taller balloons are)",  width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 5,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 5, \n press 's' to go back to settings",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
        if (key == 'p') {
          bLength += 5; 
        }
        if (key == 'u') {
          bLength -= 5; 
        }
        if (key == 'o') {
          bLength += 1; 
        }
        if (key == 'i') {
          bLength -= 1; 
        } 
      }
    }
    if (bLength < 1) {
      bLength = 1;
    }
}

void gameSettings6() { // balloon color
    clearBackground();
    textSize(textSize);
    textAlign(CENTER); 
    text("Set RGB: Red = " + (red) + "| Green = " + green + "| Blue = " + blue + "\n Press 't' to set red value, 'g' to set green, 'b' set blue \n Press 'f' for random baloon colors \n \n \n \n Press 's' to go back to settings",  width/2, height/8 + textSize);
    if (key == 't') {
      gameState = "RED";
    }
    if (key == 'g') {
      gameState = "GREEN";
    }
    if (key == 'b') {
      gameState = "BLUE"; 
    }
    if (key == 'f') {
      gameState = "RANDOMCOLORS";
    }
    if (red != 0 || green != 0 || blue != 0) {
     overrideBColor = color(red, green, blue); 
    }
}    

void gameSettingsRed() { // balloon color helper 
    clearBackground();
    textSize(textSize);
    textAlign(CENTER); 
    text("Set Red RGB value: Red = " + (red), width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 10,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 10, \n press 'm' to go back to RGB values",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
    if (frameCount % 8 == 0) {
        if (key == 'p') {
          red += 10; 
        }
        if (key == 'u') {
          red -= 10; 
        }
        if (key == 'o') {
          red += 1; 
        }
        if (key == 'i') {
          red -= 1; 
        } 
      }
      if (key == 'm') {
        gameState = "SETTINGS6";
      }
   }
  
  if (red < 1) {
    red = 1;
  }
  if (red > 255) {
    red = 255; 
  }
}

void gameSettingsGreen() { // balloon color helper 
  clearBackground();
    textSize(textSize);
    textAlign(CENTER); 
    text("Set Green RGB value: Green = " + (green), width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 10,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 10, \n press 'm' to go back to RGB values",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
          if (key == 'p') {
            green += 10; 
          }
          if (key == 'u') {
            green -= 10; 
          }
          if (key == 'o') {
            green += 1; 
          }
          if (key == 'i') {
            green -= 1; 
          } 
        }
      if (key == 'm') {
        gameState = "SETTINGS6";
      }
   }
  
  if (green < 1) {
    green = 1;
  }
  if (green > 255) {
    green = 255; 
  }
}

void gameSettingsBlue() { // balloon color helper 
    clearBackground();
    textSize(textSize);
    textAlign(CENTER); 
    text("Set Blue RGB value: Blue = " + (blue), width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 10,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 10, \n press 'm' to go back to RGB values",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
          if (key == 'p') {
            blue += 10; 
          }
          if (key == 'u') {
            blue -= 10; 
          }
          if (key == 'o') {
            blue += 1; 
          }
          if (key == 'i') {
            blue -= 1; 
          } 
        }
      if (key == 'm') {
        gameState = "SETTINGS6";
      }
   }
  
  if (blue < 1) {
    blue = 1;
  }
  if (blue > 255) {
    blue = 255; 
  }
}

void gameSettingsRandomColor() { // balloon color helper 
    clearBackground();
    overrideBColor = 0;
    red = 0;
    green = 0;
    blue = 0;
    textSize(textSize);
    textAlign(CENTER); 
    text("Enjoy the random color fun! \n Press 's' to go back to settings", width/2, height/8 + textSize);
}


void gameSettings7() {
   clearBackground();
    textSize(textSize);
    textAlign(CENTER);
    text("Time given for Time Challenge: " + (bTimerOverride),  width/2, height/8 + textSize);
    textSize(textSize - 20);
    text("Press 'u' decrease by 5,  'i' decrease by 1, 'o' increase by 1, 'p' to increase by 5, \n press 's' to go back to settings",  width/2, height/8 + (5 * textSize));
    if (keyPressed) {
      if (frameCount % 8 == 0) {
        if (key == 'p') {
          bTimerOverride += 5; 
        }
        if (key == 'u') {
          bTimerOverride -= 5; 
        }
        if (key == 'o') {
          bTimerOverride += 1; 
        }
        if (key == 'i') {
          bTimerOverride -= 1; 
        } 
      }
    }
    if (bTimerOverride < 1) {
      bTimerOverride = 1;
    }
    if (bTimerOverride != 0) {
      bTimer = bTimerOverride; 
    }
}


void gameSettings8() { // reset to defaults 
   clearBackground();
  textSize(textSize);
  textAlign(CENTER); 
  text("All settings have been reset \n Press 's' to go back to Settings", width/2, height/8 + textSize);

   spawnRate = 1; 
   goesUpBy = 30;
   balloonLimit = 5;
   
   bTimer = 15;
   bTimerOverride = 0;

   bWidth = 50; 
   bLength = 60; 
   bcolor = 0;
   oldColor = 0;

   overrideBColor = 0;
   red = 0;
   blue = 0;
   green = 0;
}

void mouseClicked() {
     for (int index = 0; index < balloons.size(); index++) {
       if (mouseX > balloons.get(index).xpos - bWidth && mouseX < balloons.get(index).xpos + bWidth && mouseY > balloons.get(index).ypos - bLength && mouseY < balloons.get(index).ypos + bLength) {
         balloons.remove(index);  
         balloonsPopped++;
       }
     }
}
