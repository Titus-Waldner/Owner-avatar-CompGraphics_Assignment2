// CompositeObject.pde


// This was created to help with the construction of the pikmin entity

class CompositeObject extends SceneObject {
    ArrayList<SceneObject> components;

    CompositeObject(Material material) {
        super(material);
        components = new ArrayList<SceneObject>();
    }

    void addComponent(SceneObject obj) {
        components.add(obj);
    }

    @Override
    IntersectionResult intersect(Ray ray) {
        float closestT = Float.MAX_VALUE;
        IntersectionResult closestResult = null;

        for (SceneObject obj : components) {
            IntersectionResult result = obj.intersect(ray);
            if (result != null && result.t < closestT) {
                closestT = result.t;
                closestResult = result;
            }
        }

        return closestResult;
    }
}
