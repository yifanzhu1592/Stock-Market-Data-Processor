// The SlideWidget class contains information about the slider
class Slider extends Widget {
  
  Slider(int x, int y, int width, int height, 
    int event, int tl, int tr, int br, int bl) {
    super(x, y, width, height, event, tl, tr, br, bl);
    this.labelColor = color(0); 
    this.widgetColor = color(240);
  }
  
  void setPositionY(int y) {
    this.y = y;
  }
  
  void setPositionX(int x) {
   this.x = x; 
  }

  int getEvent(int mouseX, int mouseY) {
    if (mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height) {
      return event;
    }
    return NULL;
  }
  
  int getX() {
    return x;
  }
}
