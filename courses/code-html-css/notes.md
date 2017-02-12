# Notes for Learn To Code HTML & CSS


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [What are HTML & CSS](#what-are-html-css)
* [Common HTML Terms](#common-html-terms)
* [HTML Document Structure](#html-document-structure)
* [Common CSS Terms](#common-css-terms)

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

**Selectors**: Desinates exactly which element or elements within HTML to target and apply styles (such as color, size, and position) to.

```css
p { ... }
```
