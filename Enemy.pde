/************************************
 Enemy.pde
 
 This class is the basic enemy class
 ************************************/

class Enemy extends Entity //Child of Entity
{
  float speed = 4; //Max speed of entity
  float sight = 1250;  //What is the enimies "range"
  boolean inSight = false;  //Toggles on if the player is near
  int cooldown = 60, maxCoolDown = 60;  //For shooting
  boolean canShoot = true;

  //Constructors
  Enemy()
  {
    super(); 
    filler = color(255, 0, 0);
    type = "Enemy";
  }

  Enemy(float posX, float posY)
  {
    super(posX, posY); 
    filler = color(255, 0, 0);
    type = "Enemy";
  }

  Enemy(float posX, float posY, Mother p)
  {
    super(posX, posY); 
    filler = color(255, 0, 0);
    type = "Enemy";
    parent = p;
  }

  //This is the update function for Enemy
  void update()
  {
    if (moveable)
      position.add(velocity);
    cooldown--;
    if (inSight)
    {
      if (cooldown < -maxCoolDown/2)
      {
        shoot(atan2(player.position.y - position.y, player.position.x - position.x));
        cooldown = maxCoolDown/2;
      }
    }
  }

  //This says how the Enemy moves
  void move()
  {
    //see if the player is close
    if (player != null && player.alive && canShoot && dist(player.position.x, player.position.y, position.x, position.y) <= sight/2)
    {
      inSight = true;

      //Apply a velocity towards the player
      if (player.position.x > position.x)
      {
        velocity.x = lerp(velocity.x, speed, 0.01);
      } else if (player.position.x < position.x)
      {
        velocity.x = lerp(velocity.x, -speed, 0.01);
      } else 
      {
        velocity.x = lerp(velocity.x, 0, 0.1);
      }

      if (player.position.y > position.y)
      {
        velocity.y = lerp(velocity.y, speed, 0.01);
      } else if (player.position.y < position.y)
      {
        velocity.y = lerp(velocity.y, -speed, 0.01);
      } else 
      {
        velocity.y = lerp(velocity.y, 0, 0.1);
      }
    } else
    {
      //If player is not close enough, kinda random movement
      //TODO: Clean random movement
      if (canShoot)
        cooldown = maxCoolDown;
      inSight = false;
      velocity.x += random(-0.1, 0.1);
      velocity.y += random(-0.1, 0.1);
    }
    velocity.limit(speed);
  }

  void show()
  {
    //How the enemy looks
    fill(filler);
    rect(position.x, position.y, dimentions.x, dimentions.y);
    if (cooldown < 0)
    {
      fill(100, 0, 0);
      rect(position.x, position.y, map(cooldown, 0, -maxCoolDown/2, 0, dimentions.x), map(cooldown, 0, -maxCoolDown/2, 0, dimentions.y));
    }
  }

  //Basic shoot function, shoots one bullet at player
  void shoot(float ang)
  {
    pushMatrix();
    translate(position.x, position.y);
    bullets.add(new Bullet(position.x, position.y, ang));
    popMatrix();
  }

  void slowShoot(float ang)
  {
    pushMatrix();
    translate(position.x, position.y);
    bullets.add(new SlowBullet(position.x, position.y, ang));
    popMatrix();
  }
  
  void splitShoot(float ang)
  {
    pushMatrix();
    translate(position.x, position.y);
    bullets.add(new SplitterBullet(position.x, position.y, ang));
    popMatrix();
  }
}
