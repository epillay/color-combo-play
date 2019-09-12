import controlP5.*;

// controller for each color picker
ControlP5 cp51;
ControlP5 cp52;
ControlP5 cp53;

// color pickers
ColorPicker cp1;
ColorPicker cp2;
ColorPicker cp3;

// set of colors
color c1;
color c2;
color c3;

ArrayList<Drawable> objectsToDraw; // stores all objects that are on the screen
float seedx; // x value of first drawable object
float seedy; // y value of first drawable object
int maxVal;  // max value (dimensions)
int minVal;  // min value (dimensions)

boolean loop; // is the drawing paused/playing?
boolean isFilled; // does the shape have a fill/no fill?

String shape; // shape name that is being drawn

int tick; // keeps track of current tick

// sets screen size
void settings() {
    size(1000, 900);
}


// setup method
void setup() {
    
    // set background color and frame rate
    background(255);
    frameRate(20);
    tick = 0;
    
    // initialize variables
    objectsToDraw = new ArrayList<Drawable>();
    seedx = 500;
    seedy = 500;
    maxVal = 100;
    minVal = 50;
    loop = false; // starts out as paused
    isFilled = false; // default set to no fill
    shape = "rectangle"; // default starting shape
    
    cp51 = new ControlP5(this);
    cp1 = cp51.addColorPicker("picker1")
          .setPosition(50, 800)
          .setColorValue(color(0, 0, 0, 0))
          ;
          
    cp52 = new ControlP5(this);
    cp2 = cp52.addColorPicker("picker2")
          .setPosition(375, 800)
          .setColorValue(color(0, 0, 0, 0))
          ;
       
    cp53 = new ControlP5(this);      
    cp3 = cp53.addColorPicker("picker3")
          .setPosition(700, 800)
          .setColorValue(color(0, 0, 0, 0))
          ;
    
    // drawing boxes around each color picker
    fill(255);
    stroke(0);
    strokeWeight(1);
    rect(40, 790, 275, 80);
    rect(365, 790, 275, 80);
    rect(690, 790, 275, 80);
    
    // setting text font
    textSize(14);
    PFont newFont = loadFont("Courier-48.vlw");
    textFont(newFont, 13);
}

// draw method
void draw() {
    tick++;
    // check if the drawing is paused/playing
      if (loop) {
        // if there are no objects to draw, use the seed value to draw the first one
        if (objectsToDraw.size() == 0) {
            addShape(seedx, seedy, random(minVal, maxVal), random(minVal, maxVal), isFilled);
        } 
        
        // else, add a new object to draw using a random point from the previous drawable
        else {
            Drawable lastAdded = objectsToDraw.get(objectsToDraw.size() - 1);
            Point randomP = lastAdded.getRandomPoint();
            float randomH = random(minVal, maxVal);
            float randomW = random(minVal, maxVal);
            
            // check that the new random coordinates are valid before adding it, if they are invalid it will not be added
            if (isValidCoord(randomP, randomW, randomH) && (tick % 2 == 0)) {
              addShape(randomP.x, randomP.y, randomW, randomH, isFilled);
            }
        }
      }
      
      // regardless of paused/play, render the text to the screen with data to the user
      updateText();
}

// updates the text on the screen that shows the user the selected shape and fill
void updateText() {
  // draw a rectangle to cover up previous text and draw panel format
  fill(255);
  noStroke();
  rect(35, 10 + 730, 170, 40);
  pushMatrix();
  strokeWeight(1);
  stroke(0);
  line(0, 10 + 730, 205, 10 + 730);
  line(205, 10 + 730, 205, 770);
  line(205, 770, 1000, 770);
  popMatrix();
  
  // draw the new text over the rectangle
  stroke(0);
  fill(0);
  text("Selected shape: ", 40, 30 + 730);
  
  // set the current fill option
  Drawable shapeIcon;
  if (shape.equals("rectangle")) {
    shapeIcon = new Rectangle(170, 15 + 730, 20, 20, isFilled);
  } else if (shape.equals("ellipse")) {
    shapeIcon = new Ellipse(180, 25 + 730, 20, 20, isFilled);
  } else {
    shapeIcon = new Triangle(180, 25 + 730, 20, 20, isFilled);
  }
  pushMatrix();
  strokeWeight(1);
  stroke(0);
  if (isFilled) {
    fill(0);
  }
  shapeIcon.drawToScreen();
  popMatrix();
}

// adds a shape to the list of drawables based on the selected shape type
void addShape(float x, float y, float w, float h, boolean isFilled) {
  Drawable objectToAdd;
  if (shape.equals("rectangle")) {
    objectToAdd = new Rectangle(x, y, w, h, isFilled);
  } else if (shape.equals("ellipse")) {
    objectToAdd = new Ellipse(x, y, w, h, isFilled);
  } else {
    objectToAdd = new Triangle(x, y, w, h, isFilled);
  }
    objectsToDraw.add(objectToAdd);
    objectToAdd.drawToScreen();
}

// method to handle key presses
// - " " -> pause/play
// - "r" -> reset to a blank screen
// - "f" -> toggle fill/no fill
// - "s" -> toggle through shapes
void keyPressed() {
  switch(key) {
    case ' ':
      if (loop) {
        loop = !loop;
      } else {
        loop = !loop;
      }
      break;
    case 'r':
      setup();
      break;
    case 'f':
      isFilled = !isFilled;
      break;
    case 's':
      if (shape.equals("rectangle")) {
        shape = "ellipse";
      } else if (shape.equals("ellipse")) {
        shape = "triangle";
      } else {
        shape = "rectangle";
      }
      break;
  }
}

// handles events from the color pickers by checking which color picker the event is from and then
// setting the colors in the color set to the values from the event
public void controlEvent(ControlEvent c) {
  // when a value change from a ColorPicker is received, extract the ARGB values
  // from the controller's array value
  if(c.isFrom(cp1)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    c1 = color(r,g,b,a);
  }
  
  if(c.isFrom(cp2)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    c2 = color(r,g,b,a);
  }
  
  if(c.isFrom(cp3)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    c3 = color(r,g,b,a);
  }
}

// returns true if the coordinates are vallid (the image wont go outside of boundaries), false otherwise
boolean isValidCoord(Point center, float w, float h) {
    return !(center.y + h > 760 || center.y - h < 0 || center.x + w > width || center.x - w < 0);
}
