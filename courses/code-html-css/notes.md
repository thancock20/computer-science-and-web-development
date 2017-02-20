# Notes for Learn To Code HTML & CSS


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [What are HTML & CSS](#what-are-html-css)
* [Common HTML Terms](#common-html-terms)
* [HTML Document Structure](#html-document-structure)
* [Common CSS Terms](#common-css-terms)
* [Working with Selectors](#working-with-selectors)
* [Referencing CSS in HTML](#referencing-css-in-html)
* [Semantics](#semantics)
* [Divisions and Spans](#divisions-and-spans)
* [Test-Based Elements](#test-based-elements)
  * [Headings](#headings)
  * [Paragraphs](#paragraphs)
  * [Bold Text](#bold-text)
  * [Italicize Text](#italicize-text)
* [Structurally Based Elements](#structurally-based-elements)
* [Creating Hyperlinks](#creating-hyperlinks)
  * [Relative & Absolute Paths](#relative-absolute-paths)
  * [Linking to an Email Address](#linking-to-an-email-address)
  * [Opening Links in a New Window](#opening-links-in-a-new-window)
  * [Linking to Parts of the Same Page](#linking-to-parts-of-the-same-page)
* [The Display Property](#the-display-property)
* [The Box Model](#the-box-model)
  * [Width](#width)
  * [Height](#height)
  * [Margin](#margin)
  * [Padding](#padding)
  * [Borders](#borders)
* [Positioning](#positioning)
  * [Positioning with Floats](#positioning-with-floats)
    * [Clearfix](#clearfix)
  * [Positioning with Inline-Block](#positioning-with-inline-block)
  * [Uniquely Positioning Elements](#uniquely-positioning-elements)
* [Typography](#typography)
  * [Adding Color to Text](#adding-color-to-text)
  * [Font Properties](#font-properties)
  * [Text Properties](#text-properties)
  * [Typography Properties Example](#typography-properties-example)
  * [Web Safe Fonts](#web-safe-fonts)
  * [Embedding Web Fonts](#embedding-web-fonts)

<!-- tocstop -->


## What are HTML & CSS

**HTML**: HyperText Markup Language. Gives content structure and meaning by defining that content as, for example, headings, paragraphs, or images.

**CSS**: Cascading Style Sheets. A presentation language created to style the appearance of content--using, for example, fonts or colors.

## Common HTML Terms

**Elements**: Designators that define the structure and content of objects within a page.

```html
<a>
```

**Tags**: Created by the use of less-than and greater-than angle brackets surrounding an element.

* Opening Tag: Marks the beginning of an element. e.g. `<div>`
* Closing Tag: Marks the end of an element. e.g. `</div>`

```html
<a>...</a>
```

**Atributes**: Properties used to provide addition information about an element. Defined within the opening tag, after an element's name.

```html
<a href="http://toddhancock.net/">Todd Hancock</a>
```

## HTML Document Structure

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Hello World</title>
  </head>
  <body>
    <h1>Hello World</h1>
    <p>This is a web page</p>
  </body>
</html>
```

## Common CSS Terms

**Selectors**: Designates exactly which element or elements within HTML to target and apply styles (such as color, size, and position) to.

```css
p { ... }
```

**Properties**: Determines the styles that will applied to the selected element.

```css
p {
  color: ...;
  font-size: ...;
}
```

**Values**: Determines the behavior of the properties.

```css
p {
  color: orange;
  font-size: 16px;
}
```

## Working with Selectors

**Type Selectors**: Select elements by their element type.

CSS
```css
div { ... }
```

HTML
```html
<div>...</div>
<div>...</div>
```

**Class Selectors**: Select elements based on the `class` attribute value.

CSS
```css
.awesome { ... }
```

HTML
```html
<div class="awesome">...</div>
<p class="awesome">...</p>
```

**ID Selectors**: Select element based on its `id` attribute value. Targets only one unique element at a time.

CSS
```css
#shayhowe { ... }
```

HTML
```html
<div id="shayhowe">...</div>
```

## Referencing CSS in HTML

```html
<head>
  <link rel="stylesheet" href="main.css">
</head>
```

## Semantics

**Semantics**: The practice of giving content on the page meaning by using the proper element. Semantic code describes the *value* of content on a page, regardless of the style or appearance of that content.

## Divisions and Spans

**Block-level Elements**: Begin on a new line, stacking on top of the other, and occupy any available width.

**Inline-level Elements**: Fall into the normal flow of a document, lining up one after the other, and only maintain the width of their content.

A `<div>` is a block-level element that has no semantic value. It is used, with an `id` or `class` for styling purposes.

A `<span>` is an inline-level element that has no semantic value. It is also used for styling purposes.

```html
<!-- Division -->
<div class="social">
  <p>I may be found on...</p>
  <p>Additionally, I have a profile on...</p>
</div>

<!-- Span -->
<p>Soon we'll be <span class="tooltip">writing HTML</span> with the best of them.</p>
```

## Test-Based Elements

### Headings

**Headings** are block-level elements that help to quickly break up content and establish hierarchy. They are the key identifiers for users reading a page.

```html
<!-- Start at h1 and don't skip over any -->

<h1>Heading Level 1</h1>
<h2>Heading Level 2</h2>
<h3>Heading Level 3</h3>
<h4>Heading Level 4</h4>
<h5>Heading Level 5</h5>
<h6>Heading Level 6</h6>
```

### Paragraphs

Headings are often followed by supporting paragraphs. Paragraphs can appear one after the other, adding information to a page as desired.

```html
<p>Steve Jobs was a co-founder and longtime chief executive officer at Apple. On June 12, 2005, Steve gave the commencement address at Stanford University.</p>
<p>In his address Steve urged graduates to follow their dreams and, despite any setbacks, to never give up—advice which he sincerely took to heart.</p>
```

### Bold Text

Two inline-level elements that will bold text:
1. `<strong>` is semantically used to give *strong importance* to text.
2. `<b>` semantically means to *stylistically offset* text.

`<strong` is used most often.

```html
<!-- Strong importance -->
<p><strong>Caution:</strong> Falling rocks.</p>

<!-- Stylistically offset -->
<p>This recipe calls for <b>bacon</b> and <b>baconnaise</b>.</p>
```

### Italicize Text

Two inline-level elements that will italicize text:
1. `<em>` is used semantically to place a *stressed emphasis* on text.
2. `<i>` is used semantically to convey text in an *alternative voice or tone*, almost as if it were placed in quotation marks.

`<em>` is used most often.

```html
<!-- Stressed emphasis -->
<p>I <em>love</em> Chicago!</p>

<!-- Alternative voice or tone -->
<p>The name <i>Shay</i> means a gift.</p>
```

## Structurally Based Elements

These elements are intended to give meaning to the organization of pages and improve structural semantics. They are all block-level elements and do not have any implied position or style.

**Header**: Identifies the top of a page, article, section, or other segment of a page.

```html
<header>...</header>
```

**Navigation**: Identifies a section of major navigational links on a page. Should be reserved for primary navigation sections only.

```html
<nav>...</nav>
```

**Article**: Identifies a section of independent, self-contained content that may be independently distributed or reused. e.g. blog posts, newspaper articles, user-submitted content, and the like.

```html
<article>...</article>
```

**Section**: Identifies a thematic grouping of content, which generally, but not always, includes a heading. It's useful to identify all of the content as related.

```html
<section>...</section>
```

**Aside**: Identifies content, such as sidebars, inserts, or brief explanations, that is tangentially related to the content surrounding it.

```html
<aside>...</aside>
```

**Footer**: Identifies the closing or end of a page, article, section, or other segment of a page. Content should be relative information and should not diverge from the document or section it is included within.

```html
<footer>...</footer>
```

## Creating Hyperlinks

**Hyperlinks**: Provide the ability to link from one web page or resource to another.

```html
<a href="http://toddhancock.net">Todd</a>
```

### Relative & Absolute Paths

```html
<!-- Relative Path: page on same website -->
<a href="about.html">About</a>

<!-- Absolute Path: page on other website -->
<a href="http://www.google.com/">Google</a>
```

### Linking to an Email Address

```html
<a href="mailto:todd@awesome.com?subject=Reaching%20Out&body=How%20are%20you">Email Me</a>
```

### Opening Links in a New Window

```html
<a href="http://toddhancock.net/" target="_blank">Todd Hancock</a>
```

### Linking to Parts of the Same Page

```html
<body id="top">
  ...
  <a href="#top">Back to top</a>
  ...
</body>
```

## The Display Property

**Display**: CSS property that determines exactly how elements are displayed.

Four most common `display` values:
1. `block` makes the element a block-level element.
2. `inline` makes the element an inline-level element.
3. `inline-block` allows the element to behave as a block-level element, accepting all box model properties, but will be displayed in line with the other elements.
4. `none` completely hides an element and render the page as if the element doesn't exist.

```css
div {
  display: none;
}
```

## The Box Model

According to the box model concept, every element on a page is a rectangular box and may have a width, height, padding, borders, and margins.

```css
div {
  border: 6px solid #949599;
  height: 100px;
  margin: 20px;
  padding: 20px;
  width: 400px;
}
```

The total width of an element can be calculated using the following formula:

```
margin-right + border-right + padding-right + width + padding-left + border-left + margin-left
```

And the total height can be calculated using the following formula:

```
margin-top + border-top + padding-top + height + padding-bottom + border-bottom + margin-bottom
```

### Width

Block-level elements have a default width of 100%. Inline and inline-block elements expand and contract horizontally to accommodate their content. Inline-level elements cannot have a fixed size.

### Height

Default height is determined by content. All elements expand and contract vertically as necessary to accommodate their content. Inline-level elements cannot have a fixed size.

### Margin

Browsers may apply default margin to elements. Margin for an element falls outside any border and is completely transparent in color. Vertical margins, `top` and `bottom` are not accepted by inline-level elements.

### Padding

Padding is very similar to margin, but falls inside of the element's border. Unlike the `margin` property, the `padding` property works vertically on inline-level elements, though it may blend into the line above or below the given element.

### Borders

Borders fall between the padding and margin, providing an outline around an element. It requires three values: `width`, `style`, and `color`.

## Positioning

### Positioning with Floats

`float` property removes an element from the normal flow of a page, and positions is to the left or right of its parent element. An `<img>` element floated to the side of a few paragraphs of text will allow the paragraphs to wrap around the image as necessary.

```css
img {
  float: left; /* could also be right */
}
```

**note**: The `float` property was originally intended for this purpose. It was never actually intended to used for layouts and positioning. So, there are a few *hacky* things about using it this way.

```css
/* example positioning a section and an aside */
section {
  float:left;
  margin: 0 1.5%;
  width: 63%;
}
aside {
  float: right;
  margin: 0 1.5%;
  width: 30%;
}

/* `clear` property is needed so footer doesn't wrap around the floats */
footer {
  clear:both; /* could also be right or left */
}
```

#### Clearfix

**Clearfix**: A technique for containing floats in a parent element, leaving the flow of the document completely normal outside of it. This helps to ensure that all the styles will be rendered properly.

HTML
```html
<header>...</header>
<div class="clearfix">
  <section>...</section>
  <aside>...</aside>
</div>
<footer>...</footer>
```

CSS
```css
.clearfix:before,
.clearfix:after {
  content: "";
  display: table;
}
.clearfix:after {
  clear: both;
}
.clearfix {
  clear: both;
  *zoom: 1; /* needed to work on older browsers */
}
section {
  float: left;
  margin: 0 1.5%;
  width: 63%;
}
aside {
  float: right;
  margin: 0 1.5%;
  width: 30%;
}
```

### Positioning with Inline-Block

HTML
```html
<header>...</header>

<!-- comments used between sections to remove space -->
<section>
  ...
</section><!--
--><section>
  ...
</section><!--
--><section>
  ...
</section>
<footer>...</footer>
```

CSS
```css
section {
  display: inline-block;
  margin: 0 1.5%;
  width: 30%;
}
```

### Uniquely Positioning Elements

The `position` property identifies *how* an element is positioned on a page and whether or not it will appear in the normal flow of a document. This is used in conjunction with the box offset properties---`top`, `right`, `bottom`, and `left`---which identify exactly *where* an element will be positioned.

* `static` is the default value of the `position` property. It means that the element exists in the normal flow of a document and doesn't accept any box offset properties.
* `relative` value allows an element to appear in the normal flow of the page, not allowing other elements to flow around it; and also allows it's display position to be modified with the box offset properties. [Example](http://codepen.io/shayhowe/pen/xJlhs)
* `absolute` value makes an element not appear within the normal flow of a document, and its original space and position will not be preserved. Absolutely positioned elements are moved in relation to their closest relatively positioned parent element, or the `<body>` element. [Example](http://codepen.io/shayhowe/pen/ibhkD)

## Typography

**Typeface**: The artistic impression of how text looks, feels, and reads.

**Font**: A file that contains a typeface.

### Adding Color to Text

```css
html {
  color: #555;
}
```

### Font Properties

* `font-family`: Used to declare which font---as well as which fallback or substitute fonts---should be used to display text. Value contains multiple font names, all comma separated.
* `font-size`: Provides the ability to set the size of text using common length values.
* `font-style`: Can change text to italics (`italic`) or return text or its normal style (`normal`).
* `font-variant`: Can set text in small capitals (`small-caps`) or return it to normal (`normal`).
* `font-weight`: Styles text as bold or changes the specific weight of a typeface. `normal` maps to `400`, and `bold` to `700`.
* `line-height`: Declares the distance between two lines of text (also called leading). May also be used to center a single line of text within an element, by setting `height` and `line-height` to the same value on the element.
* `font`: Uses a shorthand value to combine all font properties. The order of these property values should be as follows: `font-style` `font-variant` `font-weight` `font-size`/`line-height` `font-family`. Every value is optional *except* `font-size` and `font-family`.

### Text Properties

* `text-align`: Aligns text within the element. Values are `left`, `right`, `center`, `justify`, and `inherit`.
* `text-decoration`: Provides a handful of ways to spruce up text. Values are `none`, `underline`, `overline`, `line-through`, and `inherit`.
* `text-indent`: Used to indent the first line of text within an element.
* `text-shadow`: Adds a shadow or multiple shadows to text. Takes four values:
  1. Shadow's horizontal offset (length).
  2. Shadow's vertical offset (length).
  3. Shadow's blur radius (length).
  4. Shadow's color.
* `text-transform`: Changes text inline without the need for an alternate typeface. Values are `none`, `capitalize` (first letter of each word), `uppercase` (every letter), `lowercase` (every letter), and `inherit`.

### Typography Properties Example

HTML
```html
<h2><a href="#">I Am a Builder</a></h2>

<p class="byline">Posted by Todd Hancock</p>

<p class="intro">Every day I see designers and developers working alongside onde another. They work intelligently in pursuit of business objectives. They work diligently making exceptional products. They solve real problems and take pride in their work. They are builders. <a href='#'>Continue&#8230;</a></p>
```

CSS
```css
h2,
p {
  color: #555;
  font: 13px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
}

a {
  color: #0087cc;
}

a:hover {
  color: #ff7b29;
}

h2 {
  font-size: 22px;
  font-weight: bold;
  letter-spacing: -.02em;
  margin-bottom: 6px;
}

h2 a {
  text-decoration: none;
  text-shadow: 2px 2px 1px rgba(0, 0, 0, .2);
}

.byline {
  color: #9799a7;
  font-family: Georgia, Times, "Times New Roman", serif;
  font-style: italic;
  margin-bottom: 18px;
}

.intro {
  text-indent: 15px;
}

.intro a {
  font-size: 11px;
  font-weight: bold;
  text-decoration: underline;
  text-transform: uppercase;
}
```
### Web Safe Fonts

By default, there are a few fonts pre-installed on every web-browsing-capable device. These can be freely used within web sites.

* Arial
* Courier New, Courier
* Garamond
* Georgia
* Lucida Sans, Lucida Grande, Lucida
* Palatino Linotype
* Tahoma
* Times New Roman, Times
* Trebuchet
* Verdana

### Embedding Web Fonts

```css
/* First declare font name and location in @font-face */
@font-face {
  font-family: "Lobster";
  src: local("Lobster"), url("lobster.woff") format("woff");
}

/* Then use font in any font-family property value */
body {
  font-family: "Lobster", "Comic Sans", cursive;
}
```
