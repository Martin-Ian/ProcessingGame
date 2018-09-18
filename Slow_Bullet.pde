class SlowBullet extends Bullet
{
  SlowBullet()
  {
    super();
  }

  SlowBullet(float posX, float posY, float ang)
  {
    super(posX, posY, ang);
    velocity.setMag(1);
    filler = color(#4DA8F0);
  }
}
