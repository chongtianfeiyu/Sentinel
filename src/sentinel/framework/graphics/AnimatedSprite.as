package sentinel.framework.graphics
{
	
	import sentinel.framework.BaseGame;
	import sentinel.framework.graphics.Texture;
	import starling.animation.Juggler;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	
	public class AnimatedSprite extends MovieClip implements IGraphics
	{
		
		private var _depth:int = 0;
		
		
		public function AnimatedSprite(textures:Vector.<sentinel.framework.graphics.Texture>, fps:int = 12)
		{
			var native:Vector.<starling.textures.Texture> = new <starling.textures.Texture>[];
			
			for each(var texture:sentinel.framework.graphics.Texture in textures)
			{
				native.push(texture.__base);
			}
			
			juggler.add(this);
			
			super(native, fps);
		}
		
		
		public function addTo(target:IGraphicsContainer):void
		{
			target.addChild(this);
		}
		
		
		public function deconstruct():void
		{
			juggler.remove(this);
			removeFromParent(true);
		}
		
		
		public function get depth():int { return _depth; }
		
		public function set depth(value:int):void
		{
			_depth = value;
			
			if (parent && (parent as IGraphicsContainer).autoSort)
			{
				(parent as IGraphicsContainer).sortChildrenByDepth();
			}
		}
		
		public function get atZero():Boolean { return x === 0 && y === 0 && rotation === 0; }
		public function get viewport():Viewport { return BaseGame.getInstance().viewport; }
		public function get juggler():Juggler { return BaseGame.getInstance().juggler; }
		
	}
	
}