// represents a drawable object
interface Drawable {
    
    // draws the object to the screen 
    public void drawToScreen();

    // gets a random point that belongs to the object
    public Point getRandomPoint();
    
    // picks the appropriate color to draw the object in
    public void pickColor(boolean isFilled);
   
}
