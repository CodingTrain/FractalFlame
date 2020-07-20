class Hankerchief extends Variation {    
  Hankerchief() {
    super();
    this.name = "Hankerchief";
  }

  PVector f(PVector v) {
    if (abs(v.y) > 0) {
      float r = v.magSq();
      float theta = atan(v.x / v.y);
      float x = r * sin(theta + r);
      float y = r * cos(theta - r);
      return new PVector(x, y);
    } else {
      return v.copy();
    }
  }
}


class HorseShoe extends Variation {    
  HorseShoe() {
    super();
    this.name = "HorseShoe";
  }

  PVector f(PVector v) {
    float r = v.magSq();
    float x = (v.x-v.y) * (v.x+v.y);
    float y = 2 * v.x * v.y;
    PVector newV = new PVector(x, y);
    if (r > 0) {
      newV.div(r);
    }
    return newV;
  }
}

class Spherical extends Variation {
  Spherical() {
    super();
    this.name = "Spherical";
  }

  PVector f(PVector v) {
    float r = v.magSq();
    if (r > 0) {
      return v.copy().div(r);
    } else {
      return v.copy();
    }
  }
}


class Swirl extends Variation {
  Swirl() {
    super();
    this.name = "Swirl";
  }

  PVector f(PVector v) {
    float r = v.magSq();
    return new PVector(v.x * sin(r) - v.y * cos(r), v.x * cos(r) - v.y * sin(r));
  }
}


class Sinusoidal extends Variation {
  Sinusoidal() {
    super();
    this.name = "Sinusoidal";
  }

  PVector f(PVector v) {
    return new PVector(sin(v.x), sin(v.y));
  }
}


class Linear extends Variation {
  float amt;
  Linear(float amt) {
    super();
    this.amt = amt;
  }

  PVector f(PVector v) {
    return v.copy().mult(amt);
  }
}

class Variation {
  float[] preTransform = new float[6];
  float[] postTransform = new float[6];
  float r, g, b;
  String name;

  Variation setColor(float r, float g, float b) {
    this.r = r;
    this.b = b;
    this.g = g;    
    return this;
  }

  Variation() {
    color c = randomColor();
    this.setColor(red(c)/255,green(c)/255,blue(c)/255);
    for (int i = 0; i < 6; i++) {
      this.preTransform[i] = random(-1, 1);
      this.postTransform[i] = random(-1, 1);
    }
  }

  PVector affine(PVector v, float[] coeff) {
    float x = coeff[0] * v.x + coeff[1] * v.y + coeff[2];
    float y = coeff[3] * v.x + coeff[4] * v.y + coeff[5];
    return new PVector(x, y);
  }

  PVector f(PVector v) {
    return v.copy();
  }

  PVector flame(PVector input) {
    //return this.f(input);
    PVector v = this.affine(input, this.preTransform);
    v = this.f(v);
    v = this.affine(v, this.postTransform);
    return v;
  }
}
