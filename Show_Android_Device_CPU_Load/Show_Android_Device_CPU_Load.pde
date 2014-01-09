String[] rawStringFromLog;

int delta = 8;  //Draw one point every 8 pixel
int cpuReadInterval = 3;  //Default Top cmd read cpu load info every 3 second

int cpuSpecFrom = 26 + 100 - 30;  //Low cpu load line in spec

int cpuLoadMax_Min = 20;    //High cpu load line in spec
int cpuSpecTo = cpuSpecFrom - cpuLoadMax_Min;

void loadLog()
{
  rawStringFromLog = loadStrings("phone_click_cpuload.log"); 
  float y = 0;
  int time = 0;
  float sum = 0.0f;
  //Get the average cpu info.
  for (int i = 0; i < rawStringFromLog.length; i++)
  {
    String[] INPUT = match(rawStringFromLog[i], "depthcameraservice -d");
    if (INPUT != null)     //Trim out the raw x,y.Not the android pad x,y. The string INPUT in log represent it is android pad log.
    {
      String[] yValue = match(rawStringFromLog[i],"   0 (.*?) depthcameraservice -d");            //Find out the y value
  rawStringFromLog = loadStrings("cpu.log"); 
  float y = 0;
  int time = 0;
  //Get the average cpu info.
  for (int i = 0; i < rawStringFromLog.length; i++)
  {
    String[] INPUT = match(rawStringFromLog[i], "/system/bin/depthcameraservice");
    if (INPUT != null)     //Trim out the raw x,y.Not the android pad x,y. The string INPUT in log represent it is android pad log.
    {
      String[] yValue = match(rawStringFromLog[i], "   0 (.*?) /system/bin/depthcameraservice");            //Find out the y value
>>>>>>> 8065244ed0315b9af2c03b33f179dd9b0b2bff26
      if (yValue != null)
      {
        time++;
        y = Float.parseFloat(yValue[1]); 
        fill(0, 0, 255);
        drawOutThisPoint(time*delta, int(y));
       }
    }
    //read and show multi cpu info by press '1' key in top cmd
    //cpu0
    String[] cpu0Input = match(rawStringFromLog[i], "CPU0:");
    if (cpu0Input != null)     //Trim out the raw x,y.Not the android pad x,y. The string INPUT in log represent it is android pad log.
    {
      String[] yValue = match(rawStringFromLog[i], "CPU0: (.*?)% usr");            //Find out the y value
      if (yValue != null)
      {
        y = Float.parseFloat(yValue[1]);
<<<<<<< HEAD
        sum = sum + y;
=======
>>>>>>> 8065244ed0315b9af2c03b33f179dd9b0b2bff26
        fill(0,255,0);
        drawOutThisPoint(time*delta, int(y));
       }
    }
    //cpu1
    String[] cpu1Input = match(rawStringFromLog[i], "CPU1:");
    if (cpu1Input != null)     //Trim out the raw x,y.Not the android pad x,y. The string INPUT in log represent it is android pad log.
    {
      String[] yValue = match(rawStringFromLog[i], "CPU1: (.*?)% usr");            //Find out the y value
      if (yValue != null)
      {
        y = Float.parseFloat(yValue[1]);
        fill(255,0,0);
        drawOutThisPoint(time*delta, int(y));
      }
    }
  }
  println("cpu0 average = ", sum/time);
  println("cpu0 sum = ", sum);
  println("read cpu0 times = ", time);
}

void setup()
{
  size(1200, 152);
  background(0); 
  textSize(18);
  loadLog();
  //Draw the central line in x.The area in the left of this line => x<0.
  stroke(126);
  line(0, 127, width, 127);  //  %0
  line(0, cpuSpecTo, width, cpuSpecTo);   //  
  line(0, cpuSpecFrom, width, cpuSpecFrom);  //  cpuSpec
  line(0, 26, width, 26);   //  %100
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
  int x = cpuReadInterval*mouseX/delta;    //Top cmd in adb read the data every 3 second
  int y = 125 - mouseY;
  if(y > 100) y = 100;
  if(y < 0) y = 0;

  String str = "(" + x + "s" + "," + y + "%" + ")";

  fill(0);
  noStroke();
  rectMode(CENTER);
  rect(width - 53, height - 30, 106, 22);
  fill(0, 100, 305, 204);
  text(str, width - 106, height - 22);
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
