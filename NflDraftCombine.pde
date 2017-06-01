//Data Project - Nfl Combines and Drafts from 1999-2016
//By: Benedict Donnay and Trevor Liggett
//Data Sourced from http://nflcombineresults.com/ and http://www.pro-football-reference.com/draft/

//this interface can be used to store different data types in the same array.

String[] fromFile;
ArrayList<Prospect> prospects;
ArrayList<SuperVariable> dims;
boolean firstMenu = true; //Gets called in the draw menu if on the opening menu
boolean secondMenu = false; //Determines the Data Categories
boolean showData = false;//Visualizes the data from the given variables
String whichChoosen = "";
boolean drafted = false;
boolean doGraph = false;
boolean year, position, playerHeight, playerWeight, wonderlic, threecone, shutle, broadjump, verticle, bench = false;
String[][] variables = {{"Forty"}, {"Height", "Weight", "Wonderlic", "Three Cone"}, {"Shuttle", "Broadjump", "Verticle", "Bench"}};
String[][] vars = {{"forty"}, {"height", "weight", "wonderlic", "threeCone"}, {"shuttle", "broad", "vertical", "bench"}};
boolean mean, median, mode, highest, lowest = false;
PImage nfllogo;
String choosenVar = "";
String go = "";
double [] graph;
OneVarStat given;
SuperVariable measure, measured;
SuperDouble d1;
Delimiter dim1;
int hi = 0;

void setup() { //Setup the menus and window that the data is displayed
  size(1920, 1080);
  background(0);
  nfllogo = loadImage("nfllogo.jpg");
  prospects = new ArrayList<Prospect>();
  fromFile = loadStrings("Data Project1.txt");
   loadData();
  //dims.add(dim2);;
  // I used this to test if things were working
  /*for (SuperVariable $ : prospects.get(0).statistics) {
   println($.getName());
   }
   */
  firstMenu();
}

void draw() { //Draw the window and call the various classes that need to be called
  if (firstMenu) {
    if (mousePressed) { 
      if (overRect(768, 648, 384, 216)) {
        firstMenu= false;
        secondMenu = true;
        secondMenu();
      }
    }
  }
 else if (secondMenu) {
    for (int i = 0; i < 4; i++) {
      for (int j = 1; j < 3; j++) {
        if (mousePressed) { 
          if (overRect(480*i + 90, 500 + 200*j, 300, 100)) {
            secondMenu = false;
            showData = true;
            choosenVar = variables[j][i];
            go = vars[j][i];
            dataShow();
          }
        }
      }
    }
    if (mousePressed) { 
      if (overRect(730 + 90, 500, 300, 100)) {
        secondMenu = false;
        showData = true;
        choosenVar = variables[0][0];
        go = vars[0][0];
        dataShow();
      }
    }
  }
  else if (showData) {
    if (mousePressed) { 
      if (overRect(190, 340, 220, 100)) {
        whichChoosen = "mean";
        dataShow();
        doGraph = true;
      }
      if (overRect(190, 440, 210, 100)) {
        whichChoosen = "max";
        dataShow();
        doGraph = true;
      }
      if (overRect(190, 540, 190, 100)) {
        whichChoosen = "min";
        dataShow();
        doGraph = true;
      }
      if (overRect(190, 640, 180, 100)) {
        whichChoosen = "range";
        dataShow();
        doGraph = true;
      }
      if (overRect(190, 920, 130, 100)) {
        secondMenu = true;
        showData = false;
        secondMenu();
        doGraph = false;
        go = "";
        choosenVar = "";
      }
    }
  }
}
void loadData(){
 for (int i = 1; i < fromFile.length; i++) {
    Prospect p = new Prospect();
    p.loadStats(fromFile[i]);
    prospects.add(p);
  }
}
void firstMenu() {
  background(109, 186, 255); 
  image(nfllogo, 0, 0, 1920, 1080);
  fill(219, 67, 58);
  textSize(70);
  text("Data Project - Nfl Combines and Drafts", 400, 162); 
  text("By: Benedict Donnay and Trevor Liggett", 400, 270); 
  fill(80, 134, 219);
  rect(768, 648, 384, 216);//All players Button
  fill(219, 67, 58);
  textSize(70);
  text("All Players", 787, 713, 384, 216);
}

void secondMenu() {
  background(0); 
  image(nfllogo, 0, 0, 1920, 1080);
  fill(219, 67, 58);
  textSize(70);
  fill(80, 134, 219);
  rect(730 + 90, 500, 300, 100);
  fill(219, 67, 58);
  textSize(48);
  text(variables[0][0], 730 + 100, 560);
  for (int i = 0; i < 4; i++) {
    for (int j = 1; j < 3; j++) {
      fill(80, 134, 219);
      rect(480*i + 90, 500 + 200*j, 300, 100);
      fill(219, 67, 58);
      textSize(48);
      text(variables[j][i], 480*i + 100, 560 + 200*j);
    }
  }
}

