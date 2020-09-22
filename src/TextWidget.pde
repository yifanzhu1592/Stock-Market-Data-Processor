// The TextWidget class for issues about entering texts
class TextWidget extends Widget {
  int maxlen;
  
  TextWidget(int x, int y, int width, int height,
    String label, PFont font, int event, int maxlen, int tl, int tr, int br, int bl) {
    super(x, y, width, height, event, tl, tr, br, bl);
    this.label = label;
    this.widgetFont = font;
    this.labelColor = color(0);
    this.widgetColor = color(245);
    this.maxlen = maxlen;
  }
  
  // Appending valid characters
  void append(char s) {
    if (s == BACKSPACE) {
      if (!label.equals("")) {
        label = label.substring(0, label.length() - 1);
      }
    } else if (label.length() < maxlen && 
        ((s >= '0' && s <= '9') || (s >= 'a' && s <= 'z') || (s >= 'A' && s <= 'Z') || s == '-')) {
          label = label + str(s);
    }
  }
}
