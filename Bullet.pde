/*********************************
 Bullet.pde
 This is the bullet class, when the 
 player gets hit by 3 bullets, they die
 *********************************/

class Bullet extends Entity
{

  Bullet()
  {
    super();
  }

  Bullet(float posX, float posY, float ang)
  {
    super(posX, posY);
    type = "Bullet";
    velocity = PVector.fromAngle(ang);
    velocity.setMag(6);
    filler = color(0, 0, 255);
    dimentions = new PVector(15, 15);
  }

  void show()
  {
    fill(0);
    rect(position.x, position.y, dimentions.x + 5, dimentions.y + 5);
    fill(filler);
    rect(position.x, position.y, dimentions.x, dimentions.y);
  }
}
