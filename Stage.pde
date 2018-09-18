/*****************************
 Basic Stage class
 *****************************/

class Stage
{
  int level;
  boolean firstFrame = true;
  int Width, Height;
  Stage()
  {
    level = 0;
    Width = width;
    Height = height;
  }

  Stage(int stagenum)
  {
    level = stagenum;
  }

  void _setup()
  {
    loadWalls(level);
    firstFrame = false;
  }

  void _draw()
  {
    background(50);

    updateEntities(particles);
    updateEntities(enemies);
    updateEntities(player);
    updateEntities(bullets);
    handleCollision();
    cameraFollow(player);
    pushMatrix();
    translate(width/2 - cameraX, height/2 - cameraY);
    drawEntities(particles);
    drawEntities(enemies);
    drawEntities(player);
    drawEntities(walls);
    drawEntities(bullets);
    popMatrix();

    if (player.alive == false)
    {
      deathScreen();
    } else if (enemies.size() == 0)
    {
      winScreen();
    }
  }
}

void deathScreen()
{
  textSize(32);
  fill(255);
  text("You Died!\nPress the 'SPACE-BAR' to restart!", width/2, height/2);
  if (space)
  {
    stageReset();
  }
}

void winScreen()
{
  for (int i = bullets.size() - 1; i >= 0; i--)
  { 
    bullets.remove(i);
  }
  textSize(30);
  fill(255);
  text("You WON!\nPress the 'SPACE-BAR' to continue!", width/2, height/2);
  if (space)
  {
    stage.level++;
    stageReset();
  }
}

