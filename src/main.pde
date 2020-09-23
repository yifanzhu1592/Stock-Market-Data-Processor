import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Collections;
import java.util.Arrays;
import java.util.List;

Datapoints data;
Stocks resultStock;
ArrayList<Datapoints> dataList;
ArrayList<Datapoints> resultList;
ArrayList<Stocks> stockList;
//Matteo added selectChartButton widget 02/04/20
ArrayList<Datapoints> dateInRangeList;
Widget searchButton, upArrowWidget, downArrowWidget, slideWidget,
       dataSlideWidget, selectChartButton, barChart, pointsChart, volumeVsTime, 
       openingVsTime, closingVsTime, allTime, fiveYear, twoYear, oneYear, 
       selectChart2,  backArrowWidget, forwardArrowWidget, dateRange;
Widget[] searchList;
int currentSearchElement = 0;
Slider slider, dataSlider;
VolumeBarChart chart;//Tim added graph, 2/4 11:19
VolumePointGraph graph;
TextWidget searchWidget;
TextWidget searchSpecificYear, searchSpecificMon, searchSpecificDay, 
           searchSpecificYear_1, searchSpecificMon_1, searchSpecificDay_1;
PFont stdFont;
PImage upArrow;
PImage downArrow;
PImage leftArrow;
PImage rightArrow;
final int NULL = 0;
final int UP_ARROW = 1;
final int DOWN_ARROW = 2;
final int SEARCH_WIDGET = 3;
final int SEARCH_BUTTON = 4;
final int SEARCH_LIST = 5;
Screen screen1, currentScreen;
//final int SEARCH_BUTTON_DATE = 6;
final int SEARCH_SPECIFIC_YEAR_START = 7, SEARCH_SPECIFIC_MON_START = 8, SEARCH_SPECIFIC_DAY_START = 9;
final int SEARCH_SPECIFIC_YEAR_END = 11, SEARCH_SPECIFIC_MON_END = 12, SEARCH_SPECIFIC_DAY_END = 13;
final int SLIDE_WIDGET = 10;
final int DATA_SLIDE_WIDGET = 28;
//Screen screen1, screen2, currentScreen;
int sliderHeight = 0, sliderWidth = 0;
//Matteo added select chart event 02/04/20
//final int CHOOSE_CHART = 14;
final int BAR_CHART = 15;
final int POINTS_CHART = 16;
final int VOLUME_VS_TIME = 17;
final int OPENING_VS_TIME = 18;
final int CLOSING_VS_TIME = 19;
final int ALL_TIME = 20;
final int FIVE_YEAR = 21;
final int TWO_YEAR = 22;
final int ONE_YEAR = 23;
final int SELECT_DATE = 24;
final int SELECT_CHART = 25;
final int BACK_ARROW = 26;
final int FORWARD_ARROW = 27;
final int DATE_RANGE = 29;

//Screen screen1, currentScreen;
int focus = NULL;
int searchListNo = 0;
double LargestChange = 0;
String LchangeDate = ""; //the date with the largest change
String yearStart = "yyyy", monthStart = "mm", dayStart = "dd", 
  yearEnd = "yyyy", monthEnd = "mm", dayEnd = "dd";
String currentLabel = "Type...";

  String fiveYearsPrevious = "2015-01-01";
  String fiveYearsAfter = "2020-01-01";
  String twoYearsPrevious = "2018-01-01";
  String twoYearsAfter = "2020-01-01";
  String oneYearsPrevious = "2019-01-01";
  String oneYearsAfter = "2020-01-01";
  
  String currentTicker = "";

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

  boolean barChartBool = false;
  boolean pointsChartBool = false;
  boolean volumeVTimeBool = false;
  boolean openingVTimeBool = false;
  boolean closingVTimeBool = false;
  boolean allTimeBool = false;
  boolean fiveYearBool = false;
  boolean twoYearBool = false;
  boolean oneYearBool = false;
  //boolean selectDateBool = false;
  boolean selectChartBool = false;
  //Ruxin, added dateRangeBool for the new button, 15/04, 12pm
  boolean dateRangeBool = false;
  
  int searchOrListTicker = 0;
  String listLabel ="";


void setup() {
  // Setting the screen and the font of texts
  size(960, 900);
  stdFont = loadFont("Bahnschrift-20.vlw");
  textFont(stdFont);

  // Two arrows for scrolling up and down the list
  upArrow = loadImage("upArrow.png");
  downArrow = loadImage("downArrow.png");
  upArrowWidget = new Widget(120, 95, 50, 50, UP_ARROW, 0, 0, 0, 0);
  upArrowWidget.setImage(upArrow);
  downArrowWidget = new Widget(120, 807, 50, 50, DOWN_ARROW, 0, 0, 0, 0);
  downArrowWidget.setImage(downArrow);
  
  // Two arrows for selecting the time segment of the chart
  leftArrow = loadImage("backwardsArrow.png");
  rightArrow = loadImage("forwardsArrow.png");
  backArrowWidget = new Widget(360, 540, 50, 50, BACK_ARROW, 0, 0, 0, 0);
  backArrowWidget.setImage(leftArrow);
  forwardArrowWidget = new Widget(880, 540, 50, 50, FORWARD_ARROW, 0, 0, 0, 0);
  forwardArrowWidget.setImage(rightArrow);
  
  // The slideWidget as the background of the slider
  slideWidget = new Widget(125, 138, 38, 675, SLIDE_WIDGET, 0, 0, 0, 0);
  slideWidget.setWidgetColor(200);
  slideWidget.setLabelColor(0);
  slideWidget.setLabel("");
  
  // The dataSlideWidget as the background of the slider
  dataSlideWidget = new Widget(450, 565, 400, 20, DATA_SLIDE_WIDGET, 0, 0, 5, 5);
  dataSlideWidget.setWidgetColor(200);
  dataSlideWidget.setLabelColor(0);
  dataSlideWidget.setLabel("");

  // The searchWidget for searching for a designated stock
  searchWidget = new TextWidget(25, 25, 120, 50, currentLabel, stdFont, SEARCH_WIDGET, 5, 10, 10, 10, 10);
  searchWidget.setLabelColor(200);
  
  // The searchButton as the search button
  searchButton = new Widget(150, 25, 100, 50, SEARCH_BUTTON, 10, 10, 10, 10);
  searchButton.setWidgetColor(color(200, 20, 200));
  searchButton.setLabelColor(color(255));
  searchButton.setLabel("Select");

  int y = 100;
  
  // SearchSpecificYear/Mon/DayStart for the start date of the specific period being searched
  searchSpecificYearStart = new TextWidget(180, y + 365, 55, 25, yearStart, stdFont, SEARCH_SPECIFIC_YEAR_START, 4, 0, 0, 0, 0);
  searchSpecificYearStart.setLabelColor(200);
  searchSpecificMonStart = new TextWidget(235, y + 365, 35, 25, monthStart, stdFont, SEARCH_SPECIFIC_MON_START, 2, 0, 0, 0, 0);
  searchSpecificMonStart.setLabelColor(200);
  searchSpecificDayStart = new TextWidget(270, y + 365, 30, 25, dayStart, stdFont, SEARCH_SPECIFIC_DAY_START, 2, 0, 0, 0, 0);
  searchSpecificDayStart.setLabelColor(200);
  
  // SearchSpecificYear/Mon/DayEnd for the end date of the specific period being searched
  searchSpecificYearEnd = new TextWidget(180, y + 390, 55, 25, yearEnd, stdFont, SEARCH_SPECIFIC_YEAR_END, 4, 0, 0, 0, 10);
  searchSpecificYearEnd.setLabelColor(200);
  searchSpecificMonEnd = new TextWidget(235, y + 390, 35, 25, monthEnd, stdFont, SEARCH_SPECIFIC_MON_END, 2, 0, 0, 0, 0);
  searchSpecificMonEnd.setLabelColor(200);
  searchSpecificDayEnd = new TextWidget(270, y + 390, 30, 25, dayEnd, stdFont, SEARCH_SPECIFIC_DAY_END, 2, 0, 0, 10, 0);
  searchSpecificDayEnd.setLabelColor(200);
  
  // The barChart for choosing to show the bar chart
  barChart = new Widget(180, y + 25, 120, 25, BAR_CHART, 10, 10, 0, 0);
  barChart.setWidgetColor(color(200, 20, 200));
  barChart.setLabelColor(color(255));
  barChart.setLabel("Bar Chart");

  // The pointsChart for choosing to show the points chart
  pointsChart = new Widget(180, y + 50, 120, 25, POINTS_CHART, 0, 0, 10, 10);
  pointsChart.setWidgetColor(color(200, 20, 200));
  pointsChart.setLabelColor(color(255));
  pointsChart.setLabel("Points Chart");

  // Used for choosing to show volume vs time
  volumeVsTime = new Widget(180, y + 105, 120, 25, VOLUME_VS_TIME, 10, 10, 0, 0);
  volumeVsTime.setWidgetColor(color(200, 20, 200));
  volumeVsTime.setLabelColor(color(255));
  volumeVsTime.setLabel("Volume/Time");
  
  // Used for choosing to show opening price vs time
  openingVsTime = new Widget(180, y + 130, 120, 25, OPENING_VS_TIME, 0, 0, 0, 0);
  openingVsTime.setWidgetColor(color(200, 20, 200));
  openingVsTime.setLabelColor(color(255));
  openingVsTime.setLabel("Opening/Time");

  // Used for choosing to show closing price vs time
  closingVsTime = new Widget(180, y + 155, 120, 25, CLOSING_VS_TIME, 0, 0, 10, 10);
  closingVsTime.setWidgetColor(color(200, 20, 200));
  closingVsTime.setLabelColor(color(255));
  closingVsTime.setLabel("Closing/Time");

  // Used for choosing to show all time price
  allTime = new Widget(180, y + 215, 120, 25, ALL_TIME, 10, 10, 0, 0);
  allTime.setWidgetColor(color(200, 20, 200));
  allTime.setLabelColor(color(255));
  allTime.setLabel("All time");

  // Used for choosing to show five-year time price
  fiveYear = new Widget(180, y + 240, 120, 25, FIVE_YEAR, 0, 0, 0, 0);
  fiveYear.setWidgetColor(color(200, 20, 200));
  fiveYear.setLabelColor(color(255));
  fiveYear.setLabel("5 years");

  // Used for choosing to show two-year time price
  twoYear = new Widget(180, y + 265, 120, 25, TWO_YEAR, 0, 0, 0, 0);
  twoYear.setWidgetColor(color(200, 20, 200));
  twoYear.setLabelColor(color(255));
  twoYear.setLabel("2 years");

  // Used for choosing to show one-year time price
  oneYear = new Widget(180, y + 290, 120, 25, ONE_YEAR, 0, 0, 10, 10);
  oneYear.setWidgetColor(color(200, 20, 200));
  oneYear.setLabelColor(color(255));
  oneYear.setLabel("1 year");
  
  // Used for starting to show the chart
  selectChart2 = new Widget(180, y + 430, 120, 50, SELECT_CHART, 10, 10, 10, 10);
  selectChart2.setWidgetColor(color(200, 20, 200));
  selectChart2.setLabelColor(color(255));
  selectChart2.setLabel("Search");

  // Used for choosing a date range for the chart
  dateRange = new Widget(180, y+340, 120, 25, DATE_RANGE, 10, 10, 0, 0);
  dateRange.setWidgetColor(color(200, 20, 200));
  dateRange.setLabelColor(color(255));
  dateRange.setLabel("Date Range");

  //read file
  String lines[] = loadStrings("daily_prices10k.csv");

  dataList = new ArrayList<Datapoints>();
  resultList = new ArrayList<Datapoints>();
  stockList = new ArrayList<Stocks>();
  read_in_the_file(lines);
  read_in_stocks("stocks.csv");
  dateInRangeList = new ArrayList<Datapoints>();

  // Sorting the stockList
  stockList = bubbleSort(stockList);
  // Deleting stocks that don't have transactions
  stockList = deleteNoTransactionsStocks(stockList);
  // Offering a list of stocks for the user to click on and see the info about the designated stock
  searchList = new Widget[stockList.size()];
  for (int i = 0; i < 10; i++) {
    if (i == 0) {
      searchList[i] = new Widget(25, 100 + i * 75, 100, 75, SEARCH_LIST, 10, 5, 0, 0);
      searchList[i].setWidgetColor(color(255));
      searchList[i].setLabelColor(color(0));
      searchList[i].setLabel(stockList.get(i).ticker);
  } else if (i == 9) {
      searchList[i] = new Widget(25, 100 + i * 75, 100, 75, SEARCH_LIST, 0, 0, 5, 10);
      searchList[i].setWidgetColor(color(255));
      searchList[i].setLabelColor(color(0));
      searchList[i].setLabel(stockList.get(i).ticker);
  } else {
      searchList[i] = new Widget(25, 100 + i * 75, 100, 75, SEARCH_LIST, 0, 0, 0, 0);
      searchList[i].setWidgetColor(color(255));
      searchList[i].setLabelColor(color(0));
      searchList[i].setLabel(stockList.get(i).ticker);
    }
  }

  // The slider works as the slider,
  // 675 is the height of the slideWidget,
  // 10 is the number of the stocks shown on the list
  sliderHeight = 675 * 10 / stockList.size();
  slider = new Slider(125, 138, 38, sliderHeight, NULL, 10, 10, 10, 10);
  slider.setLabel("");
  
  // Adding widgets for the screen
  screen1 = new Screen(255);
  screen1.addWidget(searchWidget);
  screen1.addWidget(searchButton);
  screen1.addWidget(upArrowWidget);
  screen1.addWidget(downArrowWidget);
  screen1.addWidget(slideWidget);
  screen1.addWidget(slider);
  screen1.addWidget(searchSpecificYearStart);
  screen1.addWidget(searchSpecificMonStart);
  screen1.addWidget(searchSpecificDayStart);
  screen1.addWidget(searchSpecificYearEnd);
  screen1.addWidget(searchSpecificMonEnd);
  screen1.addWidget(searchSpecificDayEnd);
  screen1.addWidget(pointsChart);
  screen1.addWidget(barChart);
  screen1.addWidget(volumeVsTime);
  screen1.addWidget(openingVsTime);
  screen1.addWidget(closingVsTime);
  screen1.addWidget(allTime);
  screen1.addWidget(fiveYear);
  screen1.addWidget(twoYear);
  screen1.addWidget(oneYear);
  screen1.addWidget(selectChart2);
  screen1.addWidget(dateRange);
  for (int i = 0; i < 10; i++) {
    screen1.addWidget(searchList[i]);
  }
  
  // Setting screen1 as the current screen
  currentScreen = screen1;
} 

