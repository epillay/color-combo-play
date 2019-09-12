// represents a rectangle that can be drawn to the screen
class Rectangle implements Drawable {
    float x;
    float y;
    float w;
    float h;
    ArrayList<Point> points;
    color c;
  
    // constructor that takes in x and y 
    Rectangle(float x, float y, float w, float h, boolean isFilled) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.points = new ArrayList<Point>();
        this.points.add(new Point(x - (w/2), y - (h/2)));
        this.points.add(new Point(x + (w/2), y - (h/2)));
        this.points.add(new Point(x + (w/2), y + (h/2)));
        this.points.add(new Point(x - (w/2), y + (h/2)));
        pickColor(isFilled);
    }

    // constructor that takes in a point (x, y)
    Rectangle(Point p, float w, float h, boolean isFilled) {
        this(p.x, p.y, w, h, isFilled);
    }
    
    // draws a rectangle to the screen
    public void drawToScreen() {
      rect(x, y, w, h);
    }

    // gets a random corner from the rectangle returned as a point
    public Point getRandomPoint() {
        return this.points.get(constrain(floor(random(0, 4)), 0, 3));
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
