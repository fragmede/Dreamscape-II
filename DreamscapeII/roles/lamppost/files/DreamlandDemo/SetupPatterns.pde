class LampPostBarIterator extends DLPattern
{
	private final BasicParameter num = new BasicParameter("num" ,0 ,0 ,6);
	private final SawLFO counter = new SawLFO(0, 6, 1000);

	public LampPostBarIterator(LX lx)
	{
		super(lx);
		addParameter(num);
		addModulator(counter).trigger();
	}

	public void run(double deltaMs) 
	{
		for (LampPost lp : model.lampPosts)
		{
			for(int i = 0; i < 7; i ++)
			{
				for(LXPoint p : lp.bars.get(i).points)
				{
					colors[p.index] = LXColor.BLACK;
				}
			}
			for (LXPoint p : lp.bars.get((int) num.getValuef()).points)
			{
				colors[p.index] = LXColor.WHITE;
			}
		}
	}
}



class LampPostBarPointIterator extends DLPattern
{
	private final BasicParameter num = new BasicParameter("num" ,0 ,0 ,6);
	private final BasicParameter pointNum = new BasicParameter("point" ,0 ,0 ,18);

	public LampPostBarPointIterator(LX lx)
	{
		super(lx);
		addParameter(num);
		addParameter(pointNum);
	}

	public void run(double deltaMs) 
	{
		// List<LampPost> c = model.lampPosts;

		for (LampPost c : model.lampPosts)
		{
			for(int i = 0; i < 6; i ++)
			{
				for(LXPoint p : c.bars.get(i).points)
				{
					colors[p.index] = LXColor.BLACK;
				}
			}
			List<LXPoint> bar = c.bars.get((int) num.getValuef()).points;

			// for(LXPoint bar : c.bars.get((int) num.getValuef()).points)
			// {
				for(int i = 0; i < 18; i ++)
				{
					for(LXPoint p : bar)
					{
						colors[p.index] = LXColor.BLACK;
					}
				colors[bar.get((int) pointNum.getValuef()).index] = LXColor.WHITE;
				// }
			}
		}
	}
}

class LampPostRing extends DLPattern
{
	private final BasicParameter speed = new BasicParameter("speed", 2000, 10000, 100);
	private final BasicParameter dist = new BasicParameter("dist", 100, 1, 1000);
	private final TriangleLFO triangle = new TriangleLFO(0, 19, speed);

	public LampPostRing(LX lx)
	{
		super(lx);
		addParameter(speed);
		addParameter(dist);
		addModulator(triangle).trigger();
	}

	public void run(double deltaMs)
	{
		for(LampPost lp : model.lampPosts)
		{
			for(int i = 0; i < 7; i ++)
			{
				for(LXPoint p : lp.bars.get(i).points)
				{
					colors[p.index] = LXColor.BLACK;
				}
			}
		}

		for(LampPost lp : model.lampPosts)
			{
			for(int i = 0; i < 7; i ++)
			{
				List<LXPoint> bar = lp.bars.get(i).points;
				for(int ii = 0; ii < 18; ii ++)
				{
					for(LXPoint p : bar)
					{
						float bv = max(0, dist.getValuef() - abs(p.y - triangle.getValuef()));
						colors[p.index] = lx.hsb(100,100,bv);
					}
				colors[bar.get((int) triangle.getValuef()).index] = LXColor.WHITE;
				// colors[bar.get((int) triangle.getValuef()).index] = lx.hsb(100,100,bv);
				}
			}
		}
	}
}