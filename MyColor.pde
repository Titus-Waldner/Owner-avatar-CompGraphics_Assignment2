// MyColor.pde

class MyColor {
    float r, g, b;

    MyColor(float r, float g, float b) {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    // Multiply color by a scalar, used to alter color of object darker or lighter
    MyColor mult(float scalar) {
        return new MyColor(r * scalar, g * scalar, b * scalar);
    }


    // Add another color
    MyColor add(MyColor other) {
        return new MyColor(r + other.r, g + other.g, b + other.b);
    }


    // turn to integer color value
    int toInt() {
        return color(r, g, b);
    }
}
