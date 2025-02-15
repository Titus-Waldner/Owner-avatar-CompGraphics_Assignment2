// Plane.pde

class Plane extends SceneObject {
    PVector point;   // A point on the plane
    PVector normal;  // Normal vector of the plane (should be normalized)

    Plane(PVector point, PVector normal, Material material) {
        super(material);
        this.point = point;
        this.normal = normal.normalize();
    }

    @Override
    IntersectionResult intersect(Ray ray) {
        float denom = normal.dot(ray.direction);
        if (abs(denom) > 1e-6) { // Avoid division by zero was having some trouble with this, it seemesm to work now
                                  // did the other objets different  to make it more clearer but this works and I don't want to break it...
            PVector p0l0 = PVector.sub(point, ray.origin);
            float t = p0l0.dot(normal) / denom;
            if (t >= 0) {
                PVector intersectionPoint = PVector.add(ray.origin, PVector.mult(ray.direction, t));
                return new IntersectionResult(t, intersectionPoint, normal, this);
            }
        }
        return null;
    }
}
