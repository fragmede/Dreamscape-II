/* Build FadeCandy output */

LXOutput output;

class DreamlandFadecandyOutput extends FadecandyOutput {
  DreamlandFadecandyOutput(LX lx, String host, int port) {
    super(lx, host, port);
  }
  
  protected void didDispose(Exception x) {
    println("Fadecandy connection failure: " + host + ":" + port + " - " + x.toString());  
  }
}

void buildOutputs()
{
  output = new LXOutputGroup(lx);
  output.enabled.setValue(false);
  lx.addOutput(output);
  output.addChild(new DreamlandFadecandyOutput(lx, "pi8.local", 7890));  // lamppost 1
  output.addChild(new DreamlandFadecandyOutput(lx, "pi16.local", 7890));  // lamppost 2
}
