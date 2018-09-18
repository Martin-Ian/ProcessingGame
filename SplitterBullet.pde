class SplitterBullet extends Bullet
{
  SplitterBullet()
  {
    super();
  }

  SplitterBullet(float posX, float posY, float ang)
  {
    super(posX, posY, ang);
    velocity.setMag(6);
    filler = color(#7C7474);
  }

  void onRemoval()
  {
    for (int i = -2; i < 3; i++)
    {
      Bullet B = new SlowBullet(position.x, position.y, atan2(player.position.y - position.y, player.position.x - position.x) + radians(20 * i));
      B.update();
      B.update();
      bullets.add(B);
    }
  }
}
