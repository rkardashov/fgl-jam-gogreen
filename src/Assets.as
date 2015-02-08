package 
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author ...
	 */
	public class Assets 
	{
		static private var _manager:AssetManager;
		static private var onLoadComplete:Function;
		
		public function Assets() 
		{
			
		}
		
		static public function init(onLoadComplete: Function): void 
		{
			Assets.onLoadComplete = onLoadComplete;
			_manager = new AssetManager();
			_manager.enqueue(EmbeddedAssets);
			_manager.loadQueue(onLoadingProgress);
			/*_atlases = new Vector.<TextureAtlas>();
			_atlases.push(new TextureAtlas(
				Texture.fromEmbeddedAsset(_atlas_bitmap_0),
				new XML(new _atlas_xml_0())
				));
			_atlases.push(new TextureAtlas(
				Texture.fromEmbeddedAsset(_atlas_bitmap_1),
				new XML(new _atlas_xml_1())
				));
			_atlases.push(new TextureAtlas(
				Texture.fromEmbeddedAsset(_atlas_bitmap_2),
				new XML(new _atlas_xml_2())
				));
				
			var texture: Texture;
			var xml: XML;
			var fontnames: Array = ["arcade_10", "systematic_9"];
			for each(var fontname: String in fontnames)
			{
				texture = getTexture("fonts/" + fontname);
				xml = XML(new Assets["font_" + fontname + "_xml"]());
				if (texture && xml)
					TextField.registerBitmapFont(new BitmapFont(texture, xml))
				else 
					trace("cannot register the font: " + fontname);
			}
			
			_sounds[SOUND_SUPERMARKET] = new _SOUND_SUPERMARKET();*/
		}
		
		static private function onLoadingProgress(progress: Number): void 
		{
			//trace("loaded: " + int(progress * 100));
			if (progress >= 1.0)
				onLoadComplete();
		}
		
		static public function getTexture(textureName: String): Texture 
		{
			/*var t: Texture;
			for (var i:int = 0; i < _atlases.length; i++) 
			{
				t = _atlases[i].getTexture(textureName);
				if (t)
					return t;
			}
			return null;*/
			return _manager.getTexture(textureName);
		}
		
		static public function getTextures(textureNamePrefix: String): Vector.<Texture> 
		{
			/*var t: Vector.<Texture>;
			for (var i:int = 0; i < _atlases.length; i++) 
			{
				t = _atlases[i].getTextures(textureNamePrefix);
				if (t && t.length > 0)
					return t;
			}
			return null;*/
			return _manager.getTextures(textureNamePrefix);
		}
		
		static public function getImage(textureName: String = ""): Image
		{
			var tex: Texture = getTexture(textureName);
			if (!tex)
				return null;
			var img: Image = new Image(tex);
			img.smoothing = TextureSmoothing.BILINEAR;// NONE;
			return img;
		}
		
		static public function getAnim(texturePrefix: String): MovieClip
		{
			var t: Vector.<Texture> = getTextures(texturePrefix);
			if (t)
				return new MovieClip(t);
			return null;
		}
		
		static public function playSound(soundID:String, loop:Boolean = false):SoundChannel
		{
			/*if (_sounds[soundID])
			{
				//if (_sounds[soundID].isPrototypeOf(Array))
				if (_sounds[soundID] as Array)
				{
					var i: int = (_sounds[soundID] as Array).length;
					i = Math.random() * i;
					Sound((_sounds[soundID] as Array)[i]).play();
				}
				else
					Sound(_sounds[soundID]).play();
			}*/
			return _manager.playSound(soundID, 0, loop ? int.MAX_VALUE : 1);
		}
		
		static public function getSound(soundID: String): Sound
		{
			return _manager.getSound(soundID);
		}
	}
}
