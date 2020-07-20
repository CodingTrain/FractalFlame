PVector current;
Variation finalV;

ArrayList<Variation> variations = new ArrayList<Variation>();


void setup() {
  size(800, 800);
  background(0);
  variations.add(new Linear(0.5));
  variations.add(new Sinusoidal());
  variations.add(new Swirl());
  variations.add(new Spherical());
  current = PVector.random2D().mult(random(1));
}

void draw() {
  translate(width / 2, height / 2);
  scale(1, -1);
  strokeWeight(2);
  for (int i = 0; i < 1000; i++) {
    stroke(255);
    // A final transformation to fit on window?
    point(current.x * width / 2 * 0.5, current.y * height / 2 * 0.5);
    int index = int(random(variations.size()));
    Variation variation = variations.get(index);
    current = variation.flame(current);
  }
  //noLoop();
}