// Drawing the screen
void draw() {
  currentScreen.draw();
  // When the user selects the options about showing the graph, the highlight for the stock would will remain the same;
  // when the user clicks the two arrows or the slide widget, the highlight would disappear
  if (focus == UP_ARROW || focus == DOWN_ARROW || focus == SLIDE_WIDGET) {
    for (int i = 0; i < 10; i++) {
      searchList[i].setLabelColor(color(0));
      searchList[i].setWidgetColor(color(255));
    }
  }
}

// Activating the designated event when the mouse is pressed,
// and the focus would move to the event that is clicked
void mousePressed() {
  int event;
  for (int i = 0; i < currentScreen.Widgets.size(); i++) {
    Widget aWidget = (Widget) currentScreen.Widgets.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    switch(event) {

    case UP_ARROW:
      focus = UP_ARROW;
      if (searchListNo != 0) {
        for (int j = 9; j > 0; j--) {
          searchList[j].setLabel(searchList[j - 1].label);
        }
        searchList[0].setLabel(stockList.get(searchListNo - 1).ticker);
        searchListNo--;
        slider.setPositionY(slider.y - 675 * 1 / stockList.size()); // The slider will move as the user click the arrow
      } else {
        slider.setPositionY(138);
      }
      break;

    case DOWN_ARROW:
      focus = DOWN_ARROW;
      if (searchListNo != searchList.length - 10) {
        for (int j = 0; j < 9; j++) {
          searchList[j].setLabel(searchList[j + 1].label);
        }
        searchList[9].setLabel(stockList.get(searchListNo + 10).ticker);
        searchListNo++;
        slider.setPositionY(slider.y + 675 * 1 / stockList.size());
      } else {
        slider.setPositionY(805 - sliderHeight);
      }
      break;

    case SLIDE_WIDGET:
      focus = SLIDE_WIDGET;
      // 138 is the upper bound of the slideWidget
      if (mouseY < 138 + sliderHeight / 2) {
        slider.setPositionY(138);
        searchListNo = 0;
        for (int j = 0; j < 10; j++) {
          searchList[j].setLabel(stockList.get(searchListNo + j).ticker);
        }
      }
      // 800 is the lower bound of the slideWidget
      else if (mouseY > 805 - sliderHeight / 2) {
        slider.setPositionY(805 - sliderHeight);
        searchListNo = searchList.length-10;
        for (int j = 0; j < 10; j++) {
          searchList[j].setLabel(stockList.get(searchListNo + j).ticker);
        }
      } else {
        slider.setPositionY(mouseY - sliderHeight / 2);
        searchListNo = (int) ((float)(searchList.length - 10) / 
          ((float)(675 - sliderHeight) / (float)(mouseY - (138 + sliderHeight / 2))));
        for (int j = 0; j < 10; j++) {
          searchList[j].setLabel(stockList.get(searchListNo + j).ticker);
        }
      }
      break;
      
    case DATA_SLIDE_WIDGET:
      focus = DATA_SLIDE_WIDGET;
      //350 is the left most edge of the track for the data slider
      //750 is the right most edge for the track for the data slider
      if (mouseX < 450 + sliderWidth / 2) {
        dataSlider.setPositionX(450);
      } else if (mouseX > 750 - sliderWidth / 2) {
        dataSlider.setPositionX(850 - sliderWidth);
      } else {
        dataSlider.setPositionX(mouseX - sliderWidth / 2);
      }
      break;

    case SEARCH_WIDGET:
      focus = SEARCH_WIDGET;
      break;

    case SEARCH_BUTTON:
      focus = SEARCH_BUTTON;
      stockInfo(searchWidget.label);
      //Tim, changed from currentScreen to screen1 to help navigation of different
      //functions 02/04/20 11:22
      //Ruxin, added DateRange to store current searching result in dateInRangeList,
      //and clear it before use, 02/04, 9pm
      dateInRangeList.clear();
      DateRange(searchSpecificYear.label, searchSpecificMon.label, searchSpecificDay.label, 
        searchSpecificYear_1.label, searchSpecificMon_1.label, searchSpecificDay_1.label);
      searchOrListTicker = 1;
      //Ruxin, fixed the bug that there might be overlapping chart, 10pm, 15/04
      //createChartMenu();
      deletePreviousChart();
      
     currentScreen.Widgets.remove(backButton);
     currentScreen.Widgets.remove(forwardButton);
     currentScreen.Widgets.remove(dataSlideWidget);
     currentScreen.Widgets.remove(dataSlider);
     
     searchButton.setWidgetColor(color(255, 0, 255));
     for (int z = 0; z < 10; z++) {
        searchList[z].setWidgetColor(color(255));
      }
     //Ruxin, added code to clear previous info, 12pm, 22/04
     LargestChange=0;
     LchangeDate="";

      break;
      
      //start date
    case SEARCH_SPECIFIC_YEAR:
      focus = SEARCH_SPECIFIC_YEAR;
      break;
    case SEARCH_SPECIFIC_MON:
      focus = SEARCH_SPECIFIC_MON;
      break;
    case SEARCH_SPECIFIC_DAY:
      focus = SEARCH_SPECIFIC_DAY;
      break;

      //Ruxin, added 3 cases(end dates) for searching in a date range. 04/02, 9pm
    case SEARCH_SPECIFIC_YEAR_1:
      focus = SEARCH_SPECIFIC_YEAR_1;
      break;
    case SEARCH_SPECIFIC_MON_1:
      focus = SEARCH_SPECIFIC_MON_1;
      break;
    case SEARCH_SPECIFIC_DAY_1:
      focus = SEARCH_SPECIFIC_DAY_1;
      break;

      // Yifan Zhu, Added the SEARCH_LIST case so that the program would
      // react to the user's click on the list and show specific infomation
      // 12am, 23/3/2020
    case SEARCH_LIST:
    
    searchButton.setWidgetColor(color(200, 0, 200));
      focus = SEARCH_LIST;
      for (int j = 0; j < 10; j++) {
        searchList[j].setWidgetColor(color(255));
      }
      String label = "";
      // Yifan Zhu, Added the function that the element that is being clicked
      // by the user would be highlighted, 11pm, 04/04/2020
      if (mouseY > 100 + 0 * 75 && mouseY < 100 + 1 * 75) {
        label = searchList[0].label;
        // searchList[0].setLabelColor(color(255));
        searchList[0].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 1 * 75 && mouseY < 100 + 2 * 75) {
        label = searchList[1].label;
        // searchList[1].setLabelColor(color(255));
        searchList[1].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 2 * 75 && mouseY < 100 + 3 * 75) {
        label = searchList[2].label;
        // searchList[2].setLabelColor(color(255));
        searchList[2].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 3 * 75 && mouseY < 100 + 4 * 75) {
        label = searchList[3].label;
        // searchList[3].setLabelColor(color(255));
        searchList[3].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 4 * 75 && mouseY < 100 + 5 * 75) {
        label = searchList[4].label;
        //  searchList[4].setLabelColor(color(255));
        searchList[4].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 5 * 75 && mouseY < 100 + 6 * 75) {
        label = searchList[5].label;
        //  searchList[5].setLabelColor(color(255));
        searchList[5].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 6 * 75 && mouseY < 100 + 7 * 75) {
        label = searchList[6].label;
        //  searchList[6].setLabelColor(color(255));
        searchList[6].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 7 * 75 && mouseY < 100 + 8 * 75) {
        label = searchList[7].label;
        //  searchList[7].setLabelColor(color(255));
        searchList[7].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 8 * 75 && mouseY < 100 + 9 * 75) {
        label = searchList[8].label;
        // searchList[8].setLabelColor(color(255));
        searchList[8].setWidgetColor(color(255, 20, 255));
      } else if (mouseY > 100 + 9 * 75 && mouseY < 100 + 10 * 75) {
        label = searchList[9].label;
        //  searchList[9].setLabelColor(color(255));
        searchList[9].setWidgetColor(color(255, 20, 255));
      }
      listLabel = label;
      stockInfo(label);
      searchOrListTicker = 2;
      //Ruxin, changed the menu to a new one, 8pm, 16/04
      //createChartMenu();
      currentScreen.Widgets.remove(dataSlideWidget);
     currentScreen.Widgets.remove(dataSlider);
      deletePreviousChart();
      
      // Ruxin, added DateRange to store current searching result in dateInRangeList
      // set label for global use, and clear it,02/04, 9pm
      dateInRangeList.clear();
      currentLabel = label;
      DateRange(searchSpecificYear.label, searchSpecificMon.label, searchSpecificDay.label, 
        searchSpecificYear_1.label, searchSpecificMon_1.label, searchSpecificDay_1.label);
      //Tim, changed from currentScreen to screen1 to help navigation of different
      //functions 02/04/20 11:22
          //screen2.addWidget(createPointGraph(label));  

      currentScreen.Widgets.remove(backButton);
     currentScreen.Widgets.remove(forwardButton); 
     
     //currentScreen.Widgets.remove(dataSlideWidget);
     //currentScreen.Widgets.remove(dataSlider);
     //Ruxin, added code to clear previous info, 12pm, 22/04
     LargestChange=0;
     LchangeDate="";
     break;
     
     //case CHOOSE_CHART: 

     //  println("barchart Selected");

     //break;
     case BARCHART:
       focus = BARCHART;
       println("barchart Selected");
       barChartBool = true;
       barChart.setWidgetColor(color(255, 0, 255));
       pointsChartBool = false;
       pointsChart.setWidgetColor(color(200, 20, 200));  
       
     break;
     
     case POINTSCHART:
      focus = POINTSCHART;
       println("pointschart Selected");
      pointsChartBool = true;
      pointsChart.setWidgetColor(color(255, 0, 255));   
 
      barChartBool = false;
      barChart.setWidgetColor(color(200, 20, 200));
      
     break;
    
     case VOLUME_VS_TIME:
      println("volumevtime Selected");
      volumeVTimeBool = true;
      volumeVsTime.setWidgetColor(color(255, 0, 255));
      openingVTimeBool = false;
      openingVsTime.setWidgetColor(color(200, 20, 200));
      closingVTimeBool = false;
      closingVsTime.setWidgetColor(color(200, 20, 200));
      
      break;
     case OPENING_VS_TIME:
       println("openingvtime Selected");

      openingVTimeBool = true;
      openingVsTime.setWidgetColor(color(255, 0, 255));
       volumeVTimeBool = false;
      volumeVsTime.setWidgetColor(color(200, 20, 200));
      closingVTimeBool = false;
      closingVsTime.setWidgetColor(color(200, 20, 200));
      
     
     break;
     case CLOSING_VS_TIME:
 println("closingvtime Selected");
    closingVTimeBool = true;
      closingVsTime.setWidgetColor(color(255, 0, 255));
   openingVTimeBool = false;
      openingVsTime.setWidgetColor(color(200, 20, 200));
      volumeVTimeBool = false;
      volumeVsTime.setWidgetColor(color(200, 20, 200));
     
     
     break;
     
     case ALL_TIME:
     println("alltime Selected");
     
      allTimeBool = true;
      allTime.setWidgetColor(color(255, 0, 255));
      fiveYearBool = false;
      fiveYear.setWidgetColor(color(200, 20, 200));
      twoYearBool = false;
      twoYear.setWidgetColor(color(200, 20, 200));
      oneYearBool = false;
      oneYear.setWidgetColor(color(200, 20, 200));
      //println("select date Selected"); 
      //selectDateBool = true;
      //selectDate.setWidgetColor(color(255, 0, 255));
      dateRangeBool = false;
      dateRange.setWidgetColor(color(200, 20, 200));
      

   break; 
     
       case FIVE_YEAR:
      println("fiveYearSelected"); 
      fiveYearBool = true;
      fiveYear.setWidgetColor(color(255, 0, 255));
      allTimeBool = false;
      allTime.setWidgetColor(color(200, 20, 200));
      twoYearBool = false;
      twoYear.setWidgetColor(color(200, 20, 200));
      oneYearBool = false;
      oneYear.setWidgetColor(color(200, 20, 200));
      dateRangeBool = false;
      dateRange.setWidgetColor(color(200, 20, 200));
      
      //dateInRangeList.clear();
      //DateRange("2015","01","01","2020","12","31");
      
      break; 
     
       case TWO_YEAR:
      println("twoYearSelected"); 
      twoYearBool = true;
      twoYear.setWidgetColor(color(255, 0, 255));
       allTimeBool = false;
      allTime.setWidgetColor(color(200, 20, 200));
      fiveYearBool = false;
      fiveYear.setWidgetColor(color(200, 20, 200));
      oneYearBool = false;
      oneYear.setWidgetColor(color(200, 20, 200));
      dateRangeBool = false;
      dateRange.setWidgetColor(color(200, 20, 200));
      
      //dateInRangeList.clear();
      //DateRange("2018","01","01","2020","12","31");
      
      break; 
     
       case ONE_YEAR:
      println("oneYearSelected"); 
      oneYearBool = true;
      oneYear.setWidgetColor(color(255, 0, 255));
       allTimeBool = false;
      allTime.setWidgetColor(color(200, 20, 200));
      fiveYearBool = false;
      fiveYear.setWidgetColor(color(200, 20, 200));
      twoYearBool = false;
      twoYear.setWidgetColor(color(200, 20, 200));
      dateRangeBool = false;
      dateRange.setWidgetColor(color(200, 20, 200));
         
      //   dateInRangeList.clear();
      //DateRange("2019","01","01","2020","12","31");
      
    break; 
    //Ruxin, added new case for searching in a date range,11pm, 15/04
     case DATE_RANGE:
      focus = DATE_RANGE;
      println("daterange selected");
      dateRangeBool = true;
      dateRange.setWidgetColor(color(255,0,255));
      oneYearBool = false;
      oneYear.setWidgetColor(color(200, 0, 200));
      allTimeBool = false;
      allTime.setWidgetColor(color(200, 20, 200));
      fiveYearBool = false;
      fiveYear.setWidgetColor(color(200, 20, 200));
      twoYearBool = false;
      twoYear.setWidgetColor(color(200, 20, 200));
      
     break;
     
     //Ruxin, changed SELECT_CHART case so all buttons are integrated, 10pm, 15/04
     case SELECT_CHART:
     
      //println("\nSIZEBBBBBBB:"+currentScreen.Widgets.size());
     deletePreviousChart();
     //println("SIZEAAAAAAA:"+currentScreen.Widgets.size());
     currentScreen.Widgets.remove(backButton);
     currentScreen.Widgets.remove(forwardButton);
     //println("SIZEAAAAAAA:"+currentScreen.Widgets.size());println("");
      
     currentScreen.Widgets.remove(dataSlideWidget);
     currentScreen.Widgets.remove(dataSlider);
     
     
       focus = SELECT_CHART;
       //println("1size:"+dateInRangeList.size());
       
     if((barChartBool || pointsChartBool) && (volumeVTimeBool || openingVTimeBool || closingVTimeBool) && (allTimeBool || fiveYearBool || twoYearBool || oneYearBool || dateRangeBool)){
        //println("Step 1 complete");
         if(searchOrListTicker == 1){
         //print(searchOrListTicker + " ! search)");
         currentTicker = searchWidget.label;
       } else if(searchOrListTicker == 2){
          //print(searchOrListTicker + " ! search)");
          currentTicker = listLabel;
       }
     }
     
     //Ruxin, showed the information of stock in 5/2/1 year range, 22/04,4pm
       dateInRangeList.clear();
      if(allTimeBool){
         println("currentticker:"+currentTicker);
         for(Datapoints data:dataList){
           if(data.ticker.equals(currentTicker)){
             dateInRangeList.add(data);
           }
         }
         //println("2size:"+dateInRangeList.size()+"||datasize:"+dataList.size());//8888
      }else if(fiveYearBool){
        //println("fiveYearsPrevious:"+fiveYearsPrevious);
        String[] date5b = fiveYearsPrevious.split("-");String[] date5b_ = fiveYearsAfter.split("-");
        DateRange(date5b[0],date5b[1],date5b[2],date5b_[0],date5b_[1],date5b_[2]);
      }else if(twoYearBool){
        String[] date2b = twoYearsPrevious.split("-");String[] date2b_ = twoYearsAfter.split("-");
        DateRange(date2b[0],date2b[1],date2b[2],date2b_[0],date2b_[1],date2b_[2]);
      }else if(oneYearBool){
        String[] date1b = oneYearsPrevious.split("-");String[] date1b_ = oneYearsAfter.split("-");
        DateRange(date1b[0],date1b[1],date1b[2],date1b_[0],date1b_[1],date1b_[2]);
      }else{
          if((!isNumber(searchSpecificYear.label))||(!isNumber(searchSpecificMon.label))||(!isNumber(searchSpecificDay.label))
             ||(!isNumber(searchSpecificYear_1.label))||(!isNumber(searchSpecificMon_1.label))||(!isNumber(searchSpecificDay_1.label))){
            text("please enter a date range in the format:yyyy mm dd",725,365);
            //dateRangeBool = false;
          }else{
           DateRange(searchSpecificYear.label, searchSpecificMon.label, searchSpecificDay.label, 
           searchSpecificYear_1.label, searchSpecificMon_1.label, searchSpecificDay_1.label);
           //println("3size:"+dateInRangeList.size()+"||datasize:"+dataList.size());  
          }
     }
  
      stockLargestChange();
      
       selectChartBool = true;
       selectChart2.setWidgetColor(color(255, 0, 255));

       createChart(currentTicker);
     //ffff
     //println("currentTicker:"+currentTicker);
     //barChartBool = false;
     //pointsChartBool = false;
     //volumeVTimeBool = false;
     //openingVTimeBool = false;
     //closingVTimeBool = false;
     //allTimeBool = false;
     ////selectDateBool = false;
     //fiveYearBool = false;
     //twoYearBool = false;
     //oneYearBool = false;
     //dateRangeBool = false;
     //selectChartBool = false;
     
     

  break;
  //Ruxin, fixed the bug that slider doesn't change with the graph, 2am, 23/04
//Ruxin, changed dateInRangeList when choosing the 5/2/1 year,3pm, 22/04
     case BACK_BUTTON:
       //9999
       deletePreviousChart();
       currentScreen.Widgets.remove(dataSlider);
       if(barChartBool && volumeVTimeBool && fiveYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
       
           fiveYearsPrevious =  minusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = minusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeVolumeBarChart(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5b = fiveYearsPrevious.split("-");String[] date5b_ = fiveYearsAfter.split("-");
           DateRange(date5b[0],date5b[1],date5b[2],date5b_[0],date5b_[1],date5b_[2]);
           
       } else if(barChartBool && openingVTimeBool && fiveYearBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
        
           fiveYearsPrevious =  minusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = minusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeOpeningBarChart(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5b = fiveYearsPrevious.split("-");String[] date5b_ = fiveYearsAfter.split("-");
           DateRange(date5b[0],date5b[1],date5b[2],date5b_[0],date5b_[1],date5b_[2]);
     
       } else if(barChartBool && closingVTimeBool && fiveYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
        
           fiveYearsPrevious = minusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = minusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeClosingBarChart(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5b = fiveYearsPrevious.split("-");String[] date5b_ = fiveYearsAfter.split("-");
           DateRange(date5b[0],date5b[1],date5b[2],date5b_[0],date5b_[1],date5b_[2]);
           
       } else if(pointsChartBool && volumeVTimeBool && fiveYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
       
           fiveYearsPrevious =  minusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = minusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeVolumePointGraph(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5b = fiveYearsPrevious.split("-");String[] date5b_ = fiveYearsAfter.split("-");
           DateRange(date5b[0],date5b[1],date5b[2],date5b_[0],date5b_[1],date5b_[2]);
           
       } else if(pointsChartBool && openingVTimeBool && fiveYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
        
           fiveYearsPrevious =  minusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = minusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeOpeningPointGraph(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5b = fiveYearsPrevious.split("-");String[] date5b_ = fiveYearsAfter.split("-");
           DateRange(date5b[0],date5b[1],date5b[2],date5b_[0],date5b_[1],date5b_[2]);
     
       } else if(pointsChartBool && closingVTimeBool && fiveYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
        
           fiveYearsPrevious = minusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = minusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeClosingPointGraph(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5b = fiveYearsPrevious.split("-");String[] date5b_ = fiveYearsAfter.split("-");
           DateRange(date5b[0],date5b[1],date5b[2],date5b_[0],date5b_[1],date5b_[2]);
           
       } else if(barChartBool && volumeVTimeBool && twoYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
    
           twoYearsPrevious =  minusTwoYears( twoYearsPrevious);
           twoYearsAfter = minusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeVolumeBarChart(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2b = twoYearsPrevious.split("-");String[] date2b_ = twoYearsAfter.split("-");
           DateRange(date2b[0],date2b[1],date2b[2],date2b_[0],date2b_[1],date2b_[2]);
           
       } else if(barChartBool && openingVTimeBool && twoYearBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
        
           twoYearsPrevious =  minusTwoYears( twoYearsPrevious);
           twoYearsAfter = minusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeOpeningBarChart(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2b = twoYearsPrevious.split("-");String[] date2b_ = twoYearsAfter.split("-");
           DateRange(date2b[0],date2b[1],date2b[2],date2b_[0],date2b_[1],date2b_[2]);
     
       } else if(barChartBool && closingVTimeBool && twoYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
        
           twoYearsPrevious = minusTwoYears( twoYearsPrevious);
           twoYearsAfter = minusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeClosingBarChart(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2b = twoYearsPrevious.split("-");String[] date2b_ = twoYearsAfter.split("-");
           DateRange(date2b[0],date2b[1],date2b[2],date2b_[0],date2b_[1],date2b_[2]);
    
       } else if(pointsChartBool && volumeVTimeBool && twoYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
    
           twoYearsPrevious =  minusTwoYears( twoYearsPrevious);
           twoYearsAfter = minusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeVolumePointGraph(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2b = twoYearsPrevious.split("-");String[] date2b_ = twoYearsAfter.split("-");
           DateRange(date2b[0],date2b[1],date2b[2],date2b_[0],date2b_[1],date2b_[2]);
    
           
       } else if(pointsChartBool && openingVTimeBool && twoYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
        
           twoYearsPrevious =  minusTwoYears( twoYearsPrevious);
           twoYearsAfter = minusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeOpeningPointGraph(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2b = twoYearsPrevious.split("-");String[] date2b_ = twoYearsAfter.split("-");
           DateRange(date2b[0],date2b[1],date2b[2],date2b_[0],date2b_[1],date2b_[2]);
     
       } else if(pointsChartBool && closingVTimeBool && twoYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
        
           twoYearsPrevious = minusTwoYears( twoYearsPrevious);
           twoYearsAfter = minusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeClosingPointGraph(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2b = twoYearsPrevious.split("-");String[] date2b_ = twoYearsAfter.split("-");
           DateRange(date2b[0],date2b[1],date2b[2],date2b_[0],date2b_[1],date2b_[2]);
    
       }else if(barChartBool && volumeVTimeBool && oneYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
       
           oneYearsPrevious =  minusOneYears( oneYearsPrevious);
           oneYearsAfter = minusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeVolumeBarChart(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1b = oneYearsPrevious.split("-");String[] date1b_ = oneYearsAfter.split("-");
           DateRange(date1b[0],date1b[1],date1b[2],date1b_[0],date1b_[1],date1b_[2]);
           
       } else if(barChartBool && openingVTimeBool && oneYearBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
        
           oneYearsPrevious =  minusOneYears( oneYearsPrevious);
           oneYearsAfter = minusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeOpeningBarChart(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1b = oneYearsPrevious.split("-");String[] date1b_ = oneYearsAfter.split("-");
           DateRange(date1b[0],date1b[1],date1b[2],date1b_[0],date1b_[1],date1b_[2]);
     
       } else if(barChartBool && closingVTimeBool && oneYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
        
           oneYearsPrevious = minusOneYears( oneYearsPrevious);
           oneYearsAfter = minusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeClosingBarChart(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1b = oneYearsPrevious.split("-");String[] date1b_ = oneYearsAfter.split("-");
           DateRange(date1b[0],date1b[1],date1b[2],date1b_[0],date1b_[1],date1b_[2]);
    
       } else if(pointsChartBool && volumeVTimeBool && oneYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
       
           oneYearsPrevious =  minusOneYears( oneYearsPrevious);
           oneYearsAfter = minusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeVolumePointGraph(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1b = oneYearsPrevious.split("-");String[] date1b_ = oneYearsAfter.split("-");
           DateRange(date1b[0],date1b[1],date1b[2],date1b_[0],date1b_[1],date1b_[2]);
    
           
       } else if(pointsChartBool && openingVTimeBool && oneYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
        
           oneYearsPrevious =  minusOneYears( oneYearsPrevious);
           oneYearsAfter = minusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeOpeningPointGraph(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1b = oneYearsPrevious.split("-");String[] date1b_ = oneYearsAfter.split("-");
           DateRange(date1b[0],date1b[1],date1b[2],date1b_[0],date1b_[1],date1b_[2]);
      
     
       } else if(pointsChartBool && closingVTimeBool && oneYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
        
           oneYearsPrevious = minusOneYears( oneYearsPrevious);
           oneYearsAfter = minusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeClosingPointGraph(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1b = oneYearsPrevious.split("-");String[] date1b_ = oneYearsAfter.split("-");
           DateRange(date1b[0],date1b[1],date1b[2],date1b_[0],date1b_[1],date1b_[2]);
       }
       currentScreen.addWidget(dataSlider);
       stockLargestChange();
       dateInRangeList.clear();
     break;
     //Ruxin, changed dateInRangeList when choosing the 5/2/1 year,3pm, 22/04
     case FORWARD_BUTTON:
       deletePreviousChart();
       currentScreen.Widgets.remove(dataSlider);
       if(barChartBool && volumeVTimeBool && fiveYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool&& !dateRangeBool){
         fiveYearsPrevious =  plusFiveYears( fiveYearsPrevious);
         fiveYearsAfter = plusFiveYears( fiveYearsAfter);
         currentScreen.addWidget(fiveYearRangeVolumeBarChart(currentTicker, fiveYearsPrevious, fiveYearsAfter));
         String[] date5 = fiveYearsPrevious.split("-");String[] date5_ = fiveYearsAfter.split("-");
         DateRange(date5[0],date5[1],date5[2],date5_[0],date5_[1],date5_[2]);
      
       } else if(barChartBool && openingVTimeBool && fiveYearBool  && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool&& !dateRangeBool){
        
           fiveYearsPrevious =  plusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = plusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeOpeningBarChart(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5 = fiveYearsPrevious.split("-");String[] date5_ = fiveYearsAfter.split("-");
           DateRange(date5[0],date5[1],date5[2],date5_[0],date5_[1],date5_[2]);
     
       } else if(barChartBool && closingVTimeBool && fiveYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !twoYearBool && !oneYearBool&& !dateRangeBool){
        
           fiveYearsPrevious = plusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = plusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeClosingBarChart(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5 = fiveYearsPrevious.split("-");String[] date5_ = fiveYearsAfter.split("-");
           DateRange(date5[0],date5[1],date5[2],date5_[0],date5_[1],date5_[2]);
           
       } else if(pointsChartBool && volumeVTimeBool && fiveYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool&& !dateRangeBool){
         fiveYearsPrevious =  plusFiveYears( fiveYearsPrevious);
         fiveYearsAfter = plusFiveYears( fiveYearsAfter);
         currentScreen.addWidget(fiveYearRangeVolumePointGraph(currentTicker, fiveYearsPrevious, fiveYearsAfter));
         String[] date5 = fiveYearsPrevious.split("-");String[] date5_ = fiveYearsAfter.split("-");
           DateRange(date5[0],date5[1],date5[2],date5_[0],date5_[1],date5_[2]);
      
       } else if(pointsChartBool && openingVTimeBool && fiveYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !twoYearBool && !oneYearBool&& !dateRangeBool){
        
           fiveYearsPrevious =  plusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = plusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeOpeningPointGraph(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5 = fiveYearsPrevious.split("-");String[] date5_ = fiveYearsAfter.split("-");
           DateRange(date5[0],date5[1],date5[2],date5_[0],date5_[1],date5_[2]);
         
     
       } else if(pointsChartBool && closingVTimeBool && fiveYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !twoYearBool && !oneYearBool&& !dateRangeBool){
        
           fiveYearsPrevious = plusFiveYears( fiveYearsPrevious);
           fiveYearsAfter = plusFiveYears( fiveYearsAfter);
           currentScreen.addWidget(fiveYearRangeClosingPointGraph(currentTicker, fiveYearsPrevious, fiveYearsAfter));
           String[] date5 = fiveYearsPrevious.split("-");String[] date5_ = fiveYearsAfter.split("-");
           DateRange(date5[0],date5[1],date5[2],date5_[0],date5_[1],date5_[2]);
         
           
       } else if(barChartBool && volumeVTimeBool && twoYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool  && !fiveYearBool && !oneYearBool&& !dateRangeBool){
         
           twoYearsPrevious =  plusTwoYears( twoYearsPrevious);
           twoYearsAfter = plusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeVolumeBarChart(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2 = twoYearsPrevious.split("-");String[] date2_ = twoYearsAfter.split("-");           
           DateRange(date2[0],date2[1],date2[2],date2_[0],date2_[1],date2_[2]);
      
       } else if(barChartBool && openingVTimeBool && twoYearBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !oneYearBool&& !dateRangeBool){
        
           twoYearsPrevious =  plusTwoYears( twoYearsPrevious);
           twoYearsAfter = plusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeOpeningBarChart(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2 = twoYearsPrevious.split("-");String[] date2_ = twoYearsAfter.split("-");           
           DateRange(date2[0],date2[1],date2[2],date2_[0],date2_[1],date2_[2]);
     
       } else if(barChartBool && closingVTimeBool && twoYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !oneYearBool&& !dateRangeBool){
        
           twoYearsPrevious = plusTwoYears( twoYearsPrevious);
           twoYearsAfter = plusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeClosingBarChart(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2 = twoYearsPrevious.split("-");String[] date2_ = twoYearsAfter.split("-");           
           DateRange(date2[0],date2[1],date2[2],date2_[0],date2_[1],date2_[2]);
        
       }  else if(pointsChartBool && volumeVTimeBool && twoYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool  && !fiveYearBool && !oneYearBool&& !dateRangeBool){
         
           twoYearsPrevious =  plusTwoYears( twoYearsPrevious);
           twoYearsAfter = plusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeVolumePointGraph(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2 = twoYearsPrevious.split("-");String[] date2_ = twoYearsAfter.split("-");           
           DateRange(date2[0],date2[1],date2[2],date2_[0],date2_[1],date2_[2]);
      
       } else if(pointsChartBool && openingVTimeBool && twoYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !oneYearBool&& !dateRangeBool){
        
           twoYearsPrevious =  plusTwoYears( twoYearsPrevious);
           twoYearsAfter = plusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeOpeningPointGraph(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2 = twoYearsPrevious.split("-");String[] date2_ = twoYearsAfter.split("-");           
           DateRange(date2[0],date2[1],date2[2],date2_[0],date2_[1],date2_[2]);
     
       } else if(pointsChartBool && closingVTimeBool && twoYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !oneYearBool&& !dateRangeBool){
        
           twoYearsPrevious = plusTwoYears( twoYearsPrevious);
           twoYearsAfter = plusTwoYears( twoYearsAfter);
           currentScreen.addWidget(twoYearRangeClosingPointGraph(currentTicker, twoYearsPrevious, twoYearsAfter));
           String[] date2 = twoYearsPrevious.split("-");String[] date2_ = twoYearsAfter.split("-");           
           DateRange(date2[0],date2[1],date2[2],date2_[0],date2_[1],date2_[2]);
        
       } else if(barChartBool && volumeVTimeBool && oneYearBool  && !pointsChartBool && !openingVTimeBool && !closingVTimeBool  && !fiveYearBool && !twoYearBool&& !dateRangeBool){
         
           oneYearsPrevious =  plusOneYears( oneYearsPrevious);
           oneYearsAfter = plusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeVolumeBarChart(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1 = twoYearsPrevious.split("-");String[] date1_ = twoYearsAfter.split("-");           
           DateRange(date1[0],date1[1],date1[2],date1_[0],date1_[1],date1_[2]);
      
       } else if(barChartBool && openingVTimeBool && oneYearBool  && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !twoYearBool&& !dateRangeBool){
        
           oneYearsPrevious =  plusOneYears( oneYearsPrevious);
           oneYearsAfter = plusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeOpeningBarChart(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1 = oneYearsPrevious.split("-");String[] date1_ = oneYearsAfter.split("-");           
           DateRange(date1[0],date1[1],date1[2],date1_[0],date1_[1],date1_[2]);
     
       } else if(barChartBool && closingVTimeBool && oneYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !twoYearBool&& !dateRangeBool){
        
           oneYearsPrevious = plusOneYears( oneYearsPrevious);
           oneYearsAfter = plusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeClosingBarChart(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1 = oneYearsPrevious.split("-");String[] date1_ = oneYearsAfter.split("-");           
           DateRange(date1[0],date1[1],date1[2],date1_[0],date1_[1],date1_[2]);
        
       } else if(pointsChartBool && volumeVTimeBool && oneYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool  && !fiveYearBool && !twoYearBool&& !dateRangeBool){
         
           oneYearsPrevious =  plusOneYears( oneYearsPrevious);
           oneYearsAfter = plusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeVolumePointGraph(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1 = oneYearsPrevious.split("-");String[] date1_ = oneYearsAfter.split("-");           
           DateRange(date1[0],date1[1],date1[2],date1_[0],date1_[1],date1_[2]);
      
       } else if(pointsChartBool && openingVTimeBool && oneYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !fiveYearBool && !twoYearBool&& !dateRangeBool){
        
           oneYearsPrevious =  plusOneYears( oneYearsPrevious);
           oneYearsAfter = plusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeOpeningPointGraph(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1 = oneYearsPrevious.split("-");String[] date1_ = oneYearsAfter.split("-");           
           DateRange(date1[0],date1[1],date1[2],date1_[0],date1_[1],date1_[2]);
       
     
       } else if(pointsChartBool && closingVTimeBool && oneYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !fiveYearBool && !twoYearBool&& !dateRangeBool){
        
           oneYearsPrevious = plusOneYears( oneYearsPrevious);
           oneYearsAfter = plusOneYears( oneYearsAfter);
           currentScreen.addWidget(oneYearRangeClosingPointGraph(currentTicker, oneYearsPrevious, oneYearsAfter));
           String[] date1 = oneYearsPrevious.split("-");String[] date1_ = oneYearsAfter.split("-");           
           DateRange(date1[0],date1[1],date1[2],date1_[0],date1_[1],date1_[2]);
        
       }
     currentScreen.addWidget(dataSlider);
     stockLargestChange();
     dateInRangeList.clear();
     break;
     
    case EVENT_NULL:
      focus = EVENT_NULL;
      break;
    }
    if (focus != EVENT_NULL) {
      break;
    }
  }

  //println(focus);
}

// Yifan Zhu, Added mouseDragged method for dragging the slider,
// 10pm, 30/3/2020
void mouseDragged() {
  if (focus == EVENT_SLIDEWIDGET) {
    // 138 is the upper bound of the slideWidget
    if (mouseY < 138 + sliderHeight / 2) {
      slider.setPositionY(138);
      searchListNo = 0;
      for (int j = 0; j < 10; j++) {
        searchList[j].setLabel(stockList.get(searchListNo + j).ticker);
      }
    }
    // 800 is the lower bound of the slideWidget
    else if (mouseY > 813 - sliderHeight / 2) {
      slider.setPositionY(813 - sliderHeight);
      searchListNo = searchList.length-10;
      for (int j = 0; j < 10; j++) {
        searchList[j].setLabel(stockList.get(searchListNo + j).ticker);
      }
    } else {
      slider.setPositionY(mouseY - sliderHeight / 2);
      searchListNo = (int) ((float)(searchList.length-10) / 
        ((float)(675 - sliderHeight) / (float)(mouseY - (138 + sliderHeight / 2))));
      for (int j = 0; j < 10; j++) {
        searchList[j].setLabel(stockList.get(searchListNo + j).ticker);
      }
    }
  }
//Tim added the the ability to drag the data slider along the dataSlideWidget track
//350 is the left most edge of the track for the data slider
//750 is the right most edge for the track for the data slider, 18/04/2020
  if (focus == EVENT_DATASLIDEWIDGET) {
    if (mouseX<450+sliderWidth/2) {
      dataSlider.setPositionX(450);
    } else if (mouseX>850-sliderWidth/2) {
      dataSlider.setPositionX(850 - sliderWidth);
    } else {
      dataSlider.setPositionX(mouseX-sliderWidth/2);
    }
  }
}

// Yifan Zhu, Added keyPressed method for entering texts, 4pm, 17/3/2020
//Ruxin, clear the resultList when a new search starts, 1am, 19/3
//Ruxin, added cases where user are searching for specific year/month/day, 25/3
//Ruxin, added cases for the searhing end dates, 02/04, 9pm
void keyPressed() {
  if (focus == SEARCH_WIDGET && searchWidget != null) {
    // Yifan Zhu, Added the function that the font of the
    // label of the searchWidget depends on the status
    // of the input, 11pm, 05/04/2020
    if (searchWidget.label.equals("Type...")) {
      searchWidget.label = "";
    }
    searchWidget.append(key);
    if (!searchWidget.label.equals("Type...")) {
      searchWidget.setLabelColor(0);
    }
    if (searchWidget.label.equals("")) {
      searchWidget.label = "Type...";
      searchWidget.setLabelColor(200);
    }
    //resultList.clear();
    //currentScreen.resultNo=0;
    resultStock = null;
    //Ruxin, editted the textbox for defult input, 10pm,12/04
  } else if (focus == SEARCH_SPECIFIC_YEAR && searchSpecificYear != null) {
    if (searchSpecificYear.label.equals("yyyy")) {
      searchSpecificYear.label = "";
    }
    if( (key <= '9' && key >= '0') || key == 8){
    searchSpecificYear.append(key);
    }
    if (!searchSpecificYear.label.equals("yyyy")) {
      searchSpecificYear.setLabelColor(0);
    }
    if (searchSpecificYear.label.equals("")) {
      searchSpecificYear.label = "yyyy";
      searchSpecificYear.setLabelColor(200);
    }
  } else if (focus == SEARCH_SPECIFIC_MON && searchSpecificMon != null) {
    if (searchSpecificMon.label.equals("mm")) {
      searchSpecificMon.label = "";
    }
    if( (key <= '9' && key >= '0') || key == 8){
    searchSpecificMon.append(key);
    }
    if (!searchSpecificMon.label.equals("mm")) {
      searchSpecificMon.setLabelColor(0);
    }
    if (searchSpecificMon.label.equals("")) {
      searchSpecificMon.label = "mm";
      searchSpecificMon.setLabelColor(200);
    }
  } else if (focus == SEARCH_SPECIFIC_DAY && searchSpecificDay != null) {
    if (searchSpecificDay.label.equals("dd")) {
      searchSpecificDay.label = "";
    }
    if( (key <= '9' && key >= '0') || key == 8){
    searchSpecificDay.append(key);
    }
    if (!searchSpecificDay.label.equals("dd")) {
      searchSpecificDay.setLabelColor(0);
    }
    if (searchSpecificDay.label.equals("")) {
      searchSpecificDay.label = "dd";
      searchSpecificDay.setLabelColor(200);
    }
  } else if (focus == SEARCH_SPECIFIC_YEAR_1 && searchSpecificYear_1 != null) {
    if (searchSpecificYear_1.label.equals("yyyy")) {
      searchSpecificYear_1.label = "";
    }
    if( (key <= '9' && key >= '0') || key == 8){
    searchSpecificYear_1.append(key);
    }
    if (!searchSpecificYear_1.label.equals("yyyy")) {
      searchSpecificYear_1.setLabelColor(0);
    }
    if (searchSpecificYear_1.label.equals("")) {
      searchSpecificYear_1.label = "yyyy";
      searchSpecificYear_1.setLabelColor(200);
    }
  } else if (focus == SEARCH_SPECIFIC_MON_1 && searchSpecificMon_1 != null) {
    if (searchSpecificMon_1.label.equals("mm")) {
      searchSpecificMon_1.label = "";
    }
    if( (key <= '9' && key >= '0') || key == 8){
    searchSpecificMon_1.append(key);
    }
    if (!searchSpecificMon_1.label.equals("mm")) {
      searchSpecificMon_1.setLabelColor(0);
    }
    if (searchSpecificMon_1.label.equals("")) {
      searchSpecificMon_1.label = "mm";
      searchSpecificMon_1.setLabelColor(200);
    }
  } else if (focus == SEARCH_SPECIFIC_DAY_1 && searchSpecificDay_1 != null) {
    if (searchSpecificDay_1.label.equals("dd")) {
      searchSpecificDay_1.label = "";
    }
    if( (key <= '9' && key >= '0') || key == 8){
    searchSpecificDay_1.append(key);
    }
    if (!searchSpecificDay_1.label.equals("dd")) {
      searchSpecificDay_1.setLabelColor(0);
    }
    if (searchSpecificDay_1.label.equals("")) {
      searchSpecificDay_1.label = "dd";
      searchSpecificDay_1.setLabelColor(200);
    }
  }
}

boolean isNumber(String str){
    String reg = "^[0-9]+(.[0-9]+)?$";
    return str.matches(reg);
}

// Reading stock info
void read_in_the_file(String[] lines) {
  String tokens[] = new String[8];
  tokens = split(lines[0], ',');
  int i;
  if (!isNumber(tokens[1])) {
    i = 1;
  } else {
    i = 0;
  }
  for (int j = i; j < lines.length; j++) {
    tokens = split(lines[j], ','); 
    data = new Datapoints(tokens);
    dataList.add(data);
  }
}

// Reading company info
void read_in_stocks(String label) {
  Table table = loadTable(label, "header");
  
  for (TableRow row : table.rows()) {
    Stocks stock = new Stocks();
    stock.ticker(row.getString("ticker"));
    stock.exchange(row.getString("exchange"));
    stock.name(row.getString("name"));
    stock.sector(row.getString("sector"));
    stock.industry(row.getString("industry"));
    stockList.add(stock);
  }
}

// Connecting the search bar with the bar charts, stock compane information, etc.
void stockInfo(String label) {
  for (Stocks stock : stockList) {
    if (stock.ticker.equals(label)) {
      resultStock = stock;
    }
  }
  resultList.clear();
  for (Datapoints data : dataList) {
    if (data.ticker.equals(label)) {
      resultList.add(data);
    }
  }
}

//Ruxin, added stockLargestChange method for searhing largest change on one day/month/year, 25/03, 11pm
//Ruxin, simplified the method and changed it for searhing in a date range, 02/04, 10pm
void stockLargestChange() {
  LargestChange = 0;LchangeDate="";
  for (Datapoints data : dateInRangeList) {
    float temp = (float)data.Lchange;
    float temp1 = (float)LargestChange;
    if ( abs(temp) > abs(temp1) ) {
      LargestChange = data.Lchange;
      LchangeDate = data.sDate;
    }
  }
}

//Ruxin, added DateRange method which adds the searhing results in dateInRangeList, 01/04, 11pm
//Ruxin, fixed the bug that dateInRangeList use the same pointer address with dataList, 15/04, 10pm
void DateRange(String year, String month, String day, String year1, String month1, String day1) {
  ////tttt
  //while(dateRangeBool == true && ((year.equals(""))||(month.equals(""))||(day.equals(""))||(year1.equals(""))||(month1.equals(""))||(day1.equals("")))){
  //  text("please enter a date range in the format:yyyy mm dd",525,365);
  //  if((!year.equals(""))&&(!month.equals(""))&&(!day.equals(""))&&(!year1.equals(""))&&(!month1.equals(""))&&(!day1.equals(""))){
  //    break;
  //  }
  //  if(focus != DATE_RANGE){
  //    break;
  //  }
  //}
  if ((!year.equals("")) && (month.equals("")) && (day.equals(""))) {
    for(Datapoints data:dataList){
       dateInRangeList.add(data);
    }
  } else if ((!year.equals("")) && (month.equals("")) && (day.equals(""))) {
    for (int i = 0; i <resultList.size(); i++) {
      Datapoints data = resultList.get(i);
      int temp = int(resultList.get(i).sDate.substring(0, 4));
      if (temp >= int(year) && temp <= int(year1)) {
        dateInRangeList.add(data);//println("first if add, size "+dateInRangeList.size());
      }
    }
  } else if ((!year.equals("")) && (!month.equals("")) && (day.equals("")) ) {
    int begin = int(year+month);
    int end = int(year1+month1);
    for (int i = 0; i <resultList.size(); i++) {
      Datapoints data = resultList.get(i);
      int temp = int(resultList.get(i).sDate.substring(0, 7).replace("-", ""));
      if ((temp >= begin) && (temp <= end)) {
        dateInRangeList.add(data);//println("second if add, size "+dateInRangeList.size());
      }
    }
  } else { 
    int begin = int(year+month+day);
    int end = int(year1+month1+day1);
    for (int i = 0; i <resultList.size(); i++) {
      Datapoints data = resultList.get(i);
      int temp = int(resultList.get(i).sDate.replace("-", ""));
      if ((temp >= begin) && (temp <= end)) {
        dateInRangeList.add(data);//println("third if add, size "+dateInRangeList.size());
      }
    }
  }
  //println("dateInRangeList.size: "+dateInRangeList.size());
}



String minusFiveYears(String dateToBeChanged){
  
  String[] date = dateToBeChanged.split("-");
  int year = Integer.parseInt(date[0]);
  year -= 5;
  //println("a" + year);
  return year + "-" + date[1] + "-" + date[2];
}

String plusFiveYears(String dateToBeChanged){
  
  String[] date = dateToBeChanged.split("-");
  int year = Integer.parseInt(date[0]);
  year += 5;
  return year + "-" + date[1] + "-" + date[2];
}

String minusTwoYears(String dateToBeChanged){
  
  String[] date = dateToBeChanged.split("-");
  int year = Integer.parseInt(date[0]);
  year -= 2;
  //println("a" + year);
  return year + "-" + date[1] + "-" + date[2];
}

String plusTwoYears(String dateToBeChanged){
  
  String[] date = dateToBeChanged.split("-");
  int year = Integer.parseInt(date[0]);
  year += 2;
  return year + "-" + date[1] + "-" + date[2];
}

String minusOneYears(String dateToBeChanged){
  
  String[] date = dateToBeChanged.split("-");
  int year = Integer.parseInt(date[0]);
  year -= 1;
  //println("a" + year);
  return year + "-" + date[1] + "-" + date[2];
}

String plusOneYears(String dateToBeChanged){
  
  String[] date = dateToBeChanged.split("-");
  int year = Integer.parseInt(date[0]);
  year += 1;
  return year + "-" + date[1] + "-" + date[2];
}


//Matteo added a barchart method and a VolumeBarchart Class 
//The barchart represents the volume over the entire existence(time) of the stock.
// Matteo changed back to volumebarChart
Widget createVolumeBarChart(String ticker) {
  println("Vol chart of " +  ticker);
  int currentVolume = 0;
  ArrayList <Datapoints> volumeDate = new ArrayList();
  // Ruxin, changed the for loop from showing all result to showing the result in
  // the searhed date range, 01/04, 11pm
  for (int i = 0; i < dateInRangeList.size(); i++) {
    if (ticker.equals(dateInRangeList.get(i).ticker())) {
      volumeDate.add(dateInRangeList.get(i)); 
      int newVolume = dateInRangeList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  sliderWidth = 400 * 45 / volumeDate.size();
  Collections.sort(volumeDate);
  return new VolumeBarChart(volumeDate, currentVolume, sliderWidth, 0, false);
  }
     
Widget fiveYearRangeVolumeBarChart(String ticker, String fiveYearsPrevious, String fiveYearsAfter){
  int deleteIndex = -1;
  int currentVolume = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof VolumeBarChart) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> fiveYearVolumeDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(fiveYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(fiveYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       fiveYearVolumeDate.add(dataList.get(i));  
      int newVolume = dataList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  }
  
  
  Collections.sort(fiveYearVolumeDate);
  
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
   if(fiveYearVolumeDate.size()<45){
     if(fiveYearVolumeDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / fiveYearVolumeDate.size();
  }
  
  return new VolumeBarChart(fiveYearVolumeDate, currentVolume,sliderWidth, 5, noDataToDisplay); 
}

     
Widget twoYearRangeVolumeBarChart(String ticker, String twoYearsPrevious, String twoYearsAfter){
  int deleteIndex = -1;
  int currentVolume = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
     for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if( currentScreen.Widgets.get(index) instanceof VolumeBarChart){     
      deleteIndex = index;
    }
     }
     
     if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
    
  ArrayList <Datapoints> twoYearVolumeDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(twoYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(twoYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       twoYearVolumeDate.add(dataList.get(i));  
      int newVolume = dataList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  }
  
  
  Collections.sort(twoYearVolumeDate);
  
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
   if(twoYearVolumeDate.size() <45){
     if(twoYearVolumeDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else{
     sliderWidth =  400 * 45 / twoYearVolumeDate.size();
  }
  
  return new VolumeBarChart(twoYearVolumeDate, currentVolume,sliderWidth, 2, noDataToDisplay); 
}


     
Widget oneYearRangeVolumeBarChart(String ticker, String oneYearsPrevious, String oneYearsAfter){
  int deleteIndex = -1;
  int currentVolume = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof VolumeBarChart) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> oneYearVolumeDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(oneYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(oneYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       oneYearVolumeDate.add(dataList.get(i));  
      int newVolume = dataList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  }
  
  
  Collections.sort(oneYearVolumeDate);
  
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
    if(oneYearVolumeDate.size() <45){
     if(oneYearVolumeDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else{
     sliderWidth =  400 * 45 / oneYearVolumeDate.size();
  }
  return new VolumeBarChart(oneYearVolumeDate, currentVolume,sliderWidth,  1, noDataToDisplay); 
}
//Added by Matteo 01/04/20 a barchart method and a OpeningPriceBarchart Class 
//The barchart represents the OpeningPrice over the entire existence(time) of the stock.
Widget createOpeningBarChart(String ticker) {

  double currentOpening = 0;
     
  ArrayList <Datapoints> openingDate = new ArrayList();

  //Ruxin, changed the for loop from showing all result to showing the result in
  // the searched date range, 09/04, 3pm
  for (int i = 0; i < dateInRangeList.size(); i++) {
    if (ticker.equals(dateInRangeList.get(i).ticker())) {
      openingDate.add(dateInRangeList.get(i)); 
      double newOpeningPrice = dateInRangeList.get(i).open_price();
      if (newOpeningPrice > currentOpening) {
        currentOpening = newOpeningPrice;
      }
    }
  }
  sliderWidth = 400 * 45 / openingDate.size();
  Collections.sort(openingDate);
  return new OpeningPriceBarChart(openingDate, currentOpening, sliderWidth,  0, false);}

Widget fiveYearRangeOpeningBarChart(String ticker, String fiveYearsPrevious, String fiveYearsAfter){
  int deleteIndex = -1;
  double currentOpening = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
  if(currentScreen.Widgets.get(index) instanceof OpeningPriceBarChart){     
    deleteIndex = index;
    }
}

 if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
    
  ArrayList <Datapoints> fiveYearOpeningDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(fiveYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(fiveYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       fiveYearOpeningDate.add(dataList.get(i));  
      double newOpening = dataList.get(i).open_price();
      if (newOpening > currentOpening) {
        currentOpening = newOpening;
      }
    }
  }
  }
  
  
  Collections.sort(fiveYearOpeningDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
   if(fiveYearOpeningDate.size() <45){
     if(fiveYearOpeningDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else{
     sliderWidth =  400 * 45 / fiveYearOpeningDate.size();
  }
  
  return new OpeningPriceBarChart(fiveYearOpeningDate, currentOpening,sliderWidth,  5, noDataToDisplay); 
}


Widget twoYearRangeOpeningBarChart(String ticker, String twoYearsPrevious, String twoYearsAfter){
  int deleteIndex = -1;
  double currentOpening = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof OpeningPriceBarChart) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> twoYearOpeningDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(twoYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(twoYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       twoYearOpeningDate.add(dataList.get(i));  
      double newOpening = dataList.get(i).open_price();
      if (newOpening > currentOpening) {
        currentOpening = newOpening;
      }
    }
  }
  }
  
  
  Collections.sort(twoYearOpeningDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
  if(twoYearOpeningDate.size() <45){
     if(twoYearOpeningDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / twoYearOpeningDate.size();
  }
  
  return new OpeningPriceBarChart(twoYearOpeningDate, currentOpening,sliderWidth, 2, noDataToDisplay); 
}


Widget oneYearRangeOpeningBarChart(String ticker, String oneYearsPrevious, String oneYearsAfter){
  int deleteIndex = -1;
  double currentOpening = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof OpeningPriceBarChart) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> oneYearOpeningDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(oneYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(oneYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       oneYearOpeningDate.add(dataList.get(i));  
      double newOpening = dataList.get(i).open_price();
      if (newOpening > currentOpening) {
        currentOpening = newOpening;
      }
    }
  }
  }
  
  
  Collections.sort(oneYearOpeningDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
  if(oneYearOpeningDate.size()<45){
     if(oneYearOpeningDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / oneYearOpeningDate.size();
  }
  
  return new OpeningPriceBarChart(oneYearOpeningDate, currentOpening,sliderWidth, 1, noDataToDisplay); 
}



//Added by Matteo 01/04/20 a barchart method and a ClosingPriceBarchart Class 
//The barchart represents the closing prices over the entire existence(time) of the stock.
Widget createClosingPriceBarChart(String ticker) {
  double currentClosing = 0;
   
  ArrayList <Datapoints> closingDate = new ArrayList();


  //Ruxin, changed the for loop from showing all result to showing the result in
  // a date range, 09/04, 3pm
  for (int i = 0; i < dateInRangeList.size(); i++) {
    if (ticker.equals(dateInRangeList.get(i).ticker())) {
      closingDate.add(dateInRangeList.get(i)); 
      double newClosingPrice = dateInRangeList.get(i).close_price();
      if (newClosingPrice > currentClosing) {
        currentClosing = newClosingPrice;
      }
    }
  }
  sliderWidth = 400 * 45 / closingDate.size();
  Collections.sort(closingDate);
  return new ClosingPriceBarChart(closingDate, currentClosing, sliderWidth, 0, false );}

Widget fiveYearRangeClosingBarChart(String ticker, String fiveYearsPrevious, String fiveYearsAfter){
  int deleteIndex = -1;
  double currentClosing = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof ClosingPriceBarChart) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> fiveYearClosingDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(fiveYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(fiveYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       fiveYearClosingDate.add(dataList.get(i));  
      double newClosing = dataList.get(i).close_price();
      if (newClosing > currentClosing) {
        currentClosing = newClosing;
      }
    }
  }
  }
  
  
  Collections.sort(fiveYearClosingDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
    if(fiveYearClosingDate.size() <45){
     if(fiveYearClosingDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / fiveYearClosingDate.size();
  }
  
  return new ClosingPriceBarChart(fiveYearClosingDate, currentClosing ,sliderWidth, 5, noDataToDisplay); 
}


Widget twoYearRangeClosingBarChart(String ticker, String twoYearsPrevious, String twoYearsAfter){
  int deleteIndex = -1;
  double currentClosing = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof ClosingPriceBarChart) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> twoYearClosingDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(twoYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(twoYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       twoYearClosingDate.add(dataList.get(i));  
      double newClosing = dataList.get(i).close_price();
      if (newClosing > currentClosing) {
        currentClosing = newClosing;
      }
    }
  }
  }
  
  
  Collections.sort(twoYearClosingDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
    if(twoYearClosingDate.size() <45){
     if(twoYearClosingDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / twoYearClosingDate.size();
  }
  
  return new ClosingPriceBarChart(twoYearClosingDate, currentClosing,sliderWidth, 2, noDataToDisplay); 
}

Widget oneYearRangeClosingBarChart(String ticker, String oneYearsPrevious, String oneYearsAfter){
  int deleteIndex = -1;
  double currentClosing = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof ClosingPriceBarChart) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> oneYearClosingDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(oneYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(oneYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       oneYearClosingDate.add(dataList.get(i));  
      double newClosing = dataList.get(i).close_price();
      if (newClosing > currentClosing) {
        currentClosing = newClosing;
      }
    }
  }
  }
  
  
  Collections.sort(oneYearClosingDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
    if(oneYearClosingDate.size() <45){
     if(oneYearClosingDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else{
     sliderWidth =  400 * 45 / oneYearClosingDate.size();
  }
  
  return new ClosingPriceBarChart(oneYearClosingDate, currentClosing,sliderWidth, 1, noDataToDisplay); 
}



//Ceated by Tim, a point graph to display Volume over a specified amount of time
//for a chosen company
Widget createVolumePointGraph(String ticker) {
  int deleteIndex = -1;
  int currentVolume = 0;

  for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof VolumePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);

  ArrayList <Datapoints> volumeDate = new ArrayList();

  println(dateInRangeList.size());
  // Ruxin, changed the for loop from showing all result to showing the result in
  // the searched date range, 02/04, 10pm
  for (int i = 0; i < dateInRangeList.size(); i++) {
    if (ticker.equals(dateInRangeList.get(i).ticker())) {
      volumeDate.add(dateInRangeList.get(i)); 
      int newVolume = dateInRangeList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  sliderWidth =  400 * 45 / volumeDate.size();
  Collections.sort(volumeDate);
  graph =  new VolumePointGraph(volumeDate, currentVolume,sliderWidth, 0, false );  return graph;
}

     
Widget fiveYearRangeVolumePointGraph(String ticker, String fiveYearsPrevious, String fiveYearsAfter){
  int deleteIndex = -1;
  int currentVolume = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof VolumePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> fiveYearVolumeDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(fiveYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(fiveYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       fiveYearVolumeDate.add(dataList.get(i));  
      int newVolume = dataList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  }
  
  
  Collections.sort(fiveYearVolumeDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
    if(fiveYearVolumeDate.size() <45){
      if(fiveYearVolumeDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / fiveYearVolumeDate.size();
  }
  return new VolumePointGraph(fiveYearVolumeDate, currentVolume,sliderWidth, 5, noDataToDisplay); 
}

     
Widget twoYearRangeVolumePointGraph(String ticker, String twoYearsPrevious, String twoYearsAfter){
  int deleteIndex = -1;
  int currentVolume = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof VolumePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> twoYearVolumeDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(twoYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(twoYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       twoYearVolumeDate.add(dataList.get(i));  
      int newVolume = dataList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  }
  
  
  Collections.sort(twoYearVolumeDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
   if(twoYearVolumeDate.size() <45){
     if(twoYearVolumeDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / twoYearVolumeDate.size();
  }
  return new VolumePointGraph(twoYearVolumeDate, currentVolume,sliderWidth, 2, noDataToDisplay); 
}

     
Widget oneYearRangeVolumePointGraph(String ticker, String oneYearsPrevious, String oneYearsAfter){
  int deleteIndex = -1;
  int currentVolume = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof VolumePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> oneYearVolumeDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(oneYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(oneYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       oneYearVolumeDate.add(dataList.get(i));  
      int newVolume = dataList.get(i).volume();
      if (newVolume > currentVolume) {
        currentVolume = newVolume;
      }
    }
  }
  }
  
  
  Collections.sort(oneYearVolumeDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
   if(oneYearVolumeDate.size() <45){
     if(oneYearVolumeDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / oneYearVolumeDate.size();
  }
  return new VolumePointGraph(oneYearVolumeDate, currentVolume, sliderWidth, 1, noDataToDisplay); 
}

//Ceated by Tim, a point graph to display Opening Price over a specified amount of time
//for a chosen company
Widget createOpeningPricePointGraph(String ticker) {
  int deleteIndex = -1;
  double currentOpening = 0;

  for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof OpeningPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);

  ArrayList <Datapoints> openingDate = new ArrayList();

  //Ruxin, changed the for loop from showing all result to showing the result in
  // a date range, 09/04, 3pm
  for (int i = 0; i < dateInRangeList.size(); i++) {
    if (ticker.equals(dateInRangeList.get(i).ticker())) {
      openingDate.add(dateInRangeList.get(i)); 
      double newOpeningPrice = dateInRangeList.get(i).open_price();
      if (newOpeningPrice > currentOpening) {
        currentOpening = newOpeningPrice;
      }
    }
  }
  sliderWidth =  400 * 45 / openingDate.size();
  Collections.sort(openingDate);
  return new OpeningPricePointGraph(openingDate, currentOpening,sliderWidth, 0, false);}


Widget fiveYearRangeOpeningPointGraph(String ticker, String fiveYearsPrevious, String fiveYearsAfter){
  int deleteIndex = -1;
  double currentOpening = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof OpeningPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> fiveYearOpeningDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(fiveYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(fiveYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       fiveYearOpeningDate.add(dataList.get(i));  
      double newOpening = dataList.get(i).open_price();
      if (newOpening > currentOpening) {
        currentOpening = newOpening;
      }
    }
  }
  }
  
  
  Collections.sort(fiveYearOpeningDate);
  
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
  if(fiveYearOpeningDate.size() <45){
     if(fiveYearOpeningDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / fiveYearOpeningDate.size();
  }
  return new OpeningPricePointGraph(fiveYearOpeningDate, currentOpening, sliderWidth, 5, noDataToDisplay); 
}


Widget twoYearRangeOpeningPointGraph(String ticker, String twoYearsPrevious, String twoYearsAfter){
  int deleteIndex = -1;
  double currentOpening = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof OpeningPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> twoYearOpeningDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(twoYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(twoYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       twoYearOpeningDate.add(dataList.get(i));  
      double newOpening = dataList.get(i).open_price();
      if (newOpening > currentOpening) {
        currentOpening = newOpening;
      }
    }
  }
  }
  
  
  Collections.sort(twoYearOpeningDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
   if(twoYearOpeningDate.size() <45){
     if(twoYearOpeningDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / twoYearOpeningDate.size();
  }
  return new OpeningPricePointGraph(twoYearOpeningDate, currentOpening,sliderWidth, 2, noDataToDisplay); 
}


Widget oneYearRangeOpeningPointGraph(String ticker, String oneYearsPrevious, String oneYearsAfter){
  int deleteIndex = -1;
  double currentOpening = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof OpeningPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> oneYearOpeningDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(oneYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(oneYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       oneYearOpeningDate.add(dataList.get(i));  
      double newOpening = dataList.get(i).open_price();
      if (newOpening > currentOpening) {
        currentOpening = newOpening;
      }
    }
  }
  }
  
  
  Collections.sort(oneYearOpeningDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
    if(oneYearOpeningDate.size() <45){
     if(oneYearOpeningDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else{
     sliderWidth =  400 * 45 / oneYearOpeningDate.size();
  }
  return new OpeningPricePointGraph(oneYearOpeningDate, currentOpening,sliderWidth, 1, noDataToDisplay); 
}




//Ceated by Tim, a point graph to display Closing Price over a specified amount of time
//for a chosen company
Widget createClosingPricePointGraph(String ticker) {
  int deleteIndex = -1;
  double currentClosing = 0;

  for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof ClosingPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);

  ArrayList <Datapoints> closingDate = new ArrayList();

  //Ruxin, changed the for loop from showing all result to showing the result in
  // a date range, 09/04, 3pm
  for (int i = 0; i < dateInRangeList.size(); i++) {
    if (ticker.equals(dateInRangeList.get(i).ticker())) {
      closingDate.add(dateInRangeList.get(i)); 
      double newClosingPrice = dateInRangeList.get(i).close_price();
      if (newClosingPrice > currentClosing) {
        currentClosing = newClosingPrice;
      }
    }
  }
  sliderWidth =  400 * 45 / closingDate.size();
  Collections.sort(closingDate);
  return new ClosingPricePointGraph(closingDate, currentClosing, sliderWidth, 0, false );}


Widget fiveYearRangeClosingPointGraph(String ticker, String fiveYearsPrevious, String fiveYearsAfter){
  int deleteIndex = -1;
  double currentClosing = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof ClosingPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> fiveYearClosingDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(fiveYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(fiveYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       fiveYearClosingDate.add(dataList.get(i));  
      double newClosing = dataList.get(i).close_price();
      if (newClosing > currentClosing) {
        currentClosing = newClosing;
      }
    }
  }
  }
  
  Collections.sort(fiveYearClosingDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
  if(fiveYearClosingDate.size() <45){
     if(fiveYearClosingDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else {
     sliderWidth =  400 * 45 / fiveYearClosingDate.size();
  }
  return new ClosingPricePointGraph(fiveYearClosingDate, currentClosing ,sliderWidth, 5, noDataToDisplay); 
}


Widget twoYearRangeClosingPointGraph(String ticker, String twoYearsPrevious, String twoYearsAfter){
  int deleteIndex = -1;
  double currentClosing = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof ClosingPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> twoYearClosingDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(twoYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(twoYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       twoYearClosingDate.add(dataList.get(i));  
      double newClosing = dataList.get(i).close_price();
      if (newClosing > currentClosing) {
        currentClosing = newClosing;
      }
    }
  }
  }
  
  
  Collections.sort(twoYearClosingDate);
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
  if(twoYearClosingDate.size() <45){
     if(twoYearClosingDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth = 400;
  }else {
   sliderWidth =  400 * 45 / twoYearClosingDate.size();
  }
  return new ClosingPricePointGraph(twoYearClosingDate, currentClosing,sliderWidth, 2, noDataToDisplay); 
}

Widget oneYearRangeClosingPointGraph(String ticker, String oneYearsPrevious, String oneYearsAfter){
  int deleteIndex = -1;
  double currentClosing = 0;
  boolean noDataToDisplay = false;
  Date d1 = null;
  Date d2 = null;
  Date d3 = null; 
  
 
   for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof ClosingPricePointGraph) {
      deleteIndex = index;
    }
  }
  if (deleteIndex != -1)
    currentScreen.Widgets.remove(deleteIndex);
  
   
  ArrayList <Datapoints> oneYearClosingDate = new ArrayList();
  
    try {
          d1 = dateFormat.parse(oneYearsPrevious);
          //println("=d1" + d1);
          d3 = dateFormat.parse(oneYearsAfter);
          

            }  catch (Exception e) {
            println("Unable to parse date");
      } 

  for (int i = 0; i < dataList.size(); i++) {
    if (ticker.equals(dataList.get(i).ticker())) {
        try {
                d2 = dateFormat.parse( dataList.get(i).sDate()); 
 
            } catch (Exception e) {

            println("Unable to parse date");
          } 
     if( d1.compareTo(d2) < 0
     && 
     d3.compareTo(d2) > 0
     ){ 
       oneYearClosingDate.add(dataList.get(i));  
      double newClosing = dataList.get(i).close_price();
      if (newClosing > currentClosing) {
        currentClosing = newClosing;
      }
    }
  }
  }
  
  
  Collections.sort(oneYearClosingDate);
  
  //Ruxin, changed the sliderwidth so it fits the chart, 22/04, 5pm
  if(oneYearClosingDate.size() <45){
     if(oneYearClosingDate.size() == 0){
         noDataToDisplay = true;
      }
     sliderWidth =  400;
  }else{
     sliderWidth =  400 * 45 / oneYearClosingDate.size();
  }
  
  return new ClosingPricePointGraph(oneYearClosingDate, currentClosing, sliderWidth, 1, noDataToDisplay); 
}
/* deleted by Ruxin, changed to a new menu, 9pm, 15/04
// Added by Matteo 01/04/20 
// A menu that deals with all the queries for the chart representation
void createChartMenu(){
  
  
    deletePreviousChart();
  
    println("I'm here");
    
    currentScreen.addWidget(barChart);
    currentScreen.addWidget(pointsChart);
    currentScreen.addWidget(volumeVsTime); 
    currentScreen.addWidget(openingVsTime);
    currentScreen.addWidget(closingVsTime); 
    currentScreen.addWidget(allTime);
    //currentScreen.addWidget(selectDate);
    currentScreen.addWidget(fiveYear);
    currentScreen.addWidget(twoYear);
    currentScreen.addWidget(oneYear);
    currentScreen.addWidget(selectChart2);
  
}
*/

// Added by Matteo 01/04/20 
// A menu that deals with all the queries for the chart representation

void createChart(String ticker){
    
    //deleteMenu();

//Time, added the dataSlideWidget and dataSlider to each graph, 18/04/2020
//Ruxin, added date range cases, 11pm,21/04/2020 
   currentScreen.Widgets.remove(dataSlideWidget);
   currentScreen.Widgets.remove(dataSlider);
  if (barChartBool && volumeVTimeBool && allTimeBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool) {
    currentScreen.addWidget(createVolumeBarChart(ticker));
  } 

   if(barChartBool && volumeVTimeBool && fiveYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
  
     currentScreen.addWidget(fiveYearRangeVolumeBarChart(ticker, fiveYearsPrevious, fiveYearsAfter));
      currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
      if(barChartBool && volumeVTimeBool && twoYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !oneYearBool&& !dateRangeBool){
  
     currentScreen.addWidget(twoYearRangeVolumeBarChart(ticker, twoYearsPrevious, twoYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
     if(barChartBool && volumeVTimeBool && oneYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool&& !dateRangeBool){
  
     currentScreen.addWidget(oneYearRangeVolumeBarChart(ticker, oneYearsPrevious, oneYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    //nnnn
    if(barChartBool && volumeVTimeBool && dateRangeBool && !oneYearBool && !pointsChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool){
    //println("here now, size is :"+dateInRangeList.size());
     currentScreen.addWidget(createVolumeBarChart(ticker));
    } 

  if (barChartBool && openingVTimeBool && allTimeBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool) {
    currentScreen.addWidget(createOpeningBarChart(ticker));
  } 
 if(barChartBool && openingVTimeBool && fiveYearBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !allTimeBool && !twoYearBool && !oneYearBool&& !dateRangeBool){
    
     currentScreen.addWidget(fiveYearRangeOpeningBarChart(ticker, fiveYearsPrevious, fiveYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
    if(barChartBool && openingVTimeBool && twoYearBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool  && !oneYearBool&& !dateRangeBool){
    
     currentScreen.addWidget(twoYearRangeOpeningBarChart(ticker, twoYearsPrevious, twoYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
    if(barChartBool && openingVTimeBool && oneYearBool && !pointsChartBool && !volumeVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool&& !dateRangeBool){
    
     currentScreen.addWidget(oneYearRangeOpeningBarChart(ticker, oneYearsPrevious, oneYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    //nnnn
    ////println(barChartBool);
    //println(openingVTimeBool);
    //println(dateRangeBool);
    //println(oneYearBool);
    //println(pointsChartBool);
    //println(openingVTimeBool);
    //println(closingVTimeBool);
    //println(allTimeBool);
    //println(fiveYearBool);
    //println(twoYearBool);
    if(barChartBool && openingVTimeBool && dateRangeBool && !oneYearBool && !pointsChartBool && !volumeVTimeBool   && !closingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool){
     currentScreen.addWidget(createOpeningBarChart(ticker));
    } 

    if (barChartBool && closingVTimeBool && allTimeBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool) {
      currentScreen.addWidget(createClosingPriceBarChart(ticker));
    } 
 
    if(barChartBool && closingVTimeBool && fiveYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !allTimeBool && !twoYearBool  && !oneYearBool&& !dateRangeBool){
    
     currentScreen.addWidget(fiveYearRangeClosingBarChart(ticker, fiveYearsPrevious, fiveYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
    if(barChartBool && closingVTimeBool && twoYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !allTimeBool && !fiveYearBool && !oneYearBool&& !dateRangeBool){
    
     currentScreen.addWidget(twoYearRangeClosingBarChart(ticker, twoYearsPrevious, twoYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    }
    
     if(barChartBool && closingVTimeBool && oneYearBool && !pointsChartBool && !volumeVTimeBool && !openingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool&& !dateRangeBool){
    
     currentScreen.addWidget(oneYearRangeClosingBarChart(ticker, oneYearsPrevious, oneYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    }
    //nnnn
    if(barChartBool && closingVTimeBool && dateRangeBool && !oneYearBool && !pointsChartBool && !openingVTimeBool && !volumeVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool){
  
     currentScreen.addWidget(createClosingPriceBarChart(ticker));
    } 
    
  if (pointsChartBool && volumeVTimeBool && allTimeBool && !barChartBool && !openingVTimeBool && !closingVTimeBool) {
    currentScreen.addWidget(createVolumePointGraph(ticker));
  } 
if(pointsChartBool && volumeVTimeBool && fiveYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
  
      currentScreen.addWidget(fiveYearRangeVolumePointGraph(ticker, fiveYearsPrevious, fiveYearsAfter));
      currentScreen.addWidget(backButton);
      currentScreen.addWidget(forwardButton);
    } 
    
     if(pointsChartBool && volumeVTimeBool && twoYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
  
      currentScreen.addWidget(twoYearRangeVolumePointGraph(ticker, twoYearsPrevious, twoYearsAfter));
      currentScreen.addWidget(backButton);
      currentScreen.addWidget(forwardButton);
    } 
    
     if(pointsChartBool && volumeVTimeBool && oneYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool  && !fiveYearBool && !twoYearBool && !dateRangeBool){
  
      currentScreen.addWidget(oneYearRangeVolumePointGraph(ticker, oneYearsPrevious, oneYearsAfter));
      currentScreen.addWidget(backButton);
      currentScreen.addWidget(forwardButton);
    } 
    //nnnn
    if(pointsChartBool && volumeVTimeBool && dateRangeBool && !oneYearBool && !barChartBool && !openingVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool){
  
     currentScreen.addWidget(createVolumePointGraph(ticker));
    } 
    
      if (pointsChartBool && openingVTimeBool && allTimeBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool) {
    currentScreen.addWidget(createOpeningPricePointGraph(ticker));
    
  } 

       if(pointsChartBool && openingVTimeBool && fiveYearBool  && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !allTimeBool && !twoYearBool && !oneYearBool && !dateRangeBool){
    
     currentScreen.addWidget(fiveYearRangeOpeningPointGraph(ticker, fiveYearsPrevious, fiveYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
    if(pointsChartBool && openingVTimeBool && twoYearBool  && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool  && !oneYearBool && !dateRangeBool){
    
     currentScreen.addWidget(twoYearRangeOpeningPointGraph(ticker, twoYearsPrevious, twoYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
    if(pointsChartBool && openingVTimeBool && oneYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
    
     currentScreen.addWidget(oneYearRangeOpeningPointGraph(ticker, oneYearsPrevious, oneYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    }
    //nnnn
    if(pointsChartBool && openingVTimeBool && dateRangeBool && !oneYearBool && !barChartBool && !volumeVTimeBool && !closingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool){
  
     currentScreen.addWidget(createOpeningPricePointGraph(ticker));
    } 
    
 if (pointsChartBool && closingVTimeBool && allTimeBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool) {
    currentScreen.addWidget(createClosingPricePointGraph(ticker));
  }
    
   if(pointsChartBool && closingVTimeBool && fiveYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !allTimeBool && !twoYearBool  && !oneYearBool && !dateRangeBool){
    
     currentScreen.addWidget(fiveYearRangeClosingPointGraph(ticker, fiveYearsPrevious, fiveYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    } 
    
    if(pointsChartBool && closingVTimeBool && twoYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !allTimeBool && !fiveYearBool && !oneYearBool && !dateRangeBool){
    
     currentScreen.addWidget(twoYearRangeClosingPointGraph(ticker, twoYearsPrevious, twoYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    }
    
     if(pointsChartBool && closingVTimeBool && oneYearBool && !barChartBool && !volumeVTimeBool && !openingVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool && !dateRangeBool){
    
     currentScreen.addWidget(oneYearRangeClosingPointGraph(ticker, oneYearsPrevious, oneYearsAfter));
     currentScreen.addWidget(backButton);
     currentScreen.addWidget(forwardButton);
    }   
    //nnnn
    if(pointsChartBool && closingVTimeBool && dateRangeBool && !oneYearBool && !barChartBool && !openingVTimeBool && !volumeVTimeBool && !allTimeBool && !fiveYearBool && !twoYearBool){
  
     currentScreen.addWidget(createClosingPricePointGraph(ticker));
    } 
 //
 //barChart.setWidgetColor(color(200, 20, 200));
 //  pointsChart.setWidgetColor(color(200, 20, 200));
 //  volumeVsTime.setWidgetColor(color(200, 20, 200));
 //  openingVsTime.setWidgetColor(color(200, 20, 200));
 //  closingVsTime.setWidgetColor(color(200, 20, 200));
 //  allTime.setWidgetColor(color(200, 20, 200));
 //  fiveYear.setWidgetColor(color(200, 20, 200));
 //  twoYear.setWidgetColor(color(200, 20, 200));
 //  oneYear.setWidgetColor(color(200, 20, 200));
 //  selectChart2.setWidgetColor(color(200, 20, 200));
 //  dateRange.setWidgetColor(color(200, 20, 200));
   
   currentScreen.addWidget(dataSlideWidget);
   currentScreen.addWidget(dataSlider);
   
}

/*Ruxin, delete the method and change to a new permanent menu, 8pm, 16/04
void deleteMenu(){  
     currentScreen.Widgets.remove(barChart);
     currentScreen.Widgets.remove(pointsChart);
     currentScreen.Widgets.remove(volumeVsTime);
     currentScreen.Widgets.remove(openingVsTime);
     currentScreen.Widgets.remove(closingVsTime);
     currentScreen.Widgets.remove(allTime);
     //currentScreen.Widgets.remove(selectDate);
     currentScreen.Widgets.remove(fiveYear);
     currentScreen.Widgets.remove(twoYear);     
     currentScreen.Widgets.remove(oneYear);
     currentScreen.Widgets.remove(selectChart2);
     
        
     //barChartBool = false;
     //pointsChartBool = false;
     //volumeVTimeBool = false;
     //openingVTimeBool = false;
     //closingVTimeBool = false;
     //allTimeBool = false;
     ////selectDateBool = false;
     //fiveYearBool = false;
     //twoYearBool = false;
     //oneYearBool = false;
     //selectChartBool = false;

     
      fiveYearsPrevious = "2015-01-01";
      fiveYearsAfter = "2020-01-01";
      
      twoYearsPrevious = "2018-01-01";
      twoYearsAfter = "2020-01-01"; 
      
      oneYearsPrevious = "2019-01-01";
      oneYearsAfter = "2020-01-01";
      
         
}
*/

//Ruxin, fixed the bug that slider doesn't disappear when choosing another stock, 
// fixed the bug that slider doesn't change with the garph, 3am, 23/04
void deletePreviousChart()
{


  int deleteVolumeBIndex = -1;
  int deleteOpeningBIndex = -1;
  int deleteClosingBIndex = -1;
  int deleteVolumePIndex = -1;
  int deleteOpeningPIndex = -1;
  int deleteClosingPIndex = -1;

  //println("\ncurrentScreen.Widgets.size:"+currentScreen.Widgets.size());
  
  for (int index = 0; index < currentScreen.Widgets.size(); index++) {
    if ( currentScreen.Widgets.get(index) instanceof VolumeBarChart) {
      deleteVolumeBIndex = index;
    }   
   
    if ( currentScreen.Widgets.get(index) instanceof OpeningPriceBarChart) {
      deleteOpeningBIndex = index;
    }
   
    if ( currentScreen.Widgets.get(index) instanceof ClosingPriceBarChart) {
      deleteClosingBIndex = index;
    }

    if ( currentScreen.Widgets.get(index) instanceof VolumePointGraph) {
      deleteVolumePIndex = index;
    }
    if ( currentScreen.Widgets.get(index) instanceof OpeningPricePointGraph) {
      deleteOpeningPIndex = index;
    }
    if ( currentScreen.Widgets.get(index) instanceof ClosingPricePointGraph) {
      deleteClosingPIndex = index;
    }
  }

//  println("deleteVolumeBIndex:"+deleteVolumeBIndex);
//  println("deleteOpeningBIndex:"+deleteOpeningBIndex);
//  println("deleteClosingBIndex:"+deleteClosingBIndex);
//  println("deleteVolumePIndex:"+deleteVolumePIndex);
//  println("deleteOpeningPIndex:"+deleteOpeningPIndex);
//  println("deleteClosingPIndex:"+deleteClosingPIndex);

////Tim, removes each data slider when removing the graph, 18/04/2020
  if (deleteVolumeBIndex != -1){
    currentScreen.Widgets.remove(deleteVolumeBIndex);
  }
  if (deleteOpeningBIndex != -1){
    currentScreen.Widgets.remove(deleteOpeningBIndex);
}
  if (deleteClosingBIndex != -1){
    currentScreen.Widgets.remove(deleteClosingBIndex);  
  }
  if (deleteVolumePIndex != -1){
    currentScreen.Widgets.remove(deleteVolumePIndex);
  }
  if (deleteOpeningPIndex != -1){
    currentScreen.Widgets.remove(deleteOpeningPIndex);
  }
  if (deleteClosingPIndex != -1){
    currentScreen.Widgets.remove(deleteClosingPIndex);;
  }
  //currentScreen.Widgets.remove(dataSlideWidget);
  //currentScreen.Widgets.remove(dataSlider);
}
// Yifan Zhu, Added the bubbleSort() method for the stockList
// so that the names on the list could be shown in alphabetic order,
// 11pm, 23/3/2020
ArrayList<Stocks> bubbleSort(ArrayList<Stocks> list) {
  Object[] arr1 = list.toArray();
  Stocks[] arr = new Stocks[arr1.length];
  for (int i = 0; i < arr1.length; i++) {
    arr[i] = (Stocks) arr1[i];
  }
  int n = arr.length; 
  for (int i=0; i < n; i++) 
    for (int j=1; j < (n-i); j++) 
      if (arr[j].ticker.compareTo(arr[j-1].ticker) < 0) 
      { 
        // swap elements
        Stocks temp = arr[j-1]; 
        arr[j-1] = arr[j]; 
        arr[j] = temp;
      }
  List<Stocks> list1 = Arrays.asList(arr);
  ArrayList<Stocks> list2 = new ArrayList<Stocks>();
  for (Stocks stock : list1) {
    list2.add(stock);
  }

  return list2;
}

// Yifan Zhu, Added the deleteNoTransactionsStocks() method to delete
// all the stocks that don't have transactions, 6pm, 24/3/2020
ArrayList<Stocks> deleteNoTransactionsStocks(ArrayList<Stocks> list) {
  int dataListLength = dataList.size();
  for (int i = 0; i < list.size(); ) {
    String ticker = list.get(i).ticker;
    int j;
    for (j = 0; j < dataListLength; j++) {
      if (ticker.equals(dataList.get(j).ticker)) {
        break;
      }
    }
    if (j == dataListLength) {
      list.remove(i);
    } else {
      i++;
    }
  }

  return list;
}
