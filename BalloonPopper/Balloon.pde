public class Balloon {
 
 private int bWidth;
 private int bLenght;
 private int xpos;
 private int ypos;
 private color bcolor;
  
 public Balloon(int xpos, int ypos, int bWidth, int bLenght, color bcolor) {
  this.bWidth = bWidth;
  this.bLenght = bLenght;
  this.xpos = xpos;
  this.ypos = ypos;
  this.bcolor = bcolor; 
 }
  
  void drawBalloon() {
   fill(bcolor);  
   triangle(xpos, ypos + bLength/2.4, xpos + bWidth/10, ypos + bLength/1.7, xpos - bWidth/10, ypos + bLength/1.7); 
   ellipse(xpos, ypos, bWidth, bLenght); // balloon size 
  }
  
  void balloonUpdate(int goesUpBy) {
   ypos -= goesUpBy;
  }

}
