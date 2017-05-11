# Notes for Code Advanced HTML & CSS


<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Performance & Organization](#performance-organization)
  * [Strategy & Structure](#strategy-structure)
  * [Performance Driven Selectors](#performance-driven-selectors)

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
