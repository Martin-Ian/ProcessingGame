class Sprinkler extends Enemy
{
  Sprinkler()
  {
    super();
  }

  Sprinkler(float posX, float posY)
  {
    super(posX, posY); 
    speed = 1.5;
    sight = sight*5;
    filler = color(100, 100, 100);
    type = "Enemy";
    canShoot = true;
    maxCoolDown = 360;
    cooldown = 180;
  }

  void update()
  {
    if (moveable)
      position.add(velocity);
    cooldown++;
    //cooldown = cooldown % maxCoolDown;
    if (inSight && cooldown % 60 == 18)
    {
      shoot(radians(cooldown+30));
      shoot(radians(cooldown+60));
      shoot(radians(cooldown+90));
      shoot(radians(cooldown-30));
      shoot(radians(cooldown-60));
      shoot(radians(cooldown-90));
      shoot(radians(cooldown));
    }
  }

  void show()
  {
    //How the enemy looks
    fill(filler);
    rect(position.x, position.y, dimentions.x, dimentions.y);
    if (inSight)
    {
      fill(100, 0, 0);
      rect(position.x, position.y, map((cooldown-18)%60, 0, 59, 0, dimentions.x), map((cooldown-18)%60, 0, 59, 0, dimentions.y));
    }
    fill(255, 0, 0);
    rect(position.x + cos(radians(cooldown))*35, position.y + sin(radians(cooldown))*35, 5, 5);
  }
}