void loadWalls(int levels)
{
  switch(levels)
  {
  case 0:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/4, stage.Height/2);
    enemies.add(new Enemy(stage.Width*3/4, stage.Height/2));
    edges(stage.Width, stage.Height);
    walls.add(new Wall(stage.Width/2, stage.Height/2, 20, stage.Height*2/3, -1));
    break;
  case 1:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/4, stage.Height/2);
    enemies.add(new Enemy(stage.Width*3/4, stage.Height/4));
    enemies.add(new Enemy(stage.Width*3/4, stage.Height*3/4));
    edges(stage.Width, stage.Height);
    walls.add(new Wall(stage.Width/2, stage.Height/2, 20, stage.Height*2/3, -1));
    walls.add(new Wall(stage.Width*3/4, stage.Height/2, stage.Width/2, 20, -1));
    break;
  case 2:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/4, stage.Height/2);
    enemies.add(new Enemy(stage.Width*2/3, stage.Height/4));
    enemies.add(new Enemy(stage.Width*5/6, stage.Height/4));
    enemies.add(new Trio(stage.Width*2/3, stage.Height*3/4));
    edges(stage.Width, stage.Height);
    walls.add(new Wall(stage.Width/2, stage.Height/2, 20, stage.Height*2/3, -1));
    walls.add(new Wall(stage.Width*3/4, stage.Height/2, stage.Width/2, 20, 1));
    break;
  case 3:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/4, stage.Height/2);
    enemies.add(new Trio(stage.Width*2/3, stage.Height/4));
    enemies.add(new Enemy(stage.Width*5/6, stage.Height/4));
    enemies.add(new Trio(stage.Width*2/3, stage.Height*3/4));
    enemies.add(new Enemy(stage.Width*5/6, stage.Height*3/4));
    edges(stage.Width, stage.Height);
    walls.add(new Wall(stage.Width/2, stage.Height/2, 20, stage.Height*2/3, 1));
    walls.add(new Wall(stage.Width*3/4, stage.Height/2, stage.Width/2, 20, 1));
    walls.add(new Wall(stage.Width/8, stage.Height/2, 20, stage.Height/2, 2));
    break;
  case 4:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/2, stage.Height/2);
    enemies.add(new Enemy(stage.Width/8, stage.Height/4));
    enemies.add(new Enemy(stage.Width/8, stage.Height*3/4));
    enemies.add(new Enemy(stage.Width*7/8, stage.Height/4));
    enemies.add(new Enemy(stage.Width*7/8, stage.Height*3/4));
    edges(stage.Width, stage.Height);
    walls.add(new Wall(stage.Width/4, stage.Height/2, 20, stage.Height*3/4, 1));
    walls.add(new Wall(stage.Width*3/4, stage.Height/2, 20, stage.Height*3/4, 1));
    walls.add(new Wall(stage.Width/8, stage.Height/2, stage.Width/4, 20, 1));
    walls.add(new Wall(stage.Width*7/8, stage.Height/2, stage.Width/4, 20, 1));
    break;
  case 5:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/2, stage.Height/2);
    enemies.add(new Enemy(stage.Width/8, stage.Height/4));
    enemies.add(new Trio(stage.Width/8, stage.Height*3/4));
    enemies.add(new Enemy(stage.Width*7/8, stage.Height/4));
    enemies.add(new Enemy(stage.Width*7/8, stage.Height*3/4));
    enemies.add(new Enemy(stage.Width/2, stage.Height*7/8));
    edges(stage.Width, stage.Height);
    walls.add(new Wall(stage.Width/4, stage.Height/2, 20, stage.Height*3/4, 1));
    walls.add(new Wall(stage.Width*3/4, stage.Height/2, 20, stage.Height*3/4, 1));
    walls.add(new Wall(stage.Width/8, stage.Height/2, stage.Width/4, 20, 2));
    walls.add(new Wall(stage.Width*7/8, stage.Height/2, stage.Width/4, 20, 1));
    walls.add(new Wall(stage.Width/2, stage.Height/4, stage.Width/4, 50, 2));
    walls.add(new Wall(stage.Width/2, stage.Height*3/4, stage.Width/4, 50, 1));
    break;
  case 6:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/8, stage.Height/2);
    enemies.add(new Mother(stage.Width/2, stage.Height/2));
    enemies.add(new Trio(stage.Width*3/4, stage.Height/2));
    enemies.add(new Enemy(stage.Width*3/4, stage.Height/10));
    enemies.add(new Enemy(stage.Width*3/4, stage.Height*9/10));
    edges(stage.Width, stage.Height);
    walls.add( new Wall(stage.Width/4, stage.Height/2, 20, stage.Height/2 + 20, 1));
    walls.add( new Wall(stage.Width/2, stage.Height/4, stage.Width/2 + 20, 20, 1));
    walls.add( new Wall(stage.Width/2, stage.Height*3/4, stage.Width/2 + 20, 20, 1));
    break;
  case 7:
    stage.Width = 1000;
    stage.Height = 800;
    player = new Player(stage.Width/8, stage.Height/2);
    enemies.add(new Trio(stage.Width/2, stage.Height/2));
    enemies.add(new SlowEnemy(stage.Width*3/4, stage.Height/2));
    enemies.add(new SlowEnemy(stage.Width*3/4, stage.Height/10));
    enemies.add(new SlowEnemy(stage.Width*3/4, stage.Height*9/10));
    edges(stage.Width, stage.Height);
    walls.add( new Wall(stage.Width/4, stage.Height/2, 20, stage.Height/2 + 20, 1));
    walls.add( new Wall(stage.Width/2, stage.Height/4, stage.Width/2 + 20, 20, 1));
    walls.add( new Wall(stage.Width/2, stage.Height*3/4, stage.Width/2 + 20, 20, 1));
    break;
  case 8:
    stage.Width = 1300;
    stage.Height = 1300;
    player = new Player(stage.Width/8, stage.Height/8);
    enemies.add(new Sprinkler(stage.Width/2, stage.Height/2));
    enemies.add(new Mother(stage.Width/2, stage.Height/4));
    edges(stage.Width, stage.Height);
    walls.add( new Wall(stage.Width/8, stage.Height/2, 20, stage.Height/3 + 20, 2));
    walls.add( new Wall(stage.Width/2, stage.Height/8, stage.Width/3 + 20, 20, 2));
    walls.add( new Wall(stage.Width/2, stage.Height*7/8, stage.Width/3 + 20, 20, 2));
    walls.add( new Wall(stage.Width*7/8, stage.Height/2, 20, stage.Height/3 + 20, 2));
    break;
  case 9:
    stage.Width = 1300;
    stage.Height = 1300;
    player = new Player(stage.Width/8, stage.Height/2);
    enemies.add(new SplitEnemy(stage.Width*3/8, stage.Height/2));
    enemies.add(new SplitEnemy(stage.Width*5/8, stage.Height/2));
    enemies.add(new Sprinkler(stage.Width/2, stage.Height/2));
    edges(stage.Width, stage.Height);
    walls.add( new Wall(stage.Width/4, stage.Height/2, 20, stage.Height/2 + 20, -1));
    walls.add( new Wall(stage.Width/2, stage.Height/4, stage.Width/2 + 20, 20, -1));
    walls.add( new Wall(stage.Width/2, stage.Height*3/4, stage.Width/2 + 20, 20, -1));

    walls.add( new Wall(stage.Width*3/4, stage.Height/2, 20, stage.Height/4 + 20, 1));
    walls.add( new Wall(stage.Width/2, stage.Height*3/8, stage.Width/4 + 20, 20, 1));
    walls.add( new Wall(stage.Width/2, stage.Height*5/8, stage.Width/4 + 20, 20, 1));
    break;
  default:
    stage.level = 0;
    loadWalls(0);
    break;
  }
}

void stageReset()
{
  for (int i = walls.size() - 1; i >= 0; i--)
  { 
    walls.remove(i);
  }
  for (int i = enemies.size() - 1; i >= 0; i--)
  { 
    enemies.remove(i);
  }
  for (int i = bullets.size() - 1; i >= 0; i--)
  { 
    bullets.remove(i);
  }
  for (int i = particles.size() - 1; i >= 0; i--)
  { 
    particles.remove(i);
  }
  player = null;
  stage.firstFrame = true;
}

void edges(int W, int H)
{
  walls.add(new Wall(W/2, 0, W + 20, 20, -1));
  walls.add(new Wall(W/2, H, W + 20, 20, -1));
  walls.add(new Wall(0, H/2, 20, H + 20, -1));
  walls.add(new Wall(W, H/2, 20, H + 20, -1));
}
