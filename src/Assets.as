package 
{
	import flash.display.Bitmap;
	import flash.media.Sound;
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
		[Embed(source = "../assets/atlas_0.png")]
		static private const _atlas_bitmap_0: Class;
		[Embed(source = "../assets/atlas_0.xml", mimeType="application/octet-stream")]
		static private const _atlas_xml_0: Class;
		//static private var _atlas_0: TextureAtlas;
		
		[Embed(source = "../assets/atlas_1.png")]
		static private const _atlas_bitmap_1: Class;
		[Embed(source = "../assets/atlas_1.xml", mimeType="application/octet-stream")]
		static private const _atlas_xml_1: Class;
		//static private var _atlas_anim: TextureAtlas;
		
		[Embed(source = "../assets/atlas_2.png")]
		static private const _atlas_bitmap_2: Class;
		[Embed(source = "../assets/atlas_2.xml", mimeType="application/octet-stream")]
		static private const _atlas_xml_2: Class;
		
		static private var _atlases:Vector.<TextureAtlas>;
		
		[Embed(source = "../assets/fonts/systematic_9.fnt", mimeType="application/octet-stream")]
		static private const font_systematic_9_xml: Class;
		
		/*[Embed(source = "../../assets/fonts/arcade/bitmapfont/arcade_0.png")]
		static private const _font_bmp_arcade: Class;*/
		[Embed(source = "../assets/fonts/arcade_10.fnt", mimeType="application/octet-stream")]
		static private const font_arcade_10_xml: Class;
		
		
		/*public static const SOUND_SCAN: String = "scan";
		public static const SOUND_BAG: String = "bag";
		public static const SOUND_BAG_LONG: String = "bag_long";
		
		[Embed(source = "../../assets/sounds/actions/scan.mp3")]
		private static const _SOUND_SCAN: Class;
		
		[Embed(source = "../../assets/sounds/actions/bag/bag_long.mp3")]
		private static const _SOUND_BAG_LONG: Class;
		
		[Embed(source = "../../assets/sounds/actions/bag/bag_0.mp3")]
		private static const _SOUND_BAG_0: Class;
		[Embed(source = "../../assets/sounds/actions/bag/bag_1.mp3")]
		private static const _SOUND_BAG_1: Class;
		[Embed(source = "../../assets/sounds/actions/bag/bag_2.mp3")]
		private static const _SOUND_BAG_2: Class;
		[Embed(source = "../../assets/sounds/actions/bag/bag_3.mp3")]
		private static const _SOUND_BAG_3: Class;*/
		public static const SOUND_SUPERMARKET: String = "supermarket";
		[Embed(source = "../assets/sounds/219533__pulswelle__supermarket.mp3")]
		private static const _SOUND_SUPERMARKET: Class;
		
		private static const _sounds: Object = { };
		
		public function Assets() 
		{
			
		}
		
		/*static private function getAtlas(): TextureAtlas
		{
			if (!_atlas)
				_atlas = new TextureAtlas(
					Texture.fromEmbeddedAsset(_atlas_bitmap),
					new XML(new _atlas_xml())
					);
			return _atlas;
		}*/
		
		static public function getTexture(textureName: String): Texture 
		{
			//return getAtlas().getTexture(textureName);
			var t: Texture;
			for (var i:int = 0; i < _atlases.length; i++) 
			{
				t = _atlases[i].getTexture(textureName);
				if (t)
					return t;
			}
			return null;
		}
		
		static public function getTextures(textureNamePrefix: String): Vector.<Texture> 
		{
			//return getAtlas().getTextures(textureNamePrefix);
			var t: Vector.<Texture>;
			for (var i:int = 0; i < _atlases.length; i++) 
			{
				t = _atlases[i].getTextures(textureNamePrefix);
				if (t && t.length > 0)
					return t;
			}
			return null;
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
			//return new MovieClip(getAnimAtlas().getTextures(texturePrefix));
			var t: Vector.<Texture> = getTextures(texturePrefix);
			if (t)
				return new MovieClip(t);
			return null;
		}
		
		static public function init():void 
		{
			_atlases = new Vector.<TextureAtlas>();
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
			//var texture:Texture = Texture.fromBitmap(new _font_bmp_arcade());
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
			
			_sounds[SOUND_SUPERMARKET] = new _SOUND_SUPERMARKET();
		}
		
		static public function playSound(soundID: String): void 
		{
			if (_sounds[soundID])
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
			}
		}
		
		/*static private function getAnimAtlas(): TextureAtlas
		{
			if (!_atlas_anim)
				_atlas_anim = new TextureAtlas(
					Texture.fromEmbeddedAsset(_atlas_anim_bitmap),
					new XML(new _atlas_anim_xml())
					);
			return _atlas_anim;
		}*/
	}
}