void dataShow() {
  background(0); 
  dims = new ArrayList<SuperVariable>();
  image(nfllogo, 0, 0, 1920, 1080);
  textSize(70);
  text(choosenVar, 400, 200); 
  System.out.println("hello" + go);
  fill(80, 134, 219);
  rect(190, 340, 220, 100);
  rect(190, 440, 210, 100);
  rect(190, 540, 190, 100);
  rect(190, 640, 180, 100);
  rect(190, 920, 130, 100);
  fill(219, 67, 58);
  textSize(48);
  hi++;
  measure = new SuperDouble(go, 0);
  given = new OneVarStat("" + hi, prospects, dims, measure);
  text("Average: " + given.getMean(), 200, 400);
  text("Highest: " + given.getMaximum().getName() + ", " + given.getMaximum().getVar(given.measured.getName()).getDouble(), 200, 500);
  text("Lowest: " + given.getMinimum().getName() + ", " + given.getMinimum().getVar(given.measured.getName()).getDouble(), 200, 600);
  text("Range: " + given.getRange(), 200, 700);
  text("Back", 200, 980);
  graph = new double[16];
  if (doGraph) {
    for (int m = 0; m < 16; m++) {
      System.out.println("whore");
      ArrayList<SuperVariable> dims2 = new ArrayList<SuperVariable>();
      //measured = new SuperDouble(go, 0);
      d1 = new SuperDouble("year", 2007);
      //dim1 = new SuperDouble(d1, "year");
      dims2.add(d1);
      OneVarStat given1 = new OneVarStat("Hello World"+m, prospects, dims2, measure);
      
      
      if (whichChoosen.equals("mean")) {
        System.out.println("hello1");
        graph[m] = given1.getMean();
      }
      if (whichChoosen.equals("range")) {
        System.out.println("hello2");
        graph[m] = given1.getRange();
      }
      if (whichChoosen.equals("min")) {
        System.out.println("hello3");
        graph[m] = given1.getMinimum().getVar(given1.measured.getName()).getDouble();
      }
      if (whichChoosen.equals("max")) {
        System.out.println("hello4");
        graph[m] = given1.getMaximum().getVar(given1.measured.getName()).getDouble();
      }
    }
  }
  // calculate the width of one bar depending on the length of the array
  int w = 800/graph.length;
  for (int i=0; i<graph.length; i++) {
    int h = (int)graph[i];
    // draw the rect for the bar graph
    fill(219, 67, 58);
    rect(1100 + i*w, 1000-h, w, h);
    fill(219, 67, 58);
    textSize(18);
    text(""+ (1999+i), 1100 + i*w, 1020 );
    text("Year", 1480, 1040);
  }
}

