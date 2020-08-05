class Variation {
  float[] preTransform = new float[6];
  float[] postTransform = new float[6];
  float colorVal;
  String name;

  Variation setColor(float val) {
    colorVal = val;
    return this;
  }

  Variation setTransform(float[] pre) {
    this.preTransform = pre;
    return this;
  }

  Variation() {
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
    // Pre transform
    PVector v = this.affine(input, this.preTransform);

    // Apply variation
    v = this.f(v);

    // Color averages
    v.z = (input.z + colorVal) * 0.5;

    // Skipping post transform for testing
    // v = this.affine(v, this.postTransform);
    return v;
  }
}

class Fisheye extends Variation {    
  Fisheye() {
    super();
    this.name = "Fisheye";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    PVector newV = new PVector(v.y, v.x);
    newV.mult(2 / (r+1));
    return newV;
  }
}

class Diamond extends Variation {    
  Diamond() {
    super();
    this.name = "Diamond";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float theta = atan(v.x / v.y);
    float x =  sin(theta) * cos(r);
    float y =  cos(theta) * sin(r);
    return new PVector(x, y);
  }
}

class Hyperbolic extends Variation {    
  Hyperbolic() {
    super();
    this.name = "Hyperbolic";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float theta = atan(v.x / v.y);
    float x =  sin(theta) / r;
    float y =  r * cos(theta);
    return new PVector(x, y);
  }
}

class Spiral extends Variation {    
  Spiral() {
    super();
    this.name = "Spiral";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float theta = atan(v.x / v.y);
    float x =  (1/r) * (cos(theta) + sin(r));
    float y =  (1/r) * (sin(theta) - cos(r));
    return new PVector(x, y);
  }
}


class Disc extends Variation {    
  Disc() {
    super();
    this.name = "Disc";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float theta = atan(v.x / v.y);
    float x =  (theta/PI) * sin(PI * r);
    float y =  (theta/PI) * cos(PI * r);
    return new PVector(x, y);
  }
}

class Heart extends Variation {    
  Heart() {
    super();
    this.name = "Heart";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float theta = atan(v.x / v.y);
    float x =  r * sin(theta * r);
    float y = -r * cos(theta * r);
    return new PVector(x, y);
  }
}


class Hankerchief extends Variation {    
  Hankerchief() {
    super();
    this.name = "Hankerchief";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float theta = atan(v.x / v.y);
    float x = r * sin(theta + r);
    float y = r * cos(theta - r);
    return new PVector(x, y);
  }
}

class Polar extends Variation {    
  Polar() {
    super();
    this.name = "Polar";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float theta = atan(v.x / v.y);
    float x = theta / PI;
    float y = r - 1;
    return new PVector(x, y);
  }
}


class HorseShoe extends Variation {    
  HorseShoe() {
    super();
    this.name = "HorseShoe";
  }

  PVector f(PVector v) {
    float r = v.x * v.x + v.y * v.y;
    float x = (v.x - v.y) * (v.x + v.y);
    float y = 2 * v.x * v.y;
    return new PVector(x / r, y / r);
  }
}

class Spherical extends Variation {
  Spherical() {
    super();
    this.name = "Spherical";
  }

  PVector f(PVector v) {
    float r = v.x*v.x + v.y*v.y;
    return new PVector(v.x / r, v.y / r);
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
    return new PVector(v.x * amt, v.y * amt);
  }
}
