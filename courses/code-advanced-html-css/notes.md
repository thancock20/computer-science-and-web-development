# Notes for Code Advanced HTML & CSS


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Performance & Organization](#performance-organization)
  * [Strategy & Structure](#strategy-structure)
  * [Performance Driven Selectors](#performance-driven-selectors)
  * [Reusable Code](#reusable-code)
  * [Minify & Compress Files](#minify-compress-files)
  * [Reduce HTTP Requests](#reduce-http-requests)
* [Detailed Positioning](#detailed-positioning)
  * [Containing Floats](#containing-floats)
  * [Fixed Footer](#fixed-footer)
  * [z-index Property](#z-index-property)

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

## Detailed Positioning

### Containing Floats

HTML
```html
<div class="box-set">
  <figure class="box">Box 1</figure>
  <figure class="box">Box 2</figure>
  <figure class="box">Box 3</figure>
</div>
```

CSS
```css
.box-set {
  background: #eaeaed; /* will have height of 0 */
}

.box {
  background: #2db34a;
  float: left;
  margin: 1.858736059%;
  width: 29.615861214%
}
```

In order to see the `.box-set`, there are 2 possible techniques:
1. Use `overflow: auto`
2. Use [Clearfix](../../courses/code-html-css/notes.md#clearfix) (for simplified clearfix see [Resume Clone Notes](../../projects/resume-clone-app/notes.md))

### Fixed Footer

HTML
```html
<footer>Fixed Footer</footer>
```

CSS
```css
body {
  background: #eacaed;
}

footer {
  background: #2db34a;
  bottom: 0;
  left: 0;
  position: fixed;
  right: 0;
}
```

### z-index Property

`z-index` can only be used with a `position` value of `relative`, `absolute`, or `fixed`.

When stacking elements, the highest `z-index` appears on top.
