PVector current;
Variation finalV;

ArrayList<Variation> variations = new ArrayList<Variation>();

Pixel[][] pixies;

int total = 50000000;
int perFrame = 500000;
int count = 0;



void setup() {
  size(800, 800);
  //randomSeed(403);
  pixies = new Pixel[width][height];
  variations.add(new Linear(1));
  variations.add(new Sinusoidal());
  variations.add(new Swirl());
  variations.add(new Spherical());
  variations.add(new HorseShoe());
  //variations.add(new Hankerchief().setColor(0.5, 0.7, 1));
  current = PVector.random2D();//.mult(random(1));
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      pixies[i][j] = new Pixel();
    }
  }
}

void draw() {
  background(0);
  //translate(width / 2, height / 2);
  //scale(1, -1);
  //strokeWeight(2);
  for (int i = 0; i < perFrame; i++) {
    int index = int(random(variations.size()));
    Variation variation = variations.get(index);
    current = variation.flame(current);
    if (Float.isNaN(current.x) || Float.isNaN(current.y)) {
      println(variation.name);
      break;
    }

    // A final transformation to fit on window?
    float x = current.x * width / 2 * 0.5;
    float y = current.y * height / 2 * 0.5;
    int px = int(x + width/2);
    int py = int(y + height/2);

    if (px >= 0 && px < width && py >= 0 && py < height) {
      pixies[px][py].value++;
      pixies[px][py].r += variation.r;
      pixies[px][py].r /= 2;
      pixies[px][py].g += variation.g;
      pixies[px][py].g /= 2;
      pixies[px][py].b += variation.b;
      pixies[px][py].b /= 2;
    }
  }
  
  count += perFrame;
  //println(count);
  
  float percent = float(count) / total;
  fill(255);
  rect(0,50,percent * width,50);

  if (count >= total) {

    float max = 0;
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        Pixel pix = pixies[i][j];
        float value = (float) Math.log10(pix.value);
        if (value > max) {
          max = value;
        }
      }
    }

    loadPixels();
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        Pixel pix = pixies[i][j];
        float value = (float) Math.log10(pix.value)/max;
        float r = pix.r * value * 255;
        float g = pix.g * value * 255;
        float b = pix.b * value * 255;

        float gamma = 1 / 2.2;
        r = 255 * pow((r/255), gamma);
        g = 255 * pow((g/255), gamma);
        b = 255 * pow((b/255), gamma);
        int index = i + j * width;
        pixels[index] = color(r, g, b);
        //pixels[index] = color(value*255);
      }
    }
    updatePixels();
    noLoop();
  }
}
