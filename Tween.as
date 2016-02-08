package  {

    import flash.events.EventDispatcher;
    import flash.display.Shape;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;
    import flash.events.Event;

    public class Tween extends EventDispatcher {

        public  var object  :Object;
        public  var begin   :Object   = {};
        public  var end     :Object   = {};
        public  var duration:Number   = 1000;
        public  var delay   :Number   = 0;
        public  var ease    :Function = EASE;
        private var start   :Number;

        public function play():void {
            var i:String;
            for(i in begin) {
                if(!(i in end)) {
                    end[i] = object[i];
                }
            }
            for(i in end) {
                if(!(i in begin)) {
                    begin[i] = object[i];
                }
            }
            for(i in begin) {
                object[i] = begin[i];
            }
            if(delay == 0) {
                timeout();
            } else {
                setTimeout(timeout, delay);
            }
        }

        private function timeout():void {
            start = getTimer();
            shape.addEventListener(Event.ENTER_FRAME, enterFrame);
            dispatchEvent(new TweenEvent(TweenEvent.PLAY, 0));
        }

        private function enterFrame(e:Event):void {
            var elapsed:Number = (getTimer() - start) / duration;
            if(elapsed > 1) {
                elapsed = 1;
            }
            var progress:Number = ease(elapsed);
            for(var i:String in begin) {
                object[i] = begin[i] + (end[i] - begin[i]) * progress;
            }
            dispatchEvent(new TweenEvent(TweenEvent.PLAYING, progress));
            if(elapsed == 1) {
                shape.removeEventListener(Event.ENTER_FRAME, enterFrame);
                dispatchEvent(new TweenEvent(TweenEvent.PLAYED, 1));
            }
        }

        public static const EASE_LINEAR:Function = function(k:Number):Number {
            return k;
        };

        public static const EASE_QUADRATIC:Function = function(k:Number):Number {
            if ((k *= 2) < 1) {
                return 0.5 * k * k;
            }
            return - 0.5 * (--k * (k - 2) - 1);
        };

        public static const EASE_QUADRATIC_IN:Function = function(k:Number):Number {
            return k * k;
        };

        public static const EASE_QUADRATIC_OUT:Function = function(k:Number):Number {
            return k * (2 - k);
        };

        public static const EASE_CUBIC:Function = function(k:Number):Number {
            if ((k *= 2) < 1) {
                return 0.5 * k * k * k;
            }
            return 0.5 * ((k -= 2) * k * k + 2);
        };

        public static const EASE_CUBIC_IN:Function = function(k:Number):Number {
            return k * k * k;
        };

        public static const EASE_CUBIC_OUT:Function = function(k:Number):Number {
            return --k * k * k + 1;
        };

        public static const EASE_QUARTIC:Function = function(k:Number):Number {
            if ((k *= 2) < 1) {
                return 0.5 * k * k * k * k;
            }
            return - 0.5 * ((k -= 2) * k * k * k - 2);
        };

        public static const EASE_QUARTIC_IN:Function = function(k:Number):Number {
            return k * k * k * k;
        };

        public static const EASE_QUARTIC_OUT:Function = function(k:Number):Number {
            return 1 - (--k * k * k * k);
        };

        public static const EASE_QUINTIC:Function = function(k:Number):Number {
            if ((k *= 2) < 1) {
                return 0.5 * k * k * k * k * k;
            }
            return 0.5 * ((k -= 2) * k * k * k * k + 2);
        };

        public static const EASE_QUINTIC_IN:Function = function(k:Number):Number {
            return k * k * k * k * k;
        };

        public static const EASE_QUINTIC_OUT:Function = function(k:Number):Number {
            return --k * k * k * k * k + 1;
        };

        public static const EASE_SINUSOIDAL:Function = function(k:Number):Number {
            return 0.5 * (1 - Math.cos(Math.PI * k));
        };

        public static const EASE_SINUSOIDAL_IN:Function = function(k:Number):Number {
            return 1 - Math.cos(k * Math.PI / 2);
        };

        public static const EASE_SINUSOIDAL_OUT:Function = function(k:Number):Number {
            return Math.sin(k * Math.PI / 2);
        };

        public static const EASE_EXPONENTIAL:Function = function(k:Number):Number {
            if (k === 0) {
                return 0;
            }
            if (k === 1) {
                return 1;
            }
            if ((k *= 2) < 1) {
                return 0.5 * Math.pow(1024, k - 1);
            }
            return 0.5 * (- Math.pow(2, - 10 * (k - 1)) + 2);
        };

        public static const EASE_EXPONENTIAL_IN:Function = function(k:Number):Number {
            return k === 0 ? 0 : Math.pow(1024, k - 1);
        };

        public static const EASE_EXPONENTIAL_OUT:Function = function(k:Number):Number {
            return k === 1 ? 1 : 1 - Math.pow(2, - 10 * k);
        };

        public static const EASE_CIRCULAR:Function = function(k:Number):Number {
            if ((k *= 2) < 1) {
                return - 0.5 * (Math.sqrt(1 - k * k) - 1);
            }
            return 0.5 * (Math.sqrt(1 - (k -= 2) * k) + 1);
        };

        public static const EASE_CIRCULAR_IN:Function = function(k:Number):Number {
            return 1 - Math.sqrt(1 - k * k);
        };

        public static const EASE_CIRCULAR_OUT:Function = function(k:Number):Number {
            return Math.sqrt(1 - (--k * k));
        };

        public static const EASE_ELASTIC:Function = function(k:Number):Number {
            var s:Number;
            var a:Number = 0.1;
            var p:Number = 0.4;
            if (k === 0) {
                return 0;
            }
            if (k === 1) {
                return 1;
            }
            if (!a || a < 1) {
                a = 1;
                s = p / 4;
            } else {
                s = p * Math.asin(1 / a) / (2 * Math.PI);
            }
            if ((k *= 2) < 1) {
                return - 0.5 * (a * Math.pow(2, 10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / p));
            }
            return a * Math.pow(2, -10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / p) * 0.5 + 1;
        };

        public static const EASE_ELASTIC_IN:Function = function(k:Number):Number {
            var s:Number;
            var a:Number = 0.1;
            var p:Number = 0.4;
            if (k === 0) {
                return 0;
            }
            if (k === 1) {
                return 1;
            }
            if (!a || a < 1) {
                a = 1;
                s = p / 4;
            } else {
                s = p * Math.asin(1 / a) / (2 * Math.PI);
            }
            return - (a * Math.pow(2, 10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / p));
        };

        public static const EASE_ELASTIC_OUT:Function = function(k:Number):Number {
            var s:Number;
            var a:Number = 0.1;
            var p:Number = 0.4;
            if (k === 0) {
                return 0;
            }
            if (k === 1) {
                return 1;
            }
            if (!a || a < 1) {
                a = 1;
                s = p / 4;
            } else {
                s = p * Math.asin(1 / a) / (2 * Math.PI);
            }
            return (a * Math.pow(2, -10 * k) * Math.sin((k - s) * (2 * Math.PI) / p) + 1);
        };

        public static const EASE_BACK:Function = function(k:Number):Number {
            var s:Number = 1.70158 * 1.525;
            if ((k *= 2) < 1) {
                return 0.5 * (k * k * ((s + 1) * k - s));
            }
            return 0.5 * ((k -= 2) * k * ((s + 1) * k + s) + 2);
        };

        public static const EASE_BACK_IN:Function = function(k:Number):Number {
            var s:Number = 1.70158;
            return k * k * ((s + 1) * k - s);
        };

        public static const EASE_BACK_OUT:Function = function(k:Number):Number {
            var s:Number = 1.70158;
            return --k * k * ((s + 1) * k + s) + 1;
        };

        public static const EASE_BOUNCE:Function = function(k:Number):Number {
            if (k < 0.5) {
                return EASE_BOUNCE_IN(k * 2) * 0.5;
            }
            return EASE_BOUNCE_OUT(k * 2 - 1) * 0.5 + 0.5;
        };

        public static const EASE_BOUNCE_IN:Function = function(k:Number):Number {
            return 1 - EASE_BOUNCE_OUT(1 - k);
        };

        public static const EASE_BOUNCE_OUT:Function = function(k:Number):Number {
            if (k < (1 / 2.75)) {
                return 7.5625 * k * k;
            } else if (k < (2 / 2.75)) {
                return 7.5625 * (k -= (1.5 / 2.75)) * k + 0.75;
            } else if (k < (2.5 / 2.75)) {
                return 7.5625 * (k -= (2.25 / 2.75)) * k + 0.9375;
            } else {
                return 7.5625 * (k -= (2.625 / 2.75)) * k + 0.984375;
            }
        };

        public static const EASE_NONE:Function = EASE_LINEAR;

        public static const EASE:Function      = EASE_SINUSOIDAL;

        public static const EASE_IN:Function   = EASE_SINUSOIDAL_IN;

        public static const EASE_OUT:Function  = EASE_SINUSOIDAL_OUT;

        private static var _shape:Shape;

        private static function get shape():Shape {
            if(!_shape) {
                _shape = new Shape();
            }
            return _shape;
        }

    }
}
