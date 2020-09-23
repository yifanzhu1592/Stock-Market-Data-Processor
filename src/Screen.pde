class Screen {
  int bgColor; //background color
  ArrayList Widgets;
  int dataNo;
  int resultNo;
  
  Screen(int c) {
    this.bgColor = c;
    dataNo = 0;
    resultNo = 0;
    Widgets = new ArrayList();
  }
  
  Widget getEvent(int mouseX, int mouseY) {
    for (int i = 0; i < Widgets.size(); i++) {
      Widget aWidget = (Widget) Widgets.get(i);
      int x = aWidget.x;
      int y = aWidget.y;
      if (mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height) {
        return aWidget;
      }
    }
    return null;
  }
  
  // Printing searching result
  void draw() {
    printData();
  }
  
  // Adding a widget to the screen
  void addWidget(Widget aWidget) {
    Widgets.add(aWidget);
  }
  
  // Printing searching result
  void printData() {
    background(bgColor);
    for (int i = 0; i < Widgets.size(); i++) {
      Widget aWidget = (Widget) Widgets.get(i);
      aWidget.draw();
    }
    // The prompt for searhing bars
    fill(0);
    line(553, 50, 557, 50);
    text("Stock name: ", 85, 15);
    text("Choose chart:", 240, 120);
    text("Choose type:", 240, 200);
    text("Choose time:", 240, 310);
    text("Or a range:", 240, 435);
    
    // Printing stock information
    int xpos = 230;
    int ypos = 650;
    noFill();
    rect(xpos - 7,ypos - 22, 629, 210, 5, 5, 5, 5);
    
    textAlign(LEFT);
    text("STOCK  INFORMATION", xpos, ypos - 30);
    if (resultStock != null) {
      text("Ticker: " + resultStock.ticker, xpos, ypos);
      text("Exchange: " + resultStock.exchange, xpos, ypos + 30);
      text("Name: " + resultStock.name, xpos, ypos + 60);
      text("Sector: " + resultStock.sector, xpos, ypos + 90);
      text("Industry: " + resultStock.industry, xpos, ypos + 120);
      text("The date with largest price change in the date range: " + LchangeDate, xpos, ypos + 150);
      text("Largest Price Change: " + LargestChange + "%", xpos, ypos + 180);
    }
    textAlign(CENTER);
  }
}
