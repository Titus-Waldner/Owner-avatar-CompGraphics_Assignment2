// Cone.pde

class Cone extends SceneObject {
    PVector apex;      // vertex of the cone
    float k;           // Determines the cone's opening angle (k = tan(theta))
    Material material;

    Cone(PVector apex, float k, Material material) {
        super(material);
        this.apex = apex;
        this.k = k;
        this.material = material;
    }

    @Override
    IntersectionResult intersect(Ray ray) {
        // shift the ray origin to align with the cone's apex at the origin, found this worked the best
        PVector O = PVector.sub(ray.origin, apex);
        PVector D = ray.direction;

        float dx = D.x;
        float dy = D.y;
        float dz = D.z;

        float ox = O.x;
        float oy = O.y;
        float oz = O.z;

        float kSquared = k * k;

        // quadratic coefficients
        float a = dx * dx + dz * dz - kSquared * dy * dy;
        float b = 2 * (dx * ox + dz * oz - kSquared * dy * oy);
        float c = ox * ox + oz * oz - kSquared * oy * oy;

        // Solve quadratic a*t^2 + b*t + c = 0
        float discriminant = b * b - 4 * a * c;

        if (discriminant < 0) {
            // ray miss the cone
            return null;
        }

        float sqrtDisc = sqrt(discriminant);
        float t1 = (-b - sqrtDisc) / (2 * a);
        float t2 = (-b + sqrtDisc) / (2 * a);

        // get the smallest positive t
        float t = Float.MAX_VALUE;
        if (t1 > 0 && t1 < t) {
            t = t1;
        }
        if (t2 > 0 && t2 < t) {
            t = t2;
        }
        if (t == Float.MAX_VALUE) {
            return null; // no valid intersection
        }

        // calc the intersection point
        PVector intersectionPoint = PVector.add(ray.origin, PVector.mult(ray.direction, t));

        PVector P = PVector.sub(intersectionPoint, apex);
        PVector normal = new PVector(P.x, -kSquared * P.y, P.z).normalize();

        return new IntersectionResult(t, intersectionPoint, normal, this);
    }
}
