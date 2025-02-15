// Ray.pde

class Ray {
    PVector origin;
    PVector direction;

    Ray(PVector origin, PVector direction) {
        this.origin = origin;
        this.direction = direction.normalize();
    }
}
