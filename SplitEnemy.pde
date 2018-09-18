class SplitEnemy extends Enemy
{
  SplitEnemy()
  {
    super();
  }

  SplitEnemy(float posX, float posY)
  {
    super(posX, posY); 
    filler = color(255);
    type = "Enemy";
    canShoot = true;
    maxCoolDown = 50;
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
        splitShoot(atan2(player.position.y - position.y, player.position.x - position.x));
        splitShoot(atan2(player.position.y - position.y, player.position.x - position.x) + radians(180));
        cooldown = maxCoolDown/2;
      }
    }
  }
}
