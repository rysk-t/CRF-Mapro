float biasH = 1;  float biasW = 1;
int dispW = 1280;  int dispH = 900;
int orbias = 0;
int wnN = 10; int wnB = 5;
int bLen = 50;  int bWid = 10;
int wnW  = 10;  int wnH  = 10;
boolean defCont = true;
char modeNo = '1';
char curMode = '1';

void setup() 
{
  frameRate(30);
  size(dispW, dispH); 
  noCursor();
  rectMode(CENTER);

}

void draw() 
{   
  background(128); 
  float rate = frameRate;


 
  boolean evt = false;

  // disp Values  
  text("   X: "+str(mouseX-dispW/2), 10, 10);
  text("   Y: "+str(mouseY-dispH/2), 10, 20);
  text(" FPS: "+str(rate), 10, 30);
  text("Mode: "+modeNo, 10, 40);


  modeNo = getModeNo();

  if (mousePressed) {
    if (modeNo!='N') {
      curMode = modeNo;
    }
    modeNo = 'N';
  }else{
    modeNo = curMode;
  }

  switch (modeNo) {
    case '1':
      randomDot(int(wnW*biasW), int(wnH*biasH), wnN, wnB, false);
      break;
    case '2':
      randomBar(int(wnW*biasW), int(wnH*biasH), wnN/2, 10*wnB, 1*wnB, 45+orbias*10);
      break;  
    case '3':
      randomDot(int(wnW*biasW), int(wnH*biasH), wnN, wnB, true);
      break;
    case '4':
      simpleBar(int(bLen*biasH), int(bWid*biasW), 45+orbias*10, defCont);
      break;
    case 'N':
      break;
    default :
      break;  
  }

  switch (getConfKey()) {
    case 'o' :
      orbias += 1;
      break;  
    case 'b' :
      biasW += 0.1;
      biasH += 0.1;
      if (int(wnW*biasW) > 4000 || int(wnW*biasW) > 4000 ){
        biasW = 1;
        biasH = 1;
        println("loop!");
      }
      println("biasW: "+biasW);
      break;
    case 's' :
      biasW -=0.1;
      biasH -=0.1;
      break;
    case 'n' :
      wnN = wnN + 10;
      if (wnN > 500) {
        wnN = 10;
      }
      println("wnN: "+wnN);
      break;
    case 'd':
      wnB = int(wnB*1.5);
      if (wnB > wnW*biasW) {
        wnB = 2; 
      }
      break;
    case 'r' :
      biasW=1; biasH = 1;
      orbias = 0;
      wnN = 10;
      wnB = 5;
      break;

  }

}

void randomDot(int wnW, int wnH, int wnN, int wnB, boolean isCircle){
  float nx, ny = 0;

  for (int i = 0; i < wnN; i=i+1) {
    nx = random(-wnW, wnW);
    ny = random(-wnH, wnH);

    if (!isCircle | sqrt(nx * nx + ny * ny) < wnW ) {
      rect(mouseX+nx, mouseY+ny, wnB, wnB);

      if ((i%2)==0) {
        fill(255, 255);
        stroke(255, 255);
      } else {
        fill(0, 255);
        stroke(0, 255);
      }
    }
  }

}

void randomBar(int wnW, int wnH, int wnN, int bLen, int bWid, int orientation){
  float nx, ny = 0;
  float orad = orientation * PI/180;
  for (int i = 0; i < wnN; i=i+1) {
    nx = random(-wnW, wnW);
    ny = random(-wnH, wnH);

    if ((i%2)==0) {
      fill(255, 255);
      stroke(255, 255);
    } else {
      fill(0, 255);
      stroke(0, 255);
    }

    float rx = mouseX + nx - 0.5*cos(orad)*bLen;
    float ry = mouseY + ny - 0.5*sin(orad)*bLen;

    quad(rx, ry, 
      rx+cos(orad)*bLen, ry+sin(orad)*bLen, 
      rx+sin(orad)*bWid+cos(orad)*bLen, ry-cos(orad)*bWid+sin(orad)*bLen, 
      rx+sin(orad)*bWid, ry-cos(orad)*bWid);
  }
}


void simpleBar(int bLen, int bWid, int orientation, boolean cont) {
  float orad = orientation * PI/180;
  println("orientation: "+orientation);
  println("orad: "+orad);
  float rx = mouseX-0.5*(sin(orad)*bWid+cos(orad)*bLen); 
  float ry = mouseY-0.5*(-1*sin(orad)*bLen+cos(orad)*bWid);

  if (cont) {
    fill(255, 255);
    stroke(255, 255);
  } else {
    fill(0, 255);
    stroke(0, 255);
  }

  quad(rx, ry, 
      rx+cos(orad)*bLen, ry-sin(orad)*bLen, 
      rx+sin(orad)*bWid+cos(orad)*bLen, ry-sin(orad)*bLen+cos(orad)*bWid,
      rx+sin(orad)*bWid, ry+cos(orad)*bWid);
}


char getModeNo(){
  if (keyPressed) {
    if (key == '1'){
      modeNo = '1';
    }
    if (key == '2'){
      modeNo = '2';
    }
    if (key == '3'){
      modeNo = '3';
    }
    if (key == '4'){
      modeNo = '4';
    }
  }
  return modeNo;
}

char getConfKey(){
  char confKey = '^';
  if (keyPressed) {
    confKey = char(key);
  }
  return confKey;
}

void mousePressed() {
  defCont = !defCont;
}

void keyPressed(){
/*  if (key=='w') {
    biasW = int(biasW+1);
  }else if (key=='h') {
    biasH = int(biasH+1);
   }
   println("Press!: "+ key);
*/

  switch (key) {
    case 'w': 
      biasW = int(biasW+1);
      break;
    case 'h' :
      biasH = int(biasH+1);
      break;
    default :
      break;  
  }
}
