// Overall dreamscape dimensions
private static final int LAMPPOST_RADIUS = 17*FEET + 2*INCHES;

// Lamp post parameters
private static final int NUMBER_OF_LAMPPOSTS = 2;
private static final int BOTTOM_OF_LP_LED = 54;
private static final float LP_BAR_HEIGHT = 45.5;
private static final float LP_BAR_RADIUS = 2.5;
private static final int LP_NLEDS = 19;
private static final int LP_NBARS = 7;


public static class Model extends LXModel {  
  public final List<LampPost> lampPosts;
  
  public Model() {
    super(new Fixture());
    Fixture f = (Fixture) this.fixtures.get(0);
    this.lampPosts = Collections.unmodifiableList(f.lampPosts);
  }
  
  private static class Fixture extends LXAbstractFixture {
    private final List<LampPost> lampPosts = new ArrayList<LampPost>();
    
    Fixture() {
      // Build lamp posts
      for (int i = 0; i < NUMBER_OF_LAMPPOSTS; ++i) {
        LXTransform transform = new LXTransform();
        float theta = radians(180) * i;
        transform.push();
        transform.rotateY(radians(180) * i);
        transform.translate(LAMPPOST_RADIUS, 0, 0);
        LampPost lampPost = new LampPost(transform);
        addPoints(lampPost);
        this.lampPosts.add(lampPost);
      }
    }
  }
}


private static class LampPost extends LXModel {
  //private static int NBARS = 7;
  //private static int NLEDS = 19;

  public final List<Bar> bars;
  
  public LampPost(LXTransform transform) {
    super(new Fixture(transform));
    Fixture f = (Fixture) this.fixtures.get(0);
    this.bars = Collections.unmodifiableList(f.bars);
  }
  
  private static class Fixture extends LXAbstractFixture {

    private List<Bar> bars = new ArrayList<Bar>();

    Fixture(LXTransform transform) { 
      for (int i = 0; i < LP_NBARS; ++i) 
      {
        transform.push(); 
        transform.rotateY(TWO_PI / LP_NBARS * i);
        Bar bar = new Bar(transform);
        addPoints(bar);
        this.bars.add(bar);
        transform.pop();
      }
    }
  }

  private static class Bar extends LXModel {
  
    public Bar(LXTransform transform) {
      super(new Fixture(transform));
    }
    
    private static class Fixture extends LXAbstractFixture {
      Fixture(LXTransform transform) {
        final float spacing = LP_BAR_HEIGHT/ LP_NLEDS;
        transform.push();
        transform.translate(-LP_BAR_RADIUS, BOTTOM_OF_LP_LED, 0);
        for (int i = 0; i < LP_NLEDS; i++) {
          addPoint(new LXPoint(transform));
          transform.translate(0, spacing, 0);
        }
        transform.pop();
      }
    }
  }
}
