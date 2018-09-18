class Trio extends Enemy
{
  Trio()
  {
    super();
  }

  Trio(float posX, float posY)
  {
    super(posX, posY); 
    filler = color(#007DFF);
    type = "Enemy";
    canShoot = true;
    maxCoolDown = 90;
    cooldown = maxCoolDown;
  }

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
        shoot(atan2(player.position.y - position.y, player.position.x - position.x) + 0.5);
        shoot(atan2(player.position.y - position.y, player.position.x - position.x) - 0.5);
        cooldown = maxCoolDown/2;
      }
    }
  }
}