class Mother extends Enemy
{
  int maxChildren = 7;
  ArrayList<Enemy> children = new ArrayList<Enemy>();

  Mother()
  {
    super();
  }

  Mother(float posX, float posY)
  {
    super(posX, posY); 
    filler = color(255, 133, 3);
    speed = 3;
    type = "Enemy";
    canShoot = true;
    maxCoolDown = 60;
    cooldown = maxCoolDown;
  }

  void update()
  {
    if (moveable)
      position.add(velocity);
    if (player.alive && children.size() < maxChildren)
    {
      cooldown--;
      if (cooldown < -maxCoolDown/2)
      {
        cooldown = maxCoolDown;
        Enemy E = new Enemy(position.x, position.y, this);
        E.cooldown = 0;
        enemies.add(E);
        children.add(E);
      }
    } else 
    {
      cooldown = maxCoolDown;
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
        velocity.x = lerp(velocity.x, -speed, 0.1);
      } else if (player.position.x < position.x)
      {
        velocity.x = lerp(velocity.x, speed, 0.1);
      } else 
      {
        velocity.x = lerp(velocity.x, 0, 0.1);
      }

      if (player.position.y > position.y)
      {
        velocity.y = lerp(velocity.y, -speed, 0.1);
      } else if (player.position.y < position.y)
      {
        velocity.y = lerp(velocity.y, speed, 0.1);
      } else 
      {
        velocity.y = lerp(velocity.y, 0, 0.1);
      }
    } else
    {
      //If player is not close enough, kinda random movement
      //TODO: Clean random movement
      inSight = false;
      velocity.x += random(-0.1, 0.1);
      velocity.y += random(-0.1, 0.1);
    }
    velocity.limit(speed);
  }
}
