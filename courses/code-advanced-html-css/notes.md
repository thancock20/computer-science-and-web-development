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
* [Responsive Web Design](#responsive-web-design)
  * [Viewport Meta Tag](#viewport-meta-tag)
  * [Flexible Layouts](#flexible-layouts)
  * [Media Queries](#media-queries)
  * [Flexible Media](#flexible-media)
* [Transforms](#transforms)
* [Transitions](#transitions)
* [Animations](#animations)
* [Feature Support & Polyfills](#feature-support-polyfills)
* [Cross Browser Testing](#cross-browser-testing)
* [Semantics & Accessibility](#semantics-accessibility)
  * [Microdata](#microdata)
  * [WAI-ARIA](#wai-aria)

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

## Responsive Web Design

### Viewport Meta Tag

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

### Flexible Layouts

Relative viewport lengths:
* `vw`: 1% of the width of the viewport.
* `vh`: 1% of the height of the viewport.
* `vmin`: The smaller of `vw` or `vh`.
* `vmax`: The larger of `vw` or `vh`.

Formula to identify the proportions of a flexible layout using relative values:
```
target / context = result
```

HTML
```html
<div class="container">
  <section>...</section>
  <aside>...</aside>
</div>
```

CSS - non-flexible
```css
.container {
  width: 538px;
}

section,
aside {
  margin: 10px;
}

section {
  float: left;
  width: 340px;
}

aside {
  float: right;
  width: 158px;
}
```

CSS - flexible
```css
.container {
  width: 538px;
}

section,
aside {
  margin: 1.858736059%; /* 10px / 538px = .018587361 */
}

section {
  float: left;
  width: 63.197026%; /* 340px / 538px = .63197026 */
}

aside {
  float: right;
  width: 29.3680297%; /* 158px / 538px = .293680297 */
}
```

### Media Queries

CSS - media queries (mobile first)
```css
section,
aside {
  margin: 1.858736059%
}

@media all and (min-width: 420px) {
  .container {
    max-width: 538px;
  }
  section {
    float: left;
    width: 63.197026%;
  }

  aside {
    float: right;
    width: 29.3680297%;
  }
}
```

* Media Types:
  * `all`
  * `screen` - default if not specified
  * `print`
  * `tv`
  * `braille`
* Logical Operators:
  * `and` - no `or` but comma separated works that way
  * `not`
  * `only`
* Media Features:
  * Prefixes:
    * `min` - greater than or equal to
    * `max` - less than or equal to
  * `height`
  * `width`
  * `device-height`
  * `device-width`
  * `aspect-ratio`
  * `device-aspect-ratio`
  * `pixel-ratio`
  * `device-pixel-ratio`
  * `resolution`
  * `orientation` - must be `landscape` or `portrait`

Examples:

```css
@media all and (max-width: 1024px) {}

@media all and (min-width: 800px) and (max-width: 1024px) {}

@media not screen and (color) {}

@media only screen and (orientation: portrait) {}

@media all and (min-device-aspect-ratio: 16/9) {}

@media only screen and (-webkit-min-device-pixel-ratio: 1.3), only screen and (min-device-pixel-ratio: 1.3) {}
```

### Flexible Media

Quick way to make media flexible:

```css
img, video, canvas {
  max-width: 100%;
}
```

Workaround for embedded media:

HTML
```html
<figure>
  <iframe src="https://www.youtube.com/embed/4Fqg43ozz7A"></iframe>
</figure>
```

CSS
```css
figure {
  height: 0;
  padding-bottom: 56.25%; /* 16:9 - 9 / 16 * 100 */
  position: relative;
  width: 100%;
}

iframe {
  height: 100%;
  left: 0
  position: absolute;
  top: 0;
  width: 100%;
}
```

## Transforms

```
/* Keyword values */
transform: none;

/* Function values */
transform: matrix(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
transform: translate(12px, 50%);
transform: translateX(2em);
transform: translateY(3in);
transform: scale(2, 0.5);
transform: scaleX(2);
transform: scaleY(0.5);
transform: rotate(0.5turn);
transform: skew(30deg, 20deg);
transform: skewX(30deg);
transform: skewY(1.07rad);
transform: matrix3d(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);
transform: translate3d(12px, 50%, 3em);
transform: translateZ(2px);
transform: scale3d(2.5, 1.2, 0.3);
transform: scaleZ(0.3);
transform: rotate3d(1, 2.0, 3.0, 10deg);
transform: rotateX(10deg);
transform: rotateY(10deg);
transform: rotateZ(10deg);
transform: perspective(17px);

/* Multiple function values */
transform: translateX(10px) rotate(10deg) translateY(5px);

/* Global values */
transform: inherit;
transform: initial;
transform: unset;
```

```
/* One-value syntax */
transform-origin: 2px;
transform-origin: bottom;

/* x-offset y-offset */
transform-origin: 3cm 2px;

/* y-offset x-offset-keyword */
transform-origin: 2px left;

/* x-offset-keyword y-offset */
transform-origin: left 2px;

/* x-offset-keyword y-offset-keyword */
transform-origin: right top;

/* y-offset-keyword x-offset-keyword */
transform-origin: top right;

/* x-offset y-offset z-offset */
transform-origin: 2px 30% 10px;

/* y-offset x-offset-keyword z-offset */
transform-origin: 2px left 10px;

/* x-offset-keyword y-offset z-offset */
transform-origin: left 5px -3px;

/* x-offset-keyword y-offset-keyword z-offset */
transform-origin: right bottom 2cm;

/* y-offset-keyword x-offset-keyword z-offset */
transform-origin: bottom right 2cm;

/* Global values */
transform-origin: inherit;
transform-origin: initial;
transform-origin: unset;
```

```
/* Keyword value */
perspective: none;

/* <length> values */
perspective: 20px;
perspective: 3.5em;

/* Global values */
perspective: inherit;
perspective: initial;
perspective: unset;
```

```
/* One-value syntax */
perspective-origin: x-position;

/* Two-value syntax */
perspective-origin: x-position y-position;

/* When both x-position and y-position are keywords,
   the following is also valid */
perspective-origin: y-position x-position;

/* Global values */
perspective-origin: inherit;
perspective-origin: initial;
perspective-origin: unset;
```

```
/* Keyword values */
backface-visibility: visible;
backface-visibility: hidden;

/* Global values */
backface-visibility: inherit;
backface-visibility: initial;
backface-visibility: unset;
```

Needs the demos, so check out the [page](http://learn.shayhowe.com/advanced-html-css/css-transforms/).

Also see the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Transforms).

## Transitions

```
/* Apply to 1 property */
/* property name | duration */
transition: margin-left 4s;

/* property name | duration | delay */
transition: margin-left 4s 1s;

/* property name | duration | timing function | delay */
transition: margin-left 4s ease-in-out 1s;

/* Apply to 2 properties */
transition: margin-left 4s, color 1s;

/* Apply to all changed properties */
transition: all 0.5s ease-out;

/* Global values */
transition: inherit;
transition: initial;
transition: unset;
```

Needs the demos, so check out the [page](http://learn.shayhowe.com/advanced-html-css/transitions-animations/).

Also see the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Transitions).

## Animations

```css
@keyframes slidein {
  from {
    margin-left: 100%;
    width: 300%;
  }

  to {
    margin-left: 0%;
    width: 100%;
  }
}
```

```
/* @keyframes duration | timing-function | delay |
iteration-count | direction | fill-mode | play-state | name */
animation: 3s ease-in 1s 2 reverse both paused slidein;

/* @keyframes duration | timing-function | delay | name */
animation: 3s linear 1s slidein;

/* @keyframes duration | name */
animation: 3s slidein;
```

Needs the demos, so check out the [page](http://learn.shayhowe.com/advanced-html-css/transitions-animations/).

Also see the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Animations).

## Feature Support & Polyfills

* Use [HTML5 Shiv](https://github.com/afarkas/html5shiv) to add HTML5 elements to IE8 and below.

```html
<!-- [if lt IE 9]>
  <script src="html5shiv.js"></script>
<![endif]-->
```

* Use [Modernizr](http://modernizr.com/) to write conditional CSS and JavaScript based on whether or not a browser supports a specific feature.

## Cross Browser Testing

Use Virtual Machines for Internet Explorer: [Automated Installer](http://learn.shayhowe.com/advanced-html-css/feature-support-polyfills/).

To get dev tools in IE7 and below, use the [Firebug Lite](https://getfirebug.com/firebuglite#Stable) bookmarklet.

## Semantics & Accessibility

```html
<!-- Hiding content - good -->
<div hidden>...</div>

<!-- Hiding content - not good -->
<div style="display: none;">...</div>

<!-- Strong importance -->
<strong>Caution:</strong> Falling rocks.

<!-- Stylistically offset -->
This recipe calls for <b>bacon</b> and <b>baconnaise</b>

<!-- Stressed emphasis -->
I <em>love</em> Chicago!

<!-- Alternative voice or tone -->
The name <i>Shay</i> means a gift.

<!-- Added to the document -->
<ins cite="http://learn.shayhowe.com" datetime="2012-07-01">
  Updated: This website now contains an advanced guide.
</ins>

<!-- Unarticulated annotation -->
<u>Urushihara Yuuji</u> won <u>Sasuke 27</u>.

<!-- Deleted from the document -->
I am an avid cyclist, <del cite="http://shayhowe.com" datetime="2012-07-01">skateboarder</del> and designer.

<!-- No longer accurate or relevant -->
<s>$24.99</s> $19.99

<!-- Highlighted for reference purposes -->
Search results for <mark>'chicago'</mark>.

<!-- Abbreviations -->
<abbr title="HyperText Markup Language">HTML</abbr>
<abbr title="Cascading Style Sheets">CSS</abbr>

<!-- Subscript -->
H<sub>2</sub>O

<!-- Superscript -->
1<sup>st</sup> Place

<!-- Meter -->
<meter value="7" max="10">7 stars</meter>
<meter value="47" min="0" max="105" low="5" high="65" optimum="45">The car is moving at a decent average mile per hour.</meter>

<!-- Progress -->
You are <progress value="50" max="100">50%</progress> complete.
<progress value="50" min="0" max="100">Hold tight, you&#8217;re getting there.</progress>

<!-- Time -->
<time>2011-08-24</time>
<time datetime="2011-08-24" pubdate>August 24th, 2011</time>
<time datetime="15:00">3pm</time>
<time datetime="2011-08-24T15:00">August 24th, 2011 at 3pm</time>

<!-- Address -->
<address>
  <strong>Shaye Howe</strong><br>
  <a href="http://learn.shayhowe.com">http://learn.shayhowe.com</a><br>
  <a href="mailto:hello@awesome.com">hello@awesome.com</a><br>
  600 W. Chicago Ave.<br>
  Suite 620<br>
  Chicago, IL 60654<br>
  USA
</address>

<!-- Inline code samples -->
Use the <code>article</code> element.

<!-- Larger, block level code snippets -->
<pre><code>body {
  color: #666;
  font: 14px/20px Arial, sans-serif;
}</code></pre>

<!-- Line break -->
600 W. Chicago Ave.<br>
Chicago, IL 60654<br>
USA

<!-- Word break -->
http://shay<wbr>howe.com

<!-- Side comments or small print -->
<small>&copy; 2012 Shay Howe</small>
```

### Microdata

```html
<!-- Person microdata -->
<section itemscope itemtype="http://schema.org/Person">
  <strong itemprop="name">Shay Howe</strong>
  <img src="shay.jpg" itemprop="image" alt="Shay Howe">
  <div itemprop="jobTitle">Designer and Front-end Developer</div>
  <a href="http://www.shayhowe.com" itemprop="url">shayhowe.com</a>
  <div itemprop="telephone">(555) 123-4567</div>
  <a href="mailto:shay@awesome.com" itemprop="email">shay@awesome.com</a>
  <address itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
    <span itemprop="streetAddress">600 W. Chicago Ave.</span>
    <span itemprop="addressLocality">Chicago</span>,
    <abbr itemprop="addressRegion" title="Illinois">IL</abbr>
    <span itemprop="postalCode">60654</span>
  </address>
</section>

<!-- Event microdata -->
<section itemscope itemtype="http://schema.org/Event">
  <a itemprop="url" href="#">
    <span itemprop="name">Styles Conference</span>
  </a>
  <time itemprop="startDate" datetime="2014-08-2409:00">Sunday, August 24, 2014 at 9:00 a.m.</time>
  <div itemprop="location" itemscope itemtype="http://schema.org/Place">
    <a itemprop="url" href="http://www.thechicagotheatre.com/">Chicago Theatre</a>
    <address itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
      <div itemprop="streetAddress">175 N. State St.</div>
      <span itemprop="addressLocality">Chicago</span>,
      <abbr itemprop="addressRegion" title="Illinois">IL</abbr>
      <span itemprop="postalCode">60601</span>
    </address>
  </div>
</section>
```

### WAI-ARIA

**Document Structure Roles** (define the organizational structure of content on a page)
* `article`
* `columnheader`
* `definition`
* `directory`
* `document`
* `group`
* `heading`
* `img`
* `list`
* `listitem`
* `math`
* `note`
* `presentation`
* `region`
* `row`
* `rowheader`
* `separator`
* `toolbar`

**Landmark Roles** (define the regions of a page)
* `application`
* `banner`
* `complementary`
* `contentinfo`
* `form`
* `main`
* `navigation`
* `search`

| Element   | Implied Role    | Acceptable Roles                                                                                                                      |
|:----------|:----------------|:--------------------------------------------------------------------------------------------------------------------------------------|
| `article` | `article`       | `application`, `article`, `document`, or `main`                                                                                       |
| `aside`   | `complementary` | `complementary`, `note`, or `search`                                                                                                  |
| `footer`  | ---             | `contentinfo` (Only once per page)                                                                                                    |
| `header`  | ---             | `banner` (Only once per page)                                                                                                         |
| `nav`     | `navigation`    | `navigation`                                                                                                                          |
| `section` | `region`        | `alert`, `alertdialog`, `application`, `contentinfo`, `dialog`, `document`, `log`, `main`, `marquee`, `region`, `search`, or `status` |

```html
<header role="banner">
  <nav role="navigation">...</nav>
</header>
<article role="article">
  <section role="region">...</section>
</article>
<aside role="complementary">...</aside>
<footer role="contentinfo">...</footer>
```
