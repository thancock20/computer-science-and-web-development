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
  * [Citations & Quotes](#citations-quotes)
* [Backgrounds & Gradients](#backgrounds-gradients)
  * [Background Color](#background-color)
  * [Background Image](#background-image)
  * [Gradient Backgrounds](#gradient-backgrounds)
  * [Multiple Background Images](#multiple-background-images)
  * [New CSS3 Background Properties](#new-css3-background-properties)
* [Lists](#lists)
  * [Nesting Lists](#nesting-lists)
  * [List Item Styling](#list-item-styling)
  * [Using an Image as a List Item Marker](#using-an-image-as-a-list-item-marker)
  * [Horizontally Displaying a List](#horizontally-displaying-a-list)
  * [Navigational List Example](#navigational-list-example)
* [Adding Media](#adding-media)
  * [Adding Images](#adding-images)
    * [Sizing Images](#sizing-images)
    * [Positioning Images](#positioning-images)
  * [Adding Audio](#adding-audio)
    * [Audio Fallbacks & Multiple Sources](#audio-fallbacks-multiple-sources)
  * [Adding Video](#adding-video)
  * [Adding Inline Frames](#adding-inline-frames)
* [Semantically Identifying Figures & Captions](#semantically-identifying-figures-captions)
* [Forms](#forms)
  * [Text](#text)
  * [Multiple Choice](#multiple-choice)
  * [Menus](#menus)
  * [Buttons](#buttons)
  * [Other Inputs](#other-inputs)
  * [Organizing Form Elements](#organizing-form-elements)
  * [Additional Form & Input Attributes](#additional-form-input-attributes)
* [Tables](#tables)

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

* `text-align`: Aligns text within the element. Values are:
  * `left`
  * `right`
  * `center`
  * `justify`
  * `inherit`
* `text-decoration`: Provides a handful of ways to spruce up text. Values are:
  * `none`
  * `underline`
  * `overline`
  * `line-through`
  * `inherit`
* `text-indent`: Used to indent the first line of text within an element.
* `text-shadow`: Adds a shadow or multiple shadows to text. Takes four values:
  1. Shadow's horizontal offset (length).
  2. Shadow's vertical offset (length).
  3. Shadow's blur radius (length).
  4. Shadow's color.
* `text-transform`: Changes text inline without the need for an alternate typeface. Values are:
  * `none`
  * `capitalize` (first letter of each word)
  * `uppercase` (every letter)
  * `lowercase` (every letter)
  * `inherit`

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

### Citations & Quotes

* `<cite>`: Used to reference a creative work, author, or resource
* `<q>`: Used for short, inline quotations
* `<blockquote>`: Used for longer external quotations

```html
<!-- <cite> example, includes hyperlink to original source -->
<p>The book <cite><a href="http://www.amazon.com/Steve-Jobs-Walter-Isaacson/dp/1451648537">Steve Jobs</a></cite> is truly inspirational.

<!-- <q> example, includes cite attribute -->
<p><a href="http://www.businessweek.com/magazine/content/06_06/b3970001.htm">Steve Jobs</a> once said, <q cite="http://www.businessweek.com/magazine/content/06_06/b3970001.htm">One home run is much better than two doubles.</q></p>

<!-- <blockquote> example, inlcudes cite attribute -->
<blockquote cite="http://money.cnn.com/magazines/fortune/fortune_archive/2000/01/24/272277/index.htm">
  <p>&#8220;In most people&#8217;s vocabularies, design is a veneer. It&#8217;s interior decorating. It&#8217;s the fabric of the curtains, of the sofa. But to me, nothing could be further from the meaning of design. Design is the fundamental soul of a human-made creation that ends up expressing itself in successive outer layers of the product.&#8221;</p>
  <p><cite>&#8212; Steve Jobs in <a href="http://money.cnn.com/ magazines/fortune/fortune_archive/2000/01/24/272277/index.htm"> Fortune Magazine</a></cite></p>
</blockquote>
```

## Backgrounds & Gradients

### Background Color

```css
div {
  background-color: #b2b2b2;
}
```

### Background Image

```css
div{
  /* give url for background image */
  background-image: url("alert.png");

  /* possible values: repeat, repeat-x, repeat-y, no-repeat */
  background-repeat: no-repeat;

  /* relative to left top corner */
  background-position: 20px 10px;
}
```

`background` shorthand property. Order is `background-color` `background-image` `background-position` `background-repeat`.

```css
div {
  background: #b2b2b2 url("alert.png") 20px 10px no-repeat;
}
```

### Gradient Backgrounds

```css
/* linear gradient background top to bottom */
div {
  background: #466368; /* fallback for older browsers */
  background: linear-gradient(#648880, #293f50);
}

/* linear gradient background top left to right bottom */
div {
  background: linear-gradient(to right bottom, #648880, #293f50);
}

/* radial gradient background inside to outside */
div {
  background: radial-gradient(#648880, #293f50);
}

/* linear gradient background with color stops */
div {
  background: linear-gradient(to right, #f6f1d3, #648880, #293f50);
}
```

### Multiple Background Images

```css
div {
  background: url("foreground.png") 0 0 no-repeat, url("middle-ground.png") 0 0 no-repeat, url("background.png") 0 0 no-repeat;
}
```

### New CSS3 Background Properties

* `background-size`: Specifies a size for a background image. Values are:
  * Length values. 1st value is width, 2nd is height.
  * `cover`: Background image will be resized to completely cover an element's width and height. Original aspect ratio will be preserved. Part of the image may be cut off.
  * `contain`: Background image will be resized to reside entirely contained within an element's width and height. Image may not occupy the full available space of the element.
* `background-clip`: Specifies the surface area a background image will cover.
* `background-origin`: Specifies where the `background-position` should originate. Values for both are:
  * `border-box`
  * `padding-box`
  * `content-box`

```css
div {
  background: url("todd.jpg") 0 0 no-repeat;
  background-size: 32px 48px;
  background-clip: padding-box;
  background-origin: padding-box;
}
```

## Lists

**Unordered list**: A list of related items whose order does not matter.

```html
<ul>
  <li>Orange</li>
  <li>Green</li>
  <li>Blue</li>
</ul>
```

**Ordered List**: A list where the order in which items are presented is important.

```html
<!-- List starts at 1 and goes up by default -->
<ol>
  <li>Head north on N Halsted St</li>
  <li>Turn right on W Diversey Pkwy</li>
  <li>Turn left on N Orchard St</li>
</ol>

<!-- To start a list at 30 and go up -->
<ol start="30">
  <li>Head north on N Halsted St</li>
  <li>Turn right on W Diversey Pkwy</li>
  <li>Turn left on N Orchard St</li>
</ol>

<!-- To go down and end on 1 -->
<ol reversed>
  <li>Head north on N Halsted St</li>
  <li>Turn right on W Diversey Pkwy</li>
  <li>Turn left on N Orchard St</li>
</ol>

<!-- To go 1, 9, 10 -->
<ol>
  <li>Head north on N Halsted St</li>
  <li value="9">Turn right on W Diversey Pkwy</li>
  <li>Turn left on N Orchard St</li>
</ol>
```

**Description List**: Used to outline multiple terms and their descriptions, as in a glossary, for example.

```html
<dl>
  <dt>study</dt>
  <dd>The devotion of time and attention to acquiring knowledge on an academic subject, especially by means of books</dd>
  <dt>design</dt>
  <dd>A plan or drawing produced to show the look and function or workings of a building, garment, or other object before it is built or made</dd>
  <dd>Purpose, planning, or intention that exists or is thought to exist behind an action, fact, or material object</dd>
  <dt>business</dt>
  <dt>work</dt>
  <dd>A person's regular occupation, profession, or trade</dd>
</dl>
```

### Nesting Lists

```html
<ol>
  <li>Walk the dog</li>
  <li>Fold laundry</li>
  <li>
    Go to the grocery and buy:
    <ul>
      <li>Milk</li>
      <li>Bread</li>
      <li>Cheese</li>
    </ul>
  </li>
  <li>Mow the Lawn</li>
  <li>Make dinner</li>
</ol>
```

### List Item Styling

* `list-style-type`: Used to set the content of a list item marker. Values are:
  * `none`: No list item
  * `disc`: A filled circle
  * `circle`: A hollow circle
  * `square`: A filled square
  * `decimal`: Decimal numbers
  * `decimal-leading-zero`: Decimal numbers padded by initail zeros
  * `lower-roman`: Lowercase Roman numerals
  * `upper-roman`: Uppercase Roman numerals
  * `lower-greek`: Lowercase classical Greek
  * `lower-alpha` / `lower-latin`: Lowercase ASCII letters
  * `upper-alpha` / `upper-latin`: Uppercase ASCII letters
  * `armenian`: Traditional Armenian numbering
  * `georgian`: Traditional Gerogian numbering
* `list-style-position`: Values are:
  * `outside`: Places the list item marker to the left of the `<li>` element and doesn't allow any content to wrap below the list item marker.
  * `inside`: Places the list item marker in line with the first line of the `<li>` element and allows other content to wrap below it as needed.
  * `inherit`
* `list-style`: Shorthand property. Order is `list-style-type` `list-style-position`.

### Using an Image as a List Item Marker

HTML
```html
<ul>
  <li>Orange</li>
  <li>Green</li>
  <li>Blue</li>
<ul>
```

CSS
```css
li {
  /* Remove existing list item markers */
  list-style-type: none;

  /* Identify a background image, along with its postition and repeat value, if necessary */
  background: url("arrow.png") 0 50% no-repeat;

  /* Provide space to the left of the text for the background image */
  padding-left: 12px;
}
```

### Horizontally Displaying a List

```css
/* Display method - list item marker is removed */
li {
  display: inline-block;
  margin: 0 10px;
}
```

```css
/* Float method - list item marker is retained */
li {
  float: left;
  margin: 0 20px;
}
```

### Navigational List Example

HTML
```html
<nav class="navigation">
  <ul>
    <li><a href="#">Profile</a></li><!--
    --><li><a href="#">Settings</a></li><!--
    --><li><a href="#">Notifications</a></li><!--
    --><li><a href="#">Logout</a></li>
  </ul>
</nav>
```

CSS
```css
.navigation ul {
  font: bold 11px "Helvetica Neue", Helvetica, Arial, sans-serif;
  margin: 0;
  padding: 0;
  text-transform: uppercase;
}
.navigation li {
  display: inline-block;
}
.navigation a {
  background: #395870;
  background: linear-gradient(#49708f, #293f50);
  border-right: 1px solid rgba(0, 0, 0, .3);
  color: #fff;
  padding: 12px 20px;
  text-decoration: none;
}
.navigation a:hover {
  background: #314b60;
  box-shadow: inset 0 0 10px 1px rgba(0, 0, 0, .3);
}
.navigation li:first-child a {
  border-radius: 4px 0 0 4px;
}
.navigation li:last-child a {
  border-right: 0;
  border-radius: 0 4px 4px 0;
}
```

## Adding Media

### Adding Images

`<img>`: Inline element that displays an image. Is self-containing and has two attributes:

1. `src`: URL to the source of the image.
2. `alt`: Alternative text, which describes the contents of an image. Is picked up by search engines and assistive technologies to help convey the purpose of an image. Will be displayed in place of the image if it is not available for some reason.

```html
<img src="dog.jpg" alt="A black, brown, and white dog wearing a kerchief">
```

#### Sizing Images

```css
/* Note: including both height and width may break the aspect ratio of image */
img {
  height: 200px;
  width: 200px;
}
```

#### Positioning Images

```css
/* Using float */
img {
  background: #eaeaed;
  border: 1px solid #9799a7;
  float: right;
  margin: 8px 0 0 20px;
  padding: 4px;
}
```

### Adding Audio

`<audio>`: Element that adds audio to a page. Attributes are:
* `src`: URL to the source of the audio file.
* `autoplay`: Boolean attribute. If `true`, audio file will play automatically upon loading.
* `controls`: Boolean attribute. If `true`, displays a browser's default audio controls, including play and pause, seek, and volume controls.
* `loop`: Boolean attribute. If `true`, audio file repeats continually, from beginning to end.
* `preload`: Identifies what, if any, information about the audio file should be loaded before the clip is played. Values are:
  * `none`: Won't preload any information.
  * `auto`: Preloads all information.
  * `metadata`: Preloads available metadata information, but not all information.

```html
<audio src="jazz.ogg" autoplay controls></audio>
```

#### Audio Fallbacks & Multiple Sources

`<source>`: Used in `<audio>` element to add multiple sources. Enables adding of fallback formats for different browsers. If a browser doesn't recognize any of the audio file formats, the anchor link to download the element will be displayed.

```html
<audio controls>
  <source src="jazz.ogg" type="audio/ogg">
  <source src="jazz.mp3" type="audio/mpeg">
  <source src="jazz.wav" type="audio/wav">
  Please <a href="jazz.mp3" download>download</a> the audio file.
</audio>
```

### Adding Video

`<video>`: Element that adds video to a page. Has attributes as `<audio>` plus:
* `poster`: Specifies a URL of an image to be shown before a video is played.

```html
<video controls poster="earth-video-screenshot.jpg">
  <source src="earth.ogv" type="video/ogg">
  <source src="earth.mp4" type="video/mp4">
  Please <a href="earth.mp4" download>download</a> the video.
</video>
```

### Adding Inline Frames

```html
<iframe src="https://www.google.com/maps/embed?..."></iframe>
```

## Semantically Identifying Figures & Captions

* `<figure>`: Block-level element used to identify and wrap self-contained content, often in the form of media. If it is moved from the main portion of a page to another location (e.g the bottom of the page), it should not disrupt the content of legibility of the page.
* `<figcaption>`: Serves as the caption for all content within the `<figure>` element. May appear anywhere within the `<figure>` element. Also, may replace an `<img>` element's `alt` attribute if the content provides a useful description of the visual content of the image.

```html
<figure>
  <img src="dog.jpg">
  <figcaption>A beautiful black, brown, and white hound dog wearing kerchief.</figcaption>
</figure>
```

## Forms

* `<form>`: Identifies where on the page control elements will appear. Will wrap all of the elements included within the form. Most common attributes are:
  * `action`: Contains the URL to which information included within the form will be sent for processing by the server.
  * `method`: The HTTP method browsers should use to submit the form data.

```html
<form action="/login" method="post">
  ...
</form>
```
### Text

* `<input>`: Used to obtain text from users.
  * `name`: Value is used as the name of the control and is submitted along with the input data to the server.
  * `type`: Defines what type of information is to be captured within the control. Text values are:
    * `text`
    * `password`
    * `color`
    * `date`
    * `datetime`
    * `email`
    * `month`
    * `number`
    * `range`
    * `search`
    * `tel`
    * `time`
    * `url`
    * `week`
* `<textarea>`: Can accept larger passages of text spanning multiple lines.

```html
<input type="text" name="username">
<input type="date" name="birthday">
<input type="tel" name="phone-number">

<textarea name="comment">Add your comment here</textarea>
```

### Multiple Choice

* `radio`: `type` of `<input>` element. Permits users to select one option from a small list. Each radio button in a group should have the same `name` attribute.
  * `checked`: Boolean attribute to preselect a button.
* `checkbox`: Similar to radio buttons, but allows users to select multiple values and tie them all to one control name. Also has `checked` attribute available.

```html
<!-- Radio Buttons -->
<input type="radio" name="day" value="Friday" checked> Friday
<input type="radio" name="day" value="Saturday"> Saturday
<input type="radio" name="day" value="Sunday"> Sunday

<!-- Checkboxes -->
<input type="checkbox" name="day" value="Friday" checked> Friday
<input type="checkbox" name="day" value="Saturday"> Saturday
<input type="checkbox" name="day" value="Sunday"> Sunday
```

### Menus

* `<Select>`: Wraps all of the menu options.
  * `multiple`: Boolean attribute. Allows a user to choose more than one option from the list at a time.
* `<option>`: Marks each menu option.
  * `selected`: Boolean attribute. Preselects an option for users.

```html
<select name="day" multiple>
  <option value="Friday" selected>Friday</option>
  <option value="Saturday">Saturday</option>
  <option value="Sunday">Sunday</option>
</select>
```

### Buttons

* `submit`: `type` of `<input>` element. Creates a button, that submits the form.
  * `value`: Attribute used to specify the text that appears within the button.
* `<button>`: Element performs the same way as the `<input>` element with the `type` value of `submit`; however it includes opening and closing tags, which may wrap other elements.

```html
<!-- Submit Input -->
<input type="submit" name="submit" value="Send">

<!-- Submit Button -->
<button name="submit">
  <strong>Send Us</strong> a Message
</button>
```

### Other Inputs

* `hidden`: `type` of `<input>` element. Provides a way to pass data to the server without displaying it to users. Not displayed on the page, but can be found by viewing the source code.
* `file`: `type` of `<input>` element. Allows users to add a file to a form, much like attaching a file to an email.

```html
<input type="hidden" name="tracking-code" value="abc-123">

<input type="file" name="file">
```

### Organizing Form Elements

* `<label>`: Provides captions or headings for form controls, unambiguously tyin them together and creating an accessible form for all users and assistive technologies.
  * `for`: Attribute. Should match `id` attribute of form control. If `<label>` wraps the control, `for` and `id` may be omitted.
* `<fieldset>`: Block-level element that wraps related elements within a `<form>` for better organization. By default, includes a border outline.
* `<legend>`: Provides a caption, or heading, for the `<fieldset>` element. Should be included directly after the opening `<fieldset>` tag.

```html
<fieldset>
  <legend>Login</legend>
  <label>
    Username
    <input type="text" name="username">
  </label>
  <label>
    Password
    <input type="text" name="password">
  </label>
</fieldset>
```

### Additional Form & Input Attributes

* `accept`: List of types the server accepts, typically a file type.
* `autocomplete`: Indicates whether controls can by default have their values automatically completed by the browser.
* `autofocus`: The element should be automatically focused after the page loaded.
* `disabled`: Indicates whether the user can interact with the element.
* `enctype`: Defines the content tpe of the form date when the `method` is `POST`.
* `formaction`: Indicates the action of the element, ovoerriding the action defined in the `<form>`.
* `max`: Indicates the maximum value allowed.
* `maxlength`: Defines the maximum number of characters allowed in the element.
* `method`: Defines which HTTP method to use when submitting the form. Can be `GET` (default) or `POST`.
* `min`: Indicates the minimum value allowed.
* `novalidate`: Indicates that the form shouldn't be validated when submitted.
* `pattern`: Defines a regular expression which the element's value will be validated agains.
* `placeholder`: Provides a hint to the user of what can be entered in the field.
* `readonly`: Indicates whether the element can be edited.
* `required`: Indicates whether this element is required to fill out or not.

## Tables

* `<table>`: Signifies that the information within this element will be tabular data displayed in the necessary columns and rows.
* `<tr>`: Adds a row to a table.
* `<td>`: Adds a data cell to a table row. Creates column.
  * `rowspan`: Attribute used to span a single cell across multiple rows. May also be used on `<th>`.
  * `colspan`: Attribute used to span a single cell across multiple columns.
* `<th>`: Adds a header cell to a table. May also be used on `<th>`.
  * `scope`: Attribute helps to identify exactly what content a header relates to.
    * `row`
    * `col`
* `<caption>`: Provides a caption or title for a table. Must come immediately after the opening `<table>` tag.
* `<thead>`: Wraps the heading row or rows of a table to denote the head.
* `<tbody>`: Contains the primary data within a table.
* `<tfoot>`: Contains data that outlines the contents of a table.

```html
<table>
  <caption>Design and Front-End Development Books</caption>
  <thead>
    <tr>
      <th scope="col" colspan="2">Item</th>
      <th scope="col">Qty</th>
      <th scope="col">Price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Don&#8217;t Make Me Think by Steve Krug</td>
      <td>In Stock</td>
      <td>1</td>
      <td>$30.02</td>
    </tr>
  <tr>
    <td>A Project Guide to US Design by Russ Unger &@38; Carolyn Chandler</td>
    <td>In Stock</td>
    <td>2</td>
    <td>$52.94 ($26.47 &#215; 2)</td>
  </tr>
  <tr>
    <td>Introducing HTML5 by Bruce Lawson &#38; Remy Sharp</td>
    <td>Out of Stock</td>
    <td>1</td>
    <td>$22.23</td>
  </tr>
  <tr>
    <td>Bulletproof Web Design by Dan Cederholm</td>
    <td>In Stock</td>
    <td>1</td>
    <td>$30.17</td>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="3">Subtotal</td>
      <td>$135.36</td>
    </tr>
    <tr>
      <td colspan="3">Tax</td>
      <td>$13.54</td>
    </tr>
    <tr>
      <td colspan="3">Total</td>
      <td>$148.90</td>
    </tr>
  </tfoot>
</table>
```
