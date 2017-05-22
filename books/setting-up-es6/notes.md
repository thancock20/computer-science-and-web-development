# Notes for Setting up ES6


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Quick Setup Repos](#quick-setup-repos)
  * [Browser setup: ES6 via webpack and Babel](#browser-setup-es6-via-webpack-and-babel)
  * [Node.js setup: Dynamically transpiled ES6 via Babel](#nodejs-setup-dynamically-transpiled-es6-via-babel)
  * [Node.js setup: Statically transpiled ES6 via Babel](#nodejs-setup-statically-transpiled-es6-via-babel)
* [Manual Setup & Configuration](#manual-setup-configuration)
  * [Configuration for Libraries](#configuration-for-libraries)
  * [Configuration for apps](#configuration-for-apps)

<!-- tocstop -->

## Quick Setup Repos

### Browser setup: ES6 via webpack and Babel

[webpack-babel-demo](https://github.com/rauschma/webpack-babel-demo)

### Node.js setup: Dynamically transpiled ES6 via Babel

[node-babel-dynamic-demo](https://github.com/rauschma/node-babel-dynamic-demo)

Good for command line apps and servers.

### Node.js setup: Statically transpiled ES6 via Babel

[node-babel-static-demo](https://github.com/rauschma/node-babel-static-demo)

Should be used for libraries. Also, faster startup than dynamic.

## Manual Setup & Configuration

Official Babel docs has [setup instructions](http://babeljs.io/docs/setup/) for several environments and tools.

### Configuration for Libraries

Use [babel-plugin-transform-runtime](http://babeljs.io/docs/plugins/transform-runtime/) and babel-runtime for Babel helpers and the Regenerator runtime if needed.

Import the standard library polyfill as a module from core.js.
```js
import * as core from `core-js/library`;

const mySet = new core.Set([1,2,3,2,1]);
const myArr= core.Array.from(mySet);
const myStr = core.String.repeat('*', 10);
```

### Configuration for apps

Use [babel-plugin-transform-runtime](http://babeljs.io/docs/plugins/transform-runtime/) and babel-runtime for Babel helpers and the Regenerator runtime if needed.

Import the standard library polyfill as globals from core.js.
```js
import `core.js/shim`;

const mySet = new Set([1,2,3,2,1]);
const myArr = Array.from(mySet);
const myStr = '*'.repeat(10);
```
