String[] rawStringFromLog;

int delta = 8;

void loadLog()
{
  rawStringFromLog = loadStrings("cpu.log"); 
  int y0 = 0;
  int y1 = 0;
  int time = 0;
  boolean waitForTheSecondPoint = false;
  
  for (int i = 0; i < rawStringFromLog.length; i++)
  {
    String[] INPUT = match(rawStringFromLog[i], "/data/addFingerGestureService");
    if (INPUT != null)     //Trim out the raw x,y.Not the android pad x,y. The string INPUT in log represent it is android pad log.
    {
      String[] yValue = match(rawStringFromLog[i], "1  (.*?)% S    12");            //Find out the y value
      
      if (yValue != null)
      {
        time++;
          //println("x:" + xValue[1] + "  y:" + yValue[1]);
          if (!waitForTheSecondPoint)
          {
            waitForTheSecondPoint = true;
            y0 = Integer.parseInt(yValue[1]);
            fill(0, 305, 0);
            drawOutThisPoint(time*delta, y0);
            stroke(#BCEE68);
            if (time -1 > 0) line((time - 1)*delta, 126 - y1, time*delta, 126 - y0);
          }
          else
          {
            waitForTheSecondPoint = false;
            drawOutThisPoint(time*delta, Integer.parseInt(yValue[1]));  //(xValue + 18000)/30
            y1 = Integer.parseInt(yValue[1]);
            stroke(#BCEE68);
            line((time - 1)*delta, 126 - y0, time*delta, 126 - y1);
          }
        }
    }
  }
}

void setup()
{
  size(1200, 152);
  background(0); 
  textSize(18);
  loadLog();
  //Draw the central line in x.The area in the left of this line => x<0.
  fill(100, 100, 100);
  stroke(126);
  line(0, 127, width, 127);
  line(0, 76, width, 76);
  line(0, 26, width, 26);
}

void draw()
{
  //for msg loop,do not remove this empty function
}

void drawOutThisPoint(int xValue, int yValue)
{
  //  println("x:" + x + "  y:" + y);
  noStroke();
  ellipse(xValue, 126 - yValue, 4, 4);
}

//Get the xy's depth
void mouseMoved()
{
  int x = 3*mouseX/delta;    //Top cmd in adb read the data every 3 second
  int y = 125 - mouseY;
  if(y > 100) y = 100;
  if(y < 0) y = 0;

  String str = "(" + x + "s" + "," + y + "%" + ")";

  fill(0);
  noStroke();
  rectMode(CENTER);
  rect(width - 48, height - 30, 96, 22);
  fill(0, 100, 305, 204);
  text(str, width - 96, height - 22);
}


void keyPressed() {
  println("pressed " + int(key) + " " + keyCode);
  if (keyCode == 32)   //Press the blank space key to reload the log file
  {
    loadLog();
  }
  if (keyCode == 83)   //Press the s key to save the frame
  {
    saveFrame();
  }
}
