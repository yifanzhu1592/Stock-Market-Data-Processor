// The Stocks class contains information about stock info
class Stocks {
  String ticker;
  String exchange;
  String name;
  String sector;
  String industry;
  
  Stocks(){ }
  
  void ticker(String ticker) {
    this.ticker = ticker;
  }
  void exchange(String exchange) {
    this.exchange = exchange;
  }
  void name(String name) {
    this.name = name;
  }
  void sector(String sector){
    this.sector = sector;
  }
  void industry(String industry){
    this.industry = industry;
  }
}