boolean overRect(double x, double y, double width, double height) { //Method that determines if the mouse is within a given rectangle
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

//this interface can be used to store different data types in the same array.
interface SuperVariable {
  String getString();
  boolean isString();
  double getDouble();
  String getName();
}


class Delimiter {
  String vName;
  SuperVariable sVar;

  Delimiter(SuperVariable $, String name) {
    vName = name;
    sVar = $;
  }
}




class OneVarStat {
  String name;
  ArrayList<Prospect> prospects1;
  SuperVariable measured;

  OneVarStat(String n, ArrayList<Prospect> p, ArrayList<SuperVariable> delimiters, SuperVariable m) {
    prospects1 = p;
    this.name = n;
    measured = m;
    for (SuperVariable $ : delimiters) {
      for (int i = prospects1.size()-1; i >=0; i--) {

        if (prospects1.get(i).hasVar($.getName())) {
          if ($.isString()) {
            if (!prospects1.get(i).getVar($.getName()).getString().equals($.getString())) {
              prospects1.remove(i);
            }
          } else {
            if (!(prospects1.get(i).getVar($.getName()).getDouble() == $.getDouble())) {
              prospects1.remove(i);
            }
          }
        }
      }
    }
  }



  double getMean() {
    if (measured.isString()) {
      System.out.println("TYPE ERROR :: MEASURED VARIABLE IS STRING");
      return 0;
    } else {
      double sum = 0;
      double count = 0;
      for (Prospect p : prospects1) {
        if (p.hasVar(measured.getName())) {
          sum += p.getVar(measured.getName()).getDouble();
          count ++;
        }
      }

      return sum/count;
    }
  }
  double getMode() {
    return 0;
  }
  double getRange() {
    return getMaximum().getVar(measured.getName()).getDouble()-getMinimum().getVar(measured.getName()).getDouble();
  }
  Prospect getMaximum() {
    Prospect elite = prospects1.get(0);
    int i = 1;
    while (!elite.hasVar(measured.getName())) {
      elite = prospects1.get(i);
      i++;
    }
    for (Prospect p : prospects1) {
      if (p.hasVar(measured.getName())) {
        if (p.getVar(measured.getName()).getDouble() > elite.getVar(measured.getName()).getDouble()) {
          elite = p;
        }
      }
    }

    return elite;
  }
  Prospect getMinimum() {
    Prospect elite = prospects1.get(0);
    int i = 1;
    while (!elite.hasVar(measured.getName())) {
      elite = prospects.get(i);
      i++;
    }

    for (Prospect p : prospects1) {
      if (p.hasVar(measured.getName())) {
        if (p.getVar(measured.getName()).getDouble() < elite.getVar(measured.getName()).getDouble()) {
          elite = p;
        }
      }
    }

    return elite;
  }

  public String toString() {
    String s = "";


    return s;
  }
}







// utilized for String Variables
class SuperString implements SuperVariable {
  String dataText;
  double dataNum;
  String name;
  SuperString(String n, String data) {
    dataText = data;
    this.name = n;
  }
  String getString() {
    return dataText;
  }
  boolean isString() {
    return true;
  }
  double getDouble() {
    return dataNum;
  }
  String getName() {
    return name;
  }
}


// utilized for double variables.
class SuperDouble implements SuperVariable {
  String dataText;
  double dataNum;
  String name;
  SuperDouble(String n, double d) {
    dataNum = d;
    name = n;
  }
  String getString() {
    return dataText;
  }
  boolean isString() {
    return false;
  }
  double getDouble() {
    return dataNum;
  }
  String getName() {
    return name;
  }
}


class Prospect {
  ArrayList<SuperVariable> statistics;


  Prospect() {
    statistics = new ArrayList<SuperVariable>();
  }


  //method adds statistics to the prospect from a line in prospects.csv;
  void loadStats(String s) {
    String[] stats = s.split(",");
    SuperString name = new SuperString("name", stats[0]);
    statistics.add(name);
    SuperString college = new SuperString("college", stats[1]);
    statistics.add(college);
    SuperDouble year = new SuperDouble("year", Double.parseDouble(stats[2]));
    statistics.add(year);
    SuperString position = new SuperString("position", stats[3]);
    statistics.add(position);
    //here I checked to see if it had the statistic; previous statistics were in all prospects.
    if (!stats[4].equals("")) {
      SuperDouble pHeight = new SuperDouble("height", Double.parseDouble(stats[4]));
      statistics.add(pHeight);
    }
    if (!stats[5].equals("")) {
      SuperDouble weight = new SuperDouble("weight", Double.parseDouble(stats[5]));
      statistics.add(weight);
    }
    if (!stats[6].equals("")) {
      SuperDouble wonderlic = new SuperDouble("wonderlic", Double.parseDouble(stats[6]));
      statistics.add(wonderlic);
    }
    if (!stats[7].equals("")) {
      SuperDouble forty = new SuperDouble("forty", Double.parseDouble(stats[7]));
      statistics.add(forty);
    }
    if (!stats[8].equals("")) {
      SuperDouble bench = new SuperDouble("bench", Double.parseDouble(stats[8]));
      statistics.add(bench);
    }
    if (!stats[9].equals("")) {
      SuperDouble vertical = new SuperDouble("vertical", Double.parseDouble(stats[9]));
      statistics.add(vertical);
    }
    if (!stats[10].equals("")) {
      SuperDouble broad = new SuperDouble("broad", Double.parseDouble(stats[10]));
      statistics.add(broad);
    }
    if (!stats[11].equals("")) {
      SuperDouble shuttle = new SuperDouble("shuttle", Double.parseDouble(stats[11]));
      statistics.add(shuttle);
    }
    if (!stats[12].equals("")) {
      SuperDouble threeCone = new SuperDouble("threeCone", Double.parseDouble(stats[12]));
      statistics.add(threeCone);
    }
    if (!stats[13].equals("")) {
      SuperString team = new SuperString("team", (stats[13]));
      statistics.add(team);
    }
    if (!stats[14].equals("")) {
      SuperDouble round = new SuperDouble("round", Double.parseDouble(stats[14]));
      statistics.add(round);
    }
    if (!stats[15].equals("")) {
      SuperDouble pick = new SuperDouble("pick", Double.parseDouble(stats[15]));
      statistics.add(pick);
    }
    SuperString drafted = new SuperString("isDrafted", stats[17]);
    statistics.add(drafted);
  }


  /*
   runs through variables in statistics arraylist to determine whether or not 
   it has variable under name.
   */
  boolean hasVar(String varName) {
    for (SuperVariable $ : statistics) {
      if ($.getName().equals(varName)) {
        return true;
      }
    }
    return false;
  }
  //returns the SuperVariable under the varName; DO NOT USE WITHOUT CHECKING HAS VAR
  SuperVariable getVar(String varName) {
    for (SuperVariable $ : statistics) {
      if ($.getName().equals(varName)) {
        return $;
      }
    }
    return null;
  }
  String getName() {
    return(getVar("name").getString());
  }
} 