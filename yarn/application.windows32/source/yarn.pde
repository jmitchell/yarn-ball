import java.util.*;

class Coordinate {
  int x = 0;
  int y = 0;
 
  public Coordinate(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public int get_x() { return x; }
  public int get_y() { return y; }
  
  public int get_tile_x() { return x * TILE_WIDTH; }
  public int get_tile_y() { return y * TILE_HEIGHT; }
}

class Yarn {
  int remaining_length = 10;
  ArrayList<Coordinate> positions = new ArrayList<Coordinate>();
  
  public Yarn(Coordinate start_position) {
    positions.add(start_position);
  }
  
  public Coordinate get_position() {
    return positions.get(positions.size()-1); 
  }
  
  public void draw() {
    drawBall();
    drawPath();
  }
  
  protected void drawBall() {
    fill(255);
    int x = get_position().get_tile_x();
    int y = get_position().get_tile_y();
    ellipse(x, y, 10, 10);  
  }
  
  protected void drawPath() {
    if (positions.size() <= 1) return;
    
    Coordinate prev = positions.get(0);
    for (int i = 1; i < positions.size(); i++) {
      Coordinate curr = positions.get(i);
      
      stroke(255);
      line(prev.get_tile_x(),
           prev.get_tile_y(),
           curr.get_tile_x(),
           curr.get_tile_y());
      
      prev = curr;
    }
  }
  
  public void tryMove(int keyCode) {
    Coordinate next = neighbor_from_key(keyCode);
    if (positions.size() >= 2 && next == positions.get(positions.size() - 2)) {
      positions.remove(positions.size() - 1); 
    } else {
      positions.add(next);
    }
  }
  
  protected Coordinate neighbor_from_key(int keyCode) {
    int next_x = get_position().get_x();
    int next_y = get_position().get_y();
    
    if (keyCode == UP) { next_y--; }
    if (keyCode == DOWN) { next_y++; }
    if (keyCode == LEFT) { next_x--; }
    if (keyCode == RIGHT) { next_x++; }
    
    return new Coordinate(next_x, next_y);
  }
  
  public boolean equals(Object obj) {
    /*
    if (obj == null)
      return false;
    if (obj == this)
      return true;
    if*/
    return true;  
  }
}

int TILE_WIDTH = 16;
int TILE_HEIGHT = 16;
Yarn yarn = new Yarn(new Coordinate(5,5));

void setup() {
  size(480, 320);
}

void draw() {
  background(0);
  
  Coordinate a = new Coordinate(0,0);
  Coordinate b = new Coordinate(0,0);
  if (a.equals(b)) {
    background(100); 
  }
  
  yarn.draw();
}

void keyPressed() {
  yarn.tryMove(keyCode); 
}
