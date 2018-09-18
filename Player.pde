/*******************************
 Player.pde
 
 This class is the player class
 *******************************/

class Player extends Entity //This is based off of the Entity class
{
  float baseSpeed = 7, speed = 7;
  int lives = 1;
  boolean alive = true;

  //Default constructor
  Player()
  {
    super();
    filler = color(0, 255, 0);
    velocity.setMag(0);
    type = "Player";
  }

  //Constructor with position
  Player(float posX, float posY)
  {
    super(posX, posY);
    filler = color(0, 255, 0);
    velocity.setMag(0);
    type = "Player";
  }

  //This function governs the movement of the player
  void move()
  {
    if (isRight)
    {
      velocity.x = lerp(velocity.x, speed, 0.1);
    } else if (isLeft)
    {
      velocity.x = lerp(velocity.x, -speed, 0.1);
    } else 
    {
      velocity.x = lerp(velocity.x, 0, 0.1);
    }

    if (isDown)
    {
      velocity.y = lerp(velocity.y, speed, 0.1);
    } else if (isUp)
    {
      velocity.y = lerp(velocity.y, -speed, 0.1);
    } else 
    {
      velocity.y = lerp(velocity.y, 0, 0.1);
    }
    velocity.limit(speed);
    speed -= 0.01;
    if (speed < baseSpeed) speed = baseSpeed;
  }

  //Player update function
  void update()
  {
    if (moveable && alive)
      position.add(velocity);
  }

  //Player show function
  void show()
  {
    if (alive)
    {
      fill(filler);
      rect(position.x, position.y, dimentions.x, dimentions.y);
    }
  }
}