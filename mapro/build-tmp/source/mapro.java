import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class mapro extends PApplet {

int dispW = 1920;
int dispH = 1200;
float bias = 1;
char modeNo = '1';
char curMode = '1';

public void setup() 
{
  frameRate(30);
  size(dispW, dispH); 
  //noStroke();
//  noCursor();
  rectMode(CENTER);

}

public void draw() 
{   
  background(128); 
  float rate = frameRate;

  int wnW  = 50;  int wnH  = 50;
  int wnN = 128;  int wnB = 5;
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
      randomDot(PApplet.parseInt(wnW*bias), PApplet.parseInt(wnH*bias), wnN, wnB);
      break;
    case '2':
      randomBar(PApplet.parseInt(wnW*bias), PApplet.parseInt(wnH*bias), wnN/2, 100, 10, 60);
      break;  
    case '3':
      randomDotCirc(100, wnN, wnB);
    case 'l':
      line(mouseX+10,mouseY+10, mouseX, mouseY);
      break;
    case 'N':
      break;
    default :
      break;  
  }

//  bias = changeSize(bias);
  println(noise(1));
}

public void randomDot(int wnW, int wnH, int wnN, int wnB){
  float nx, ny = 0;

  for (int i = 0; i < wnN; i=i+1) {

    nx = random(-wnW, wnW);
    ny = random(-wnH, wnH);
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

public void randomDotCirc(int wnR, int wnN, int wnB){
  float nx, ny = 0;

  for (int i = 0; i < wnN; i=i+1) {
    float angle = random(0, 2*PI);
    float r = random(0, wnR);
    nx = r*cos(angle);
    ny = r*sin(angle);
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

public void randomBar(int wnW, int wnH, int wnN, int bLen, int bWid, int orientation){
  float nx, ny = 0;
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
    //rotate(orientation*PI/180, mouseX, mouseY, 0);
    //rect(mouseX + (nx), mouseY +(ny), bLen, bWid);
    float rx = mouseX + nx - wnW;
    float ry = mouseY + ny - wnH;
    float orad = orientation * PI/180;
    quad(rx, ry, 
      rx+cos(orad)*bLen, ry+sin(orad)*bLen, 
      rx+sin(orad)*bWid+cos(orad)*bLen, ry-cos(orad)*bWid+sin(orad)*bLen, 
      rx+sin(orad)*bWid, ry-cos(orad)*bWid);
    text(str(rx+cos(orad)*bLen), 100,100);
  }


}



public char getModeNo(){
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
  }
  return modeNo;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "mapro" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
