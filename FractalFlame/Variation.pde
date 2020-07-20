
class Spherical extends Variation {
  Spherical() {
    super();
  }

  PVector f(PVector v) {
    float r = v.magSq();
    return v.copy().div(r);
  }
}


class Swirl extends Variation {
  Swirl() {
    super();
  }

  PVector f(PVector v) {
    float r = v.magSq();
    return new PVector(v.x * sin(r) - v.y * cos(r), v.x * cos(r) - v.y * sin(r));
  }
}


class Sinusoidal extends Variation {
  Sinusoidal() {
    super();
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
    //return this.f(input);
    PVector v = this.affine(input, this.preTransform);
    v = this.f(v);
    v = this.affine(v, this.postTransform);
    return v;
  }
}
