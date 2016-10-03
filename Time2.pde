
Table tides;
int cc;

PFont myFont;    // font data
PFont myFont2;

float x2;
float x3;
float x;
float y;
float yh;

// PImage img;

void setup(){
  
  tides = new Table(); 
  
  // load Excel data with headers
  
  tides = loadTable("tides.csv", "header");  
  
 size (800, 600);
 
 // img = loadImage("wave.jpg");
 imageMode(CORNER);

 frameRate(1);
 
 // load fonts to be used
   
  myFont = loadFont("Frutiger65-Bold-200.vlw");  // load the font from this sketch's data directory
  textFont(myFont);  // set the current font to myFont
  myFont2 = loadFont("AGaramondPro-BoldItalic-48.vlw");
   
  }
  
 void draw() {   
  
   textFont(myFont2, 50);
   fill(190,150,60);
   rect(0,0,800,600);
   fill(255,250,40);
   text("Southport Tides", 200, 550);
   textFont(myFont, 15);
   text("powered  by National Oceanography Center data", 200, 580);
   
   
   fill(0);
 
  textFont(myFont, 14);
   float c2;
   float c3;
   String month1;
   String day1;
   String hour1;
   String minute1;
   String height1;
   String tide1;
   int month2;
   int hour2;
   int minute2;
   float height2;
   
   String daymonthyear;
   
   // Todays date
   
   daymonthyear = (day() + " / " + month() + " / " + year());
   
   
   float day2;
   int negpos;
   int hr;
   int min;
   int day3;
   int [] hourt = new int[6];
   int [] minutet = new int[6];
   float [] heightt = new float[6];
   String[] tidet = new String[6];
   tidet[4] = "No ";
    tidet[5] = "No ";
   int tidest;
   String tideline;
   int rowcount;
   
   tidest = 0;
  
  rowcount = tides.getRowCount();     // rows in tide file
  
   for (int n = 0; n < rowcount; n++) {
    
  
  TableRow row = tides.getRow(n);     // read each row 
 
  
  tide1 = row.getString("Tide");
  
  month1 = row.getString("Month");
  
  month2 = int(month1);
  
  
  hour1 = row.getString("Hour");
  
  hour2 = int(hour1);
  
  minute1 = row.getString("Minute");
  
  minute2 = int(minute1);
  
  
  
   height1 = row.getString("Height");
   
   height2 = float(height1);
   
   
    day1 = row.getString("Day");
  
  
    day2 = float(day1);
   
    day3 = (int) day2;
  
  if (day3 == day() &&  month2 == month()) { 
 
  
  tidet[tidest] = tide1;       // if date is today store tide values
  hourt[tidest] = hour2;
  minutet[tidest] = minute2;
  heightt[tidest] = height2;
  
  tidest++;
  
   }
   } 
   
   // draw 1/2 sine wave 
   
   for (int c1 = 180; c1 >= 1; c1--){ 
   
   yh = -sin(c1/(180/PI));
   
   y = yh * 100;
   
   x = 50+(c1*4);
   c2 = (float) c1/(180);
   negpos = (int) yh;
   
   if (c1 >= 90) {
   c3 = ((1-c2)*255);}
      else
      { c3 = (c2*255);}
   
   
   
      
   strokeWeight(8);
   stroke((int) c3+150, 50, 55, 255 - c3);
   line(x,200, x, y+200);
   }
   
   strokeWeight(4);
   stroke(150);
   hr = hour();
   min = minute();
   x2 = 50+(((hr*60)+ (min))/2);
   
   line(x2,200, x2, 100);      // draw time line   
   
   for (int tide = 0; tide <= tidest-1; tide++) {
   
     strokeWeight(3);
     
     // calculate tide line position
     
     x3 = 50+(((hourt[tide] * 60) + minutet[tide])/2);
     
     
     if (tidet[tide].equals("High Tide") ) {    
      
     stroke(20,20,255);
  text(" High ", x3, 135);   
   text(" Tide", x3, 155);
   
   
     }
       
      else
      
{
       
       stroke(255,255, 20);
   text(" Low ", x3, 135);
   text(" Tide", x3, 155);
 } 
        
        line(x3,200, x3, (200- (heightt[tide]*12)));  // draw tide line     
       
       }
   
   // draw hours and minutes on time line 
   
   textFont(myFont, 25);
   text(hour(), x2-10, 80);
   
   textFont(myFont, 15);
   text("hrs", x2+17, 80);   
   
   textFont(myFont, 25); 
   text (minute(), x2-10, 230);
   textFont(myFont, 15);
   text("mins", x2+17, 230);
   
   
   textFont(myFont, 15);
   text (second(), x2-10, 260);
   textFont(myFont, 12);   
   text("secs", x2+10, 260);
   
   
   textFont(myFont2, 20);
   fill(100,100,250);
   text(daymonthyear, 80, 40);
   
   // print tide detail lines
  
   for (int lines = 0; lines <= tidest-1; lines++) {        
    
     tideline = (tidet[lines] + "  " + hourt[lines] + ":" + minutet[lines] + "   " + heightt[lines] +  " metres"); 
      textFont(myFont2, 20);
      fill(100,10,200);
     text(tideline, 250, (330 + (lines * 40)));
    
  save("tideclock");    // save image
   
 }

}