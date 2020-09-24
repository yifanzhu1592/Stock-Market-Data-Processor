// The Datapoints class contains information about the data points in the graph
class Datapoints implements Comparable<Datapoints> {
  String ticker; //alphabetic code uniquely identifying the stock, e.g. IBM, AAPL, GOOG, MSFT.
  double open_price; // the opening price for that day 
  double close_price; // the closing price for that day
  double adjusted_close; //adjusted closing price which takes into account company actions such as share splits and dividends. 
  double low; // the lowest price for that day. 
  double high; // the highest price for that day. 
  int volume; // the number of shares traded that day.
  String sDate; // the date in YYY-MM-DD format.
  Date date = new Date();
  double Lchange; //largest change (in one day)
  
  Datapoints(String [] tokens) {
    this.ticker = tokens[0]; 
    this.open_price = float(tokens[1]);
    this.close_price = float(tokens[2]);
    this.adjusted_close = float(tokens[3]);
    this.low = float(tokens[4]);
    this.high = float(tokens[5]);
    this.volume = int(tokens[6]);
    this.sDate = tokens[7];
    this.Lchange = (this.close_price - this.open_price) / this.open_price * 100;
    try {
      date = dateFormat.parse(sDate);
    } catch(Exception e) {
      println(e);
    };
  }
  
  String ticker() {
    return ticker;
  }
  
  int volume() {
    return volume;
  }
  
  double open_price() {
    return open_price;
  }
  
  double close_price() {
    return close_price;
  }
  
  Date date() {
    return date;
  }
  
  String sDate () {
    return sDate;
  }
  
   @Override
  public int compareTo(Datapoints d) {
    return date().compareTo(d.date()); 
  }
}
