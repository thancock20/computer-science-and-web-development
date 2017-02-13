# Notes for Learn To Code HTML & CSS


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [What are HTML & CSS](#what-are-html-css)
* [Common HTML Terms](#common-html-terms)
* [HTML Document Structure](#html-document-structure)
* [Common CSS Terms](#common-css-terms)
* [Working with Selectors](#working-with-selectors)
* [Referencing CSS in HTML](#referencing-css-in-html)

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
