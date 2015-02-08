package 
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author rkardashov@gmail.com
	 */
	public class SoundController 
	{
		private var channel:SoundChannel;
		private var transform:SoundTransform;
		
		public function SoundController(soundID: String) 
		{
			channel = Assets.playSound(soundID);
			/*if (channel)
				channel.stop();*/
			transform = new SoundTransform();
		}
		
		public function get volume(): Number
		{
			return transform.volume;
		}
		public function set volume(v: Number): void
		{
			transform.volume = v;
			if (channel)
				channel.soundTransform = transform;
		}
	}
}
