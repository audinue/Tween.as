package {

    import flash.events.Event;

    public class TweenEvent extends Event {

        public static const PLAY:String = 'play';

        public static const PLAYING:String = 'playing';

        public static const PLAYED:String = 'played';
        
        private var _progress:Number;

        public function TweenEvent(type:String, progress:Number) {
            super(type);
            _progress = progress;
        }
        
        public function get progress():Number {
            return _progress;
        }
    }
}
