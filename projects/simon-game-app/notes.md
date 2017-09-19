# Notes related to what I learned while completing the Simon Game

I set up Babel, Webpack, Jest, and Eslint from scratch. I should probably set them up once more, and save that as a boilerplate on GitHub.

One way to do *How to Design Programs* in JavaScript is to use JSDoc to comment on variables and functions.  This actually maps fairly well using DOM events instead of `bigbang`.

Utilizing the Audio API to play frequencies, rather than mp3s, saves a lot of bandwidth. Which is very good for games on mobile:

```js
const context = new (window.AudioContext || window.webkitAudioContext)();

export default sound => {
  // sounds[sound].play();
  const osc = context.createOscillator();
  osc.frequency.value = SOUNDS[sound];
  osc.type = 'square';
  osc.connect(context.destination);
  osc.start(0);

  const stop = () => {
    osc.stop();
  };
  return { stop };
};
```

Also good for mobile is adding touch events just before mouse events in the code:

```js
simonButtons.addEventListener('touchstart', handleSimonButtonsDown);
simonButtons.addEventListener('mousedown', handleSimonButtonsDown);
```

```js
simonButtons.addEventListener('touchend', handleSimonButtonsUp);
simonButtons.addEventListener('mouseup', handleSimonButtonsUp);
simonButtons.addEventListener('mouseout', handleSimonButtonsUp);
```

Then, the event handler needs to call `event.preventDefault()` so that it doesn't run more than once for each event.

I wanted to stick to vanilla JS (ES2015+) as much as possible, so no outside libraries were used. I can definitely see how something like Redux or MobX can keep state management from quickly getting out of hand.
