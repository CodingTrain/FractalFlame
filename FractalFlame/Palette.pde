color[] palette ={ 
  color(11, 106, 136), 
  color(45, 197, 244), 
  color(11, 106, 136), 
  color(112, 50, 126), 
  color(146, 83, 161), 
  color(164, 41, 99), 
  color(236, 1, 90), 
  color(240, 99, 164), 
  color(241, 97, 100), 
  color(248, 158, 79), 
  color(252, 238, 33)  
};

color randomColor() {
  int i = floor(random(palette.length));
  return palette[i];
}
