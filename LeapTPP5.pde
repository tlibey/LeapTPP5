//todo
/*
Implement tarProbability
Implement titrations
Implement percentageTargetmode?   instead of iTarx = 0/1000 => iTarX = 0%/100% such that TarX = iTarX*width;
Implement time of flight/trial length
Implement attempted trial rewards (motivation to keep trying after x seconds
*/



import com.onformative.leap.*;
import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Finger;
//import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.Tool;
import com.leapmotion.leap.Vector;
import java.awt.Frame;

LeapMotionP5 leapMotion;
IntList fingerIds;
int fingNum;
PVector pos;
float[][] tipPos;
float tarTimer = 0;
int allTimer = 0;
boolean tarHolding = false;
int trialsCompleted = 0;
PFont font1;
color bgColor = 255;
color textColor = 0;



boolean[] keysPressed = new boolean[526];
cTargets targets = new cTargets();




secondApplet s1;
PFrame Frame1;

void setup()
{
 size(1000,1000);
 leapMotion = new LeapMotionP5(this);
 fingerIds = new IntList();
 fingNum = 0;
 pos = new PVector();
 tipPos = new float[10][2];
 //initializeTarPos();
 font1 = createFont("Arial",16,true);
 
 Frame1 = new PFrame();
 s1.size(400,400);
 
 targets.loadSettings();
 
}

void draw()
{
  allTimer = (int)millis()/1000;
  background(bgColor);
  //fill(255);
  updateTarget();
  getFingers();
  for(int ii = 0; ii<fingNum; ii++)
 {
   fill(textColor);
   ellipse(tipPos[ii][0],tipPos[ii][1],20,20);

 }
 fill(textColor);
 s1.redraw();




}

public class PFrame extends Frame {
    public PFrame() {
        setBounds(100,100,400,400);
        s1 = new secondApplet();
        
        add(s1);
        s1.init();
        show();  } }
               
public class secondApplet extends PApplet {
    public void setup() {
        size(1200,600);
        noLoop(); }
    public void draw() { 
    background(bgColor);
 
 fill(textColor);
 textFont(font1,10);
targets.updateSettings();
if(!targets.updating)
   {
    fill(textColor);
    textFont(font1,30);
    text("Completed: "+trialsCompleted,30,50);
    text("Time Elapsed: "+allTimer,30,100);
   } 
  }  }

void updateTarget()
{
  boolean hit = checkCollision();
  
 if(hit && !tarHolding)
{
 tarHolding = true;
 tarTimer = millis();
} 
 else if(hit && tarHolding) 
 {
  float curTimeHolding = millis()-tarTimer;
  if(curTimeHolding >= targets.iTarHoldTimes[targets.currentTarget])
  {
  targets.currentTarget = (int)random(targets.numTargets);
  trialsCompleted++;
  tarHolding = false;
  }
  
  
 }
 else if(!hit)
 {
  tarHolding = false; 
 }
 
 fill(0,125,125);
 println(tarHolding);
 rect(targets.iTarX[targets.currentTarget],targets.iTarY[targets.currentTarget],targets.iTarWidth[targets.currentTarget],targets.iTarHeight[targets.currentTarget]);

}

boolean checkCollision()
{
  boolean hit = false;
  for(int ii = 0; ii <fingNum; ii++)
  {
    float tipX = tipPos[ii][0];
    float tipY = tipPos[ii][1];
    float tarX = targets.iTarX[targets.currentTarget];
    float tarY = targets.iTarY[targets.currentTarget];
    float tarW = targets.iTarWidth[targets.currentTarget];
    float tarH = targets.iTarHeight[targets.currentTarget];
   if(tipX>tarX && tipX < (tarX+tarW) && tipY>tarY && tipY<(tarY+tarH))
   {
    hit = true; 
   }
  }
  
  return hit;
}


void getFingers()
{
 fingNum = leapMotion.getFingerList().size();
 int ii = 0;
 for(Finger finger: leapMotion.getFingerList())
 {
   float x = leapMotion.getTip(finger).x;
   float y = leapMotion.getTip(finger).y;
   
   
   int xCenter = 400;
   int xRange = 300;
   
   int yCenter = 400;
   int yRange = 100;
   
   x = (x - (xCenter-xRange/2))/xRange*width;
   if(x<0)
     x = 0;
     else if(x>width)
       x = width;
   y = (y-(yCenter - yRange/2))/yRange*height;
   if(y<0)
      y=0;
      else if(y>height)
       y = height;
   
   
  
 
   tipPos[ii][0] = x;
   tipPos[ii][1] = y;
   
   
   ii++;
 }
}
/* Unused

void grid()
{
 for(int ii = 0; ii<width; ii= ii+2)
 {
   stroke(0);
  line(ii,0,ii,height) ;
   
 }
  for(int ii = 0; ii<height; ii= ii+2)
 {
   stroke(0);
  line(0,ii,height,ii) ;
   
 }
}
void initializeTarPos()
{
  int[] x = {0,width/2-tarW/2,width-tarW};
  int[] y = {0,height/2-tarH/2,height-tarH};
  int counter = 0;
  for(int iix = 0;iix<x.length;iix++)
  {
    for(int iiy = 0;iiy<y.length;iiy++)
    {
      tarPosAll[counter][0] = x[iix];
      tarPosAll[counter][1] = y[iiy];
      counter++;
    }
    
  }
  
}

*/
 

