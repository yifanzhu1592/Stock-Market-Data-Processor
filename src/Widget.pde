class Widget {
  int x, y, width, height, tl, tr, br, bl;
  int event;
  int widgetColor, labelColor;
  String label;
  PFont widgetFont;
  PImage image = null;

  Widget(int x, int y, int width, int height,
    int event, int tl, int tr, int br, int bl) {
    this.x = x;
    this.y = y;
    this.tl = tl;
    this.tr = tr;
    this.br = br;
    this.bl = bl;
    this.width = width;
    this.height = height;
    this.event = event;
  }

  // If the widget needs an image, it draws the image;
  // if it is an textWidget, it draws the rectangle
  void draw() {
    if (image != null) {
      image(image, x, y, width, height);
    } else {
      fill(widgetColor);
      rect(x, y, width, height, tl, tr, br, bl);  // The latter four parameters set the radius of the arc at each corner of the rectangle separately
      fill(labelColor);
      text(label, x + width / 2, y + (height + 5) / 2);
      textAlign(CENTER);
    }
  }
  
  // If the mouse locates within the area of the widget when the mouse is clicked,
  // then activating the event of the widget
  int getEvent(int mouseX, int mouseY) {
    if (mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height) {
      return event;
    }
    return EVENT_NULL;
  }
  
  // Setting the image of the widget
  void setImage(PImage image) {
    this.image = image;
  }

  // Setting the color of the widget
  void setWidgetColor(int widgetColor) {
    this.widgetColor = widgetColor;
  }

  // Setting the color of the label of the widget
  void setLabelColor(int labelColor) {
    this.labelColor = labelColor;
  }

  // Setting the label of the widget
  void setLabel(String label) {
    this.label = label;
  }
}
