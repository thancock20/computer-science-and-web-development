# Notes for Code Advanced HTML & CSS


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Performance & Organization](#performance-organization)
  * [Strategy & Structure](#strategy-structure)
  * [Performance Driven Selectors](#performance-driven-selectors)
  * [Reusable Code](#reusable-code)
  * [Minify & Compress Files](#minify-compress-files)
  * [Reduce HTTP Requests](#reduce-http-requests)

<!-- tocstop -->

## Performance & Organization

### Strategy & Structure

Possible style methodologies:
* [Object Oriented CSS (OOCSS)](http://oocss.org/)
* [Scalable & Modular Architecture for CSS (SMACSS)](http://smacss.com/)
* [CSS Bliss](https://github.com/gilbox/css-bliss)

### Performance Driven Selectors

* Keep Selectors Short

```css
/* Bad */
header nav ul li a {...}

/* Good */
.primary-link {...}

/* Bad */
button strong span {...}
button strong span .callout {...}

/* Good */
button span {...}
button .callout {...}
```

* Favor Classes

```css
/* Bad */
#container header nav {...}

/* Good */
.primary-nav {...}

/* Bad */
article.feat-post {...}
.feat-post {...}
```

### Reusable Code

```css
/* Bad */
.news {
  background: #eee;
  border-radius: 5px;
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, .25);
}
.social {
  background: #eee;
  border-radius: 5px;
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, .25);
}

/* Good */
.news,
.social {
  background: #eee;
  border-radius: 5px;
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, .25);
}

/* Even Better */
.modal {
  background: #eee;
  border-radius: 5px;
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, .25);
}
```

### Minify & Compress Files

* Use gzip for HTML, CSS, JavaScript, and so forth.
  * Included in [HTML5 Boilerplate](http://html5boilerplate.com/).
  * Can use the [Compression Webpack Plugin](https://github.com/webpack-contrib/compression-webpack-plugin)
* Image Compression
  * Mac: [ImageOptim](http://imageoptim.com/)
  * Windows: [PNGGauntlet](http://pnggauntlet.com/)
  * Linux: [Trimage](https://trimage.org/)
* Measuring Compression
  * Use the Chrome Dev-Tools Network tab.

### Reduce HTTP Requests

* Combine Like Files
* Use Image Sprites
* Use Image Data URIs
* Cache Common Files
