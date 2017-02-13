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
* Closing Tag: Marks the end of an element. e.g. `</div`

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
