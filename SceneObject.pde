// SceneObject.pde

abstract class SceneObject {
    Material material;

    SceneObject(Material material) {
        this.material = material;
    }

    abstract IntersectionResult intersect(Ray ray);
}
