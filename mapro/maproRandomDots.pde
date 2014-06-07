int DispW = 1280;
int DispH = 720;
void setup() 
{
  frameRate(30);
  size(DispW, DispH); 
  //noStroke();
  noCursor();
  rectMode(CENTER);
}

void draw() 
{   
  background(128); 
  float rate = frameRate;

  int wnW  = 50;  int wnH  = 50;
  int wnN = 50;  int wnB = 5;
  float nx, ny = 0;
//  float ny = 0;

  for (int i = 0; i < wnN; i=i+1) {
      nx = random(wnW);
      ny = random(wnH);

    if ((i%2)==0) {
      fill(255, 255);
      stroke(255, 255);
    } else {
      fill(0, 255);
      stroke(0, 255);
    }
    rect(mouseX + (nx), mouseY +(ny), wnB, wnB);
  }

  // disp Values  
  text("  X: "+str(mouseX-DispW/2), 10, 10);
  text("  Y: "+str(mouseY-DispH/2), 10, 20);
  text("FPS: "+str(rate), 10, 30);
  text(str(ny), 10, 40);
}
