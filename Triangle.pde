// represents a triangle that can be drawn to the screen
class Triangle implements Drawable {
    float x1;
    float x2;
    float x3;
    float y1;
    float y2;
    float y3;
    float centerX;
    float centerY;
    float w;
    float h;
    ArrayList<Point> points;
    color c;
  
    // constructor that takes in x and y 
    Triangle(float x, float y, float w, float h, boolean isFilled) {
        this.centerX = x;
        this.centerY = y;
        this.w = w;
        this.h = h;
        this.x1 = x - (w/2);
        this.y1 = y + (h/2);
        this.x2 = x + (w/2);
        this.y2 = y + (h/2);
        this.x3 = x;
        this.y3 = y - (h/2);
        
        this.points = new ArrayList<Point>();
        this.points.add(new Point(x1, y1));
        this.points.add(new Point(x2, y2));
        this.points.add(new Point(x, y3));
        pickColor(isFilled);
    }

    // constructor that takes in a point (x, y)
    Triangle(Point p, float w, float h, boolean isFilled) {
        this(p.x, p.y, w, h, isFilled);
    }
    
    // draws a triangle to the screen
    public void drawToScreen() {
      triangle(x1, y1, x2, y2, x3, y3);
    }

    // gets a random corner from the triangle returned as a point
    public Point getRandomPoint() {
        return this.points.get(constrain(floor(random(0, 3)), 0, 2));
    }
    
    // picks a random color from the set
    public void pickColor(boolean isFilled) {
      int randomC = constrain(floor(random(0, 3)), 0, 2);
      if (randomC == 0) {
          //stroke(153, 230, 255, 100); 
          c = c1;
        }
      else if (randomC == 1)  {
          //stroke(243, 255, 153, 100);
          c = c2;
        }
      else {
          //stroke(255, 177, 153, 100);
          c = c3;
      }
      
      if(isFilled) {
        noStroke();
        fill(c);
      }
      else {
        strokeWeight(5);
        stroke(c);
        noFill();
      }
    }

}
