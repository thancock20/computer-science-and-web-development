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
* [Complex Selectors](#complex-selectors)

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

## Complex Selectors

| Example                         | Classification                 | Explanation                                                                                                                                 |
|:--------------------------------|:-------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------|
| `h1`                            | Type Selector                  | Selects an element by it's type                                                                                                             |
| `.tagline`                      | Class Selector                 | Selects an element by the class attribute value, which may be reused multiple times per page                                                |
| `#intro`                        | ID Selector                    | Selects an element by the ID attribute value, which is unique and to only be used once per page                                             |
| `article h2`                    | Descendant Selector            | Selects an element that resides anywhere within an identified ancestor element                                                              |
| `article > p`                   | Direct Child Selector          | Selects an element that resides immediately inside an identified parent element                                                             |
| `h2 ~ p`                        | General Sibling Selector       | Selects an element that follows anywhere after the prior element, in which both parents share the same parent                               |
| `h2 + p`                        | Adjacent Sibling Selector      | Selects an element that follows directly after the prior element, in which both elements share the same parent                              |
| `a[target]`                     | Attribute Present Selector     | Selects an element if the given attribute is present                                                                                        |
| `a[href="http://google.com/"]`  | Attribute Equals Selector      | Selects an element if the given attribute value exactly matches the value stated                                                            |
| `a[href*="login"]`              | Attribute Contains Selector    | Selects an element if the given attribute value contains at least one instance of the value stated                                          |
| `a[href^="https://"]`           | Attribute Begins With Selector | Selects an element if the given attribute value begins with the value stated                                                                |
| `a[href$=".pdf"]`               | Attribute Ends With Selector   | Selects an element if the given attribute value ends with the value stated                                                                  |
| `a[rel~="tag"]`                 | Attribute Spaced Selector      | Selects an element if the given attribute value is whitespace-separated with one word being exactly stated                                  |
| <code>a[lang&#124;="en"]</code> | Attribute Hyphenated Selector  | Selects an element if the given attribute value is hyphen-separated and begins with the word stated                                         |
| `a:link`                        | Link Pseudo-class              | Selects a link that has not been visited by a user                                                                                          |
| `a:visited`                     | Link Pseudo-class              | Selects a link that has been visited by a user                                                                                              |
| `a:hover`                       | Action Pseudo-class            | Selects an element when a user has hovered their cursor over it                                                                             |
| `a:active`                      | Action Pseudo-class            | Selects an element when a user has engaged it                                                                                               |
| `a:focus`                       | Action Pseudo-class            | Selects an element when a user has made it their focus point                                                                                |
| `input:enabled`                 | State Pseudo-class             | Selects an element in the default enabled state                                                                                             |
| `input:disabled`                | State Pseudo-class             | Selects an element in the disabled state, by way of the disabled attribute                                                                  |
| `input:checked`                 | State Pseudo-class             | Selects a checkbox or radio button that has been checked                                                                                    |
| `input:indeterminate`           | State Pseudo-class             | Selects a checkbox or radio button that has neither been checked or unchecked, leaving it in an indeterminate state                         |
| `li:first-child`                | Structural Pseudo-class        | Selects an element that is the first within a parent                                                                                        |
| `li:last-child`                 | Structural Pseudo-class        | Selects an element that is the last within a parent                                                                                         |
| `div:only-child`                | Structural Pseudo-class        | Selects an element that is the only element within a parent                                                                                 |
| `p:first-of-type`               | Structural Pseudo-class        | Selects an element that is the first of it's type within a parent                                                                           |
| `p:last-of-type`                | Structural Pseudo-class        | Selects an element that is the last of it's type within a parent                                                                            |
| `img:only-of-type`              | Structural Pseudo-class        | Selects an element that is the only of it's type within a parent                                                                            |
| `li:nth-child(2n+3)`            | Structural Pseudo-class        | Selects an element that mathces the given number or expression, counting all elements from the beginning of the document tree               |
| `li:nth-last-child(3n+2)`       | Structural Pseudo-class        | Selects an element that matches the given number of expression, counting all elements from the end of the document tree                     |
| `p:nth-of-type(3n)`             | Structural Pseudo-class        | Selects an element that matches the given number or expression, counting only elements of it's type from the beginning of the document tree |
| `p:nth-last-of-type(2n+1)`      | Structural Pseudo-class        | Selects an element that matches the given number or expression, counting only elements of it's type from the end of the document tree       |
| `section:target`                | Target Pseudo-class            | Selects an element whose ID attribute matches that of the URI fragment identifier                                                           |
| `div:empty`                     | Empty Pseudo-class             | Selects an element that does not contain any children or text nodes                                                                         |
| `div:not(.awesome)`             | Negation Pseudo-class          | Selects an element not represented by the stated argument                                                                                   |
| `.alpha::first-letter`          | Textual Pseudo-element         | Selects the first letter of text within an element                                                                                          |
| `.bravo::first-line`            | Textual Pseudo-element         | Selects the first line of text within an element                                                                                            |
| `div::before`                   | Generated Content              | Creates a pseudo-element inside the selected element at the beginning                                                                       |
| `a::after`                      | Generated Content              | Creates a pseudo-element inside the selected element at the end                                                                             |
| `::selection`                   | Fragment Pseudo-element        | Selects the part of a document which has been selected, or highlighted, by a users actions                                                  |
