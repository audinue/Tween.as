# Tween.as

Dead simple tweening library for ActionScript 3.

While `fl.transitions.Tween` works pretty good but a little bit cumbersome to use, I have tried another ActionScript 3 tweening libraries such as *GreenSock* or *Eaze Tween* and they are somehow buggy in my AIR games and applications, even for a simple tweening.

## Example

```ActionScript
var tween:Tween = new Tween();
tween.object = symbol1;
tween.end = {scaleX: 2};
tween.play();
```

```ActionScript
var tween:Tween = new Tween();
tween.object = symbol1;
tween.begin = {scaleX: 0};
tween.duration = 2000;
tween.play();
```

```ActionScript
var tween:Tween = new Tween();
tween.object = symbol1;
tween.end = {scaleX: 2};
tween.addEventListener(TweenEvent.PLAY, function(e:TweenEvent):void {
  trace('Tween start playing.');
});
tween.addEventListener(TweenEvent.PLAYING, function(e:TweenEvent):void {
  trace('Tween playing.');
});
tween.addEventListener(TweenEvent.PLAYED, function(e:TweenEvent):void {
  trace('Tween finished playing.');
});
tween.play();
```
