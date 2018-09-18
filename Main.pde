/********************************
 Ian Martin 2018
 BulletHell Remake
 
 Main.pde
 ********************************/

//Wall arrayList
ArrayList<Entity> walls = new ArrayList<Entity>();
//Player Entity
Player player;
//Enemy arrayList
ArrayList<Entity> enemies = new ArrayList<Entity>();
//Bullet arraylist
ArrayList<Entity> bullets = new ArrayList<Entity>();
//Particles
ArrayList<Entity> particles = new ArrayList<Entity>();
//Camera controls
float cameraX, cameraY;
//Player Controls
boolean isUp, isDown, isRight, isLeft, space;
Stage stage;

void setup()
{
  fullScreen();

  //Initial camera position
  cameraX = width/4;
  cameraY = height/2;
  textAlign(CENTER);

  //Declare stage
  stage = new Stage();
}

void draw()
{
  if (stage.firstFrame)
    stage._setup();
  stage._draw();
}

void drawEntities(ArrayList<Entity> arr)
{
  rectMode(CENTER);
  noStroke();
  for (int i = arr.size() - 1; i >= 0; i--)
  {
    Entity E = arr.get(i);
    E.show();
  }
}

void updateEntities(ArrayList<Entity> arr)
{
  for (int i = arr.size() - 1; i >= 0; i--)
  {
    Entity E = arr.get(i);
    E.move();
    E.update();
  }
}

//Same as above, but for single entities

void drawEntities(Entity E)
{
  rectMode(CENTER);
  noStroke();
  E.show();
}

void updateEntities(Entity E)
{
  E.move();
  E.update();
}

//Function for the camera to follow a specific Entity

void cameraFollow(Entity E)
{
  if (player.alive)
  {
    cameraX = lerp(cameraX, E.position.x, 0.05);
    cameraY = lerp(cameraY, E.position.y, 0.05);
  } else 
  {
    cameraX = lerp(cameraX, stage.Width/2, 0.005);
    cameraY = lerp(cameraY, stage.Height/2, 0.005);
  }
}

void handleCollision()
{
  //  1
  // 3 4
  //  2

  for (Entity E : walls) //For each Wall
  {
    if (player.alive && player.collides(E) != -1)
    {
      switch(player.collides(E))
      {
      case 1:
        player.velocity.y = 0;
        player.position.y -= 2;
        break;
      case 2:
        player.velocity.x = 0;
        player.position.x += 2;
        break;
      case 3:
        player.velocity.y = 0;
        player.position.y += 2;
        break;
      case 4:
        player.velocity.x = 0;
        player.position.x -= 2;
        break;
      }
    }
    for (Entity EN : enemies) //For each Enemy
    {
      if (EN.collides(E) != -1)
      {
        switch(EN.collides(E))
        {
        case 1:
          EN.velocity.y *= -1;
          EN.position.y -= 1;
          break;
        case 2:
          EN.velocity.x *= -1;
          EN.position.x += 1;
          break;
        case 3:
          EN.velocity.y *= -1;
          EN.position.y += 1;
          break;
        case 4:
          EN.velocity.x *= -1;
          EN.position.x -= 1;
          break;
        }
      }
    }
    for (int i = bullets.size() - 1; i >= 0; i--)
    {
      if (E.special == -1 && bullets.get(i).collides(E) != -1)
      {
        bullets.get(i).onRemoval();
        bullets.remove(i);
        continue;
      } else if (E.special == 2 && bullets.get(i).collides(E) != -1)
      {
        switch(bullets.get(i).collides(E))
        {
        case 1:
          bullets.get(i).velocity.y *= -1;
          bullets.get(i).position.y -= 2;
          break;
        case 2:
          bullets.get(i).velocity.x *= -1;
          bullets.get(i).position.x += 2;
          break;
        case 3:
          bullets.get(i).velocity.y *= -1;
          bullets.get(i).position.y += 2;
          break;
        case 4:
          bullets.get(i).velocity.x *= -1;
          bullets.get(i).position.x -= 2;
          break;
        }
      }  
      if (player.alive && bullets.get(i).collides(player) != -1)
      {
        bullets.remove(i);
        player.lives--;
      }
    }
  }


  for (Entity EN : enemies)
  {
    for (Entity ENE : enemies)
    {
      if (EN.collides(ENE) != -1)
      {
        switch(EN.collides(ENE))
        {
        case 1:
          EN.velocity.y *= -1;
          EN.position.y -= 1;
          ENE.velocity.y *= -1;
          ENE.position.y += 1;
          break;
        case 2:
          EN.velocity.x *= -1;
          EN.position.x += 1;
          ENE.velocity.x *= -1;
          ENE.position.x -= 1;
          break;
        case 3:
          EN.velocity.y *= -1;
          EN.position.y += 1;
          ENE.velocity.y *= -1;
          ENE.position.y -= 1;
          break;
        case 4:
          EN.velocity.x *= -1;
          EN.position.x -= 1;
          ENE.velocity.x *= -1;
          ENE.position.x += 1;
          break;
        }
      }
    }
  }

  if (player.lives <= 0)
  {
    player.alive = false;
    player.lives = 1;
    player.velocity.setMag(1);
    for (int i = 0; i < 25; i++)
    {
      Entity P = new Entity(player.position.x, player.position.y);
      P.dimentions.x = 5;
      P.dimentions.y = 5;
      P.filler = player.filler;
      P.velocity.x = random(-2, 2);
      P.velocity.y = random(-2, 2);
      P.velocity.add(player.velocity);
      particles.add(P);
    }
  }

  if (player.alive) {
    for (int i = enemies.size()-1; i >= 0; i--)
    {
      if (player.collides(enemies.get(i)) != -1)
      {
        if (enemies.get(i).parent != null)
          enemies.get(i).parent.children.remove(enemies.get(i));
        enemies.remove(i);
      }
    }
  }
}

//Keyboard input

void keyPressed() 
{
  setMove(keyCode, true);
}

void keyReleased() 
{
  setMove(keyCode, false);
}

boolean setMove(int k, boolean b) 
{
  switch (k) {
  case UP:
  case 'W':
    return isUp = b;

  case LEFT:
  case 'A':
    return isLeft = b;

  case RIGHT:
  case 'D':
    return isRight = b;

  case DOWN:
  case 'S':
    return isDown = b;

  case ' ':
    return space = b;

  default:
    return b;
  }
}

//Helper function...

float floatLimit(float A, float B)
{
  if (A > B)
    return A;
  else
    return B;
}
