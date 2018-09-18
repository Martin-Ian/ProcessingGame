/*************************
 Entity.pde
 
 This class is the base class for 
 all 'interactable' Objects
 *************************/

class Entity
{
  PVector position;
  String type;
  PVector velocity;
  PVector dimentions;
  color filler; //Optional to replace with a image
  boolean moveable; //An immovable Entity won't be able to have a velocity added to it
  float ID = random(1); //This is used in collision
  int special = -1;
  Mother parent = null;

  //Base default constructor
  Entity()
  {
    position = new PVector(width/2, height/2);
    type = "NONE";
    velocity = new PVector(random(-3, 3), random(-3, 3));
    filler = color(random(255), random(255), random(255));
    dimentions = new PVector(50, 50);
    moveable = true;
  }

  //Constructor with position
  Entity(float posX, float posY)
  {
    position = new PVector(posX, posY);
    type = "NONE";
    velocity = new PVector(0, 0);
    filler = color(random(255), random(255), random(255));
    dimentions = new PVector(50, 50);
    moveable = true;
  }

  //Constructor with position and dimentions
  Entity(float posX, float posY, float dimX, float dimY)
  {
    position = new PVector(posX, posY);
    type = "NONE";
    velocity = new PVector(random(-3, 3), random(-3, 3));
    filler = color(random(255), random(255), random(255));
    dimentions = new PVector(dimX, dimY);
    moveable = true;
  }

  //Constructor with position, dimentions, and velocity
  Entity(float posX, float posY, float dimX, float dimY, float velX, float velY)
  {
    position = new PVector(posX, posY);
    type = "NONE";
    velocity = new PVector(velX, velY);
    filler = color(random(255), random(255), random(255));
    dimentions = new PVector(dimX, dimY);
    moveable = true;
  }

  //Basic collision function, returns if given Entity is colliding with current Entity
  int collides(Entity E)
  {
    if (this.ID != E.ID)
    {
      float A_top = this.position.y - this.dimentions.y/2;
      float A_right = this.position.x + this.dimentions.x/2;
      float A_bot = this.position.y + this.dimentions.y/2;
      float A_left = this.position.x - this.dimentions.x/2;
      
      float B_top = E.position.y - E.dimentions.y/2;
      float B_right = E.position.x + E.dimentions.x/2;
      float B_bot = E.position.y + E.dimentions.y/2;
      float B_left = E.position.x - E.dimentions.x/2;
      
      if(A_bot > B_top && A_left < B_right && A_right > B_left && this.position.y < B_top)
      {
        return 1;
      }
      if(A_left < B_right && A_top < B_bot && A_bot > B_top && this.position.x > B_right)
      {
        return 2;
      }
      if(A_top < B_bot && A_left < B_right && A_right > B_left && this.position.y > B_bot)
      {
        return 3;
      }
      if(A_right > B_left && A_top < B_bot && A_bot > B_top && this.position.x < B_left)
      {
        return 4;
      }
      
    }
    return -1;
  }

  //Base update function
  void update()
  {
    if (moveable)
      position.add(velocity);
  }

  //base display function
  void show()
  {
    fill(filler);
    rect(position.x, position.y, dimentions.x, dimentions.y);
  }
  
  void onRemoval()
  {
   //Blank 
  }

  void move()
  {
    //Intentionally blank
  }
}
