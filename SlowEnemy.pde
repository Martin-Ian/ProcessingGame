class SlowEnemy extends Enemy
{
  SlowEnemy()
  {
    super();
  }

  SlowEnemy(float posX, float posY)
  {
    super(posX, posY); 
    filler = color(#AB4DF0);
    type = "Enemy";
    canShoot = true;
    maxCoolDown = 40;
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
        slowShoot(atan2(player.position.y - position.y, player.position.x - position.x) + 0.5);
        slowShoot(atan2(player.position.y - position.y, player.position.x - position.x) - 0.5);
        cooldown = maxCoolDown/2;
      }
    }
  }
}
