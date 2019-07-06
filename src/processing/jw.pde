void setup() {
  size(768, 768);
  background(100);
  rectMode(Processing.CENTER);
  var boxSize = 512;
  var min = 128;
  var max = (min + boxSize);
  var x = min;
  var y = min;
  var gridSize = 16;
  stroke(0);
  rect(128,128,boxSize, boxSize);
  while (y < max) {
      x = min;
      line(x, y, max, y);
      while (x < max) {
          line(x, y, x, max);
          x += gridSize;
      }
      y += gridSize;
  }
}

