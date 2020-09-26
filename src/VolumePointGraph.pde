// Showing stock volume over time in a point graph format
class VolumePointGraph extends Widget {
  ArrayList<Datapoints> data;
  int numberOfDates;
  int currentVolume = 0;
  float spacing, tmp;
  int maxVolume;
  PFont barFont;
  PFont smallXFont;
  int volumeSpacing = 0;
  float volumePoint;
  float lastTemp = -1;
  float lastVolumePoint = -1;
  int pointCounter = 0;
  float lastValue = -1;
  float radius;
  float sliderX, sliderY;
  int displayEnd;
  float ratio;
  int rangeValue = 0;
  boolean noDataToDisplay = false;
  
  VolumePointGraph(ArrayList<Datapoints> data, int maxVolume, int sliderWidth, int rangeValue, boolean noDataToDisplay) {
    super(450, 165, 400, 400, 543891, 0, 0, 0, 0);
    numberOfDates = data.size();
    this.data = data;
    this.maxVolume = maxVolume;
    this.rangeValue = rangeValue;
    this.noDataToDisplay = noDataToDisplay;
    barFont = loadFont("Arial-Black-15.vlw");
    smallXFont = loadFont("Arial-Black-10.vlw");
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
    line(x + 1, y + height, x + width, y + height);
    strokeWeight(1);

    volumeSpacing = width / 10;
    float textVolume = maxVolume / 10;
    float tmpVolume = maxVolume;
    float yAxisText = y;
    
    fill(0);
    textFont(smallXFont);
    text("0", x - 20, y + height + 10);
    for (int i = 0; i < 10; i++) {
      line(x, yAxisText, x - 5, yAxisText);
      stroke(230);
      line(x, yAxisText, x + width, yAxisText);
      stroke(0);
      fill(0);
      textFont(smallXFont);

      text(tmpVolume, x - 100, yAxisText);
      tmpVolume = tmpVolume - textVolume;
      yAxisText = yAxisText + volumeSpacing;
      textFont(stdFont);
    }

    if (data.size() > 45) {
      spacing = width / 41;
      tmp = x - spacing;
      ratio = ((float)data.size()) / (float)(400 - sliderWidth);

      if (dataSlider.getX() + sliderWidth >= 850) {
        displayEnd = data.size() - 1;
      } else {
        displayEnd = (int)(float)(((dataSlider.getX() - 450) * ratio) - 1);
      }
      if (displayEnd - 45 < 0) {
        displayEnd = 45;
      }

      for (int i = displayEnd - 45; i < displayEnd; i++) {

        tmp = tmp + spacing;

        volumePoint = y + height - ((float)data.get(i).volume() / (float)maxVolume) * width;
        if (mouseY < height + y && mouseY > y &&
          mouseX > tmp && mouseX < tmp + spacing) {
          fill(0);
          textFont(stdFont);
          text("Volume: " + data.get(i).volume(), x, y - 60);
          text("Date: " + data.get(i).date(), x, y - 30);

          radius = 6;
          fill(220, 20, 220);
        } else {
          radius = 3;
          textFont(stdFont);
          fill(172, 189, 193);
        }

        ellipse(tmp, volumePoint, radius, radius);

        fill(220);
        rect(x, y + height, width, 20, 0, 0, 5, 5);
        fill(172, 189, 193);

        if (pointCounter == 45) {
          lastValue = volumePoint;
          pointCounter = 0;
        }

        if (volumePoint == lastValue) {
        } else if (lastTemp != -1 || lastVolumePoint != -1) {
          line(lastTemp, lastVolumePoint, tmp, volumePoint);
        }

        lastTemp = tmp;
        lastVolumePoint = volumePoint;
        pointCounter++;
      }
    } else {
      tmp = x - spacing;

      for (Datapoints point : data) {

        tmp = tmp + spacing;

        volumePoint = y + height - ((float)point.volume() / (float)maxVolume) * width;

        if (mouseY < height + y && mouseY > y &&
          mouseX > tmp && mouseX < tmp + spacing) {
          fill(0);
          textFont(stdFont);
          text("Volume: " + point.volume(), x, y - 60);
          text("Date: " + point.date(), x, y - 30);

          radius = 6;
          fill(220, 20, 220);
        } else {
          radius = 3;
          textFont(stdFont);
          fill(172, 189, 193);
        }

        ellipse(tmp, volumePoint, radius, radius);

        if (pointCounter == data.size()) {
          lastValue = volumePoint;
        }

        if (volumePoint == lastValue) {
        } else if (lastTemp != -1 || lastVolumePoint != -1) {
          line(lastTemp, lastVolumePoint, tmp, volumePoint);
        }

        lastTemp = tmp;
        lastVolumePoint = volumePoint;
        pointCounter++;
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
      text("Two Year Chart - ", 500, 50);
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
      text("Volume Point Chart", 500, 50);
    }
    textAlign(CENTER);
  }
}
