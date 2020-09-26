// Showing the closing price compared to the total time of the stock
class ClosingPriceBarChart extends Widget {
  ArrayList<Datapoints> data;
  int numberOfDates;
  int currentClosingPrice = 0;
  float spacing;
  double maxClosingPrice;
  PFont barFont;
  PFont smallXFont;
  int closingPriceSpacing = 0;
  int displayEnd;
  int rangeValue = 0;
  float ratio;
  boolean noDataToDisplay = false;

  ClosingPriceBarChart(ArrayList<Datapoints> data, double maxClosingPrice, int sliderWidth, int rangeValue, boolean noDataToDisplay) {
    super(450, 165, 400, 400, 543891, 0, 0, 0, 0);
    numberOfDates = data.size();
    this.data = data;
    this.maxClosingPrice = maxClosingPrice;
    this.rangeValue = rangeValue;
    this.noDataToDisplay = noDataToDisplay;
    barFont=loadFont("Arial-Black-15.vlw");
    smallXFont=loadFont("Arial-Black-10.vlw");
    spacing = height / (float)numberOfDates;
    dataSlider = new Slider(850 - sliderWidth, 565, sliderWidth, 20, NULL, 10, 10, 10, 10);
    dataSlider.setLabel("");
    displayEnd = data.size();
  }

  @Override
    void draw() {
    textAlign(LEFT);
    line(x, y, x, y + height);
    strokeWeight(3);
    line(x, y + height, x + width, y + height);
    strokeWeight(1);

    closingPriceSpacing = height / 10;
    float textClosingPrice = (float)maxClosingPrice / 10;
    float tmpClosingPrice = (float)maxClosingPrice;
    float yAxis = y;
    float yAxisText = y;

    line(x, y + height, x - 5, y + height);
    fill(0);
    textFont(smallXFont);
    text("0", x - 25, y + height + 3);
    for (int i = 0; i < 10; i++) {
      line(x, yAxis, x - 5, yAxis); 
      fill(0);
      stroke(230);
      line(x, yAxisText, x + width, yAxisText);
      stroke(0);
      fill(0);
      textFont(smallXFont);
      String s = nf(tmpClosingPrice, 0, 2);
      text("" + s, x - 50, yAxis + 5);
      tmpClosingPrice = tmpClosingPrice - textClosingPrice; 
      yAxisText = yAxisText + closingPriceSpacing;
      yAxis = yAxis + closingPriceSpacing;
    }

    if (data.size() > 45) {

      spacing = height / 44;
      ratio = ((float)data.size()) / (float)(400 - sliderWidth);
      if (dataSlider.getX() + sliderWidth >= 850) {
        displayEnd = data.size() - 1;
      } else {
        displayEnd = (int)(float)(((dataSlider.getX() - 450) * ratio) - 1);
      }
      if (displayEnd - 45 < 0) {
        displayEnd = 45;
      }

      float tmp = x;

      for (int i = displayEnd - 45; i < displayEnd; i++) {

        float ClosingPricePercentage = ((float)data.get(i).close_price() / (float)maxClosingPrice) * height;
        if (mouseY < height + y && mouseY > y &&
          mouseX > tmp && mouseX < tmp + spacing) {
          fill(0);
          textFont(stdFont);
          text("Closing Price: " + data.get(i).close_price, x, y - 60);
          text("Date: " + data.get(i).date, x, y - 30);
          fill(220, 20, 220);
        } else {
          fill(172, 189, 193);
          textFont(stdFont);
        }
        rect(tmp, y + height, spacing, -ClosingPricePercentage);
        tmp = tmp + spacing;
      }
    } else {

      float tmp = x;

      for (Datapoints point : data) {

        float ClosingPricePercentage = ((float)point.close_price() / (float)maxClosingPrice) * height;
        if (mouseY < height + y && mouseY > y &&
          mouseX > tmp && mouseX < tmp + spacing) {
          fill(0);
          textFont(stdFont);
          text("Closing Price: " + point.close_price(), x, y - 60);
          text("Date: " + point.date(), x, y - 30);
          fill(220, 20, 220);
        } else {
          fill(172, 189, 193);
          textFont(stdFont);
        }
        rect(tmp, y + height, spacing, -ClosingPricePercentage);
        tmp = tmp + spacing;
      }
    }

    if (noDataToDisplay) {

      textFont(stdFont);
      fill(0);
      text("NO DATA TO DISPLAY", 525, 365);
    }

    if (rangeValue == 5) {

      String[] firstDate = fiveYearsPrevious.split("-");
      String[] secondDate = fiveYearsAfter.split("-");

      textFont(stdFont);
      fill(0);
      text("Five Year Chart - ", 500, 50);
      text(firstDate[0] + ":" + secondDate[0], 655, 50);
      
    } else if (rangeValue == 2) {

      String[] firstDate = twoYearsPrevious.split("-");
      String[] secondDate = twoYearsAfter.split("-");

      textFont(stdFont);
      fill(0);
      text("Two Year Chart - ", 500, 50 ;
      text(firstDate[0] + ":" + secondDate[0], 655, 50);
      
    } else if (rangeValue == 1) {

      String[] firstDate = oneYearsPrevious.split("-");
      String[] secondDate = oneYearsAfter.split("-");

      textFont(stdFont);
      fill(0);
      text("One Year Chart - ", 500, 50);
      text(firstDate[0] + ":" + secondDate[0], 655, 50);
      
    } else if (rangeValue == 0) {
      textFont(stdFont);
      fill(0);
      text("Closing Price Bar Chart", 500, 50);
    }
    textAlign(CENTER);
  }
}
