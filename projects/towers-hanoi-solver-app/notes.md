# Notes related to what I learned while completing this

I used the opportunity to play around with generator functions, so that I could create an iterable that let me do this:

```js
for (let move of hanoi(discs)) {
  animate(move);
}
```

See [this gist](https://gist.github.com/thancock20/99b90a67d58308ae83d7054742d09296) for more on that. Especially the earlier revisions of the function.

Of course, that for loop above actually ran all the moves at once. In order to slow it down, I had to use `setTimeout()`. Like this:

```js
let i = 0;
for (let move of hanoi(discs)) {
  const tick = () => { animate(move) };
  setTimeout(tick, 500 * i++);
}
```

I set up Webpack from scratch to use Babel on the JavaScript, and to compile Stylus into CSS. I also used the Webpack Dev Server for development.

One thing I have trouble with is remembering to us `run` for npm scripts. That is `npm run build` and not just `npm build`.

I also decided to use vanilla JavaScript for DOM manipulation. So, I spent quite a bit of time on MDN, looking up `queryselector()`, `element.onclick`, `element.oninput`, `element.classList`, and `element.disabled`.
