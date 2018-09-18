/*************************************
 Wall.pde
 
 This class is the wall class. Walls (as of now)
 cannot be moved through by anything. Will add
 special walls that Enemies can shoot through
 *************************************/

class Wall extends Entity //This class is a child of Entity
{
  //Default constructor
  Wall()
  {
    super();
    moveable = false;
    filler = color(0);
    type = "Wall";
  }

  //Constructor with position; wall will be a 50x50 square
  Wall(float posX, float posY)
  {
    super(posX, posY);
    moveable = false;
    filler = color(0);
    type = "Wall";
  }

  //Constructor with position and dimentions
  Wall(float posX, float posY, float dimX, float dimY, int B)
  {
    super(posX, posY, dimX, dimY);
    moveable = false;
    filler = color(0);
    type = "Wall";
    special = B;
  }

  void show()
  {
    if (special == 1)
    {
      pushMatrix();
      fill(200, 0, 200);
      rect(position.x, position.y, dimentions.x, dimentions.y);
      popMatrix();
    } else if (special == 2)
    {
      pushMatrix();
      fill(0, 200, 200);
      rect(position.x, position.y, dimentions.x, dimentions.y);
      popMatrix();
    } else
    {
      fill(filler);
      rect(position.x, position.y, dimentions.x, dimentions.y);
    }
  }
}