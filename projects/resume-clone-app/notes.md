# Notes related to what I learned while completing the Resume Clone project

<!-- toc orderedList:0 depthFrom:2 depthTo:6 -->

* [Simplified Clearfix](#simplified-clearfix)
* [Progress Bars (Meters)](#progress-bars-meters)
* [Progress Radials](#progress-radials)
* [Good Ways to Get Exact Colors](#good-ways-to-get-exact-colors)

<!-- tocstop -->

## Simplified Clearfix

Works in all modern browsers.

```css
/* Clearfix */

.group:after {
  content: "";
  display: table;
  clear: both;
}
```

## Progress Bars (Meters)

HTML
```html
<!-- width percents used in HTML, because they are part of content -->
<div class="meter"><span style="width: 100%"></span></div>
<div class="meter"><span style="width: 90%"></span></div>
<div class="meter"><span style="width: 80%"></span></div>
```

CSS
```css
.meter {
  background-color: #DFE0ED;
  position: relative;
  height: .5em;
  width: 100px;
}

.meter > span {
  background-color: #028CD5;
  display: block;
  height: 100%;
  position: relative;
  overflow: hidden;
}
```

## Progress Radials

HTML
```html
<!-- percents used in HTML, because they are part of the content -->
<div class="progress-radial progress-100">
  <div class="overlay">100%</div>
</div>
<div class="progress-radial progress-90">
  <div class="overlay">90%</div>
</div>
<div class="progress-radial progress-80">
  <div class="overlay">80%</div>
</div>
```

CSS
```css
.progress-radial {
  float: left;
  margin-right: 14px;
  position: relative;
  width: 90px;
  height: 90px;
  border-radius: 50%;
  background-color: #028CD5;
}

.progress-radial .overlay {
  position: absolute;
  width: 76px;
  height: 76px;
  background-color: #F8F8F8;
  border-radius: 50%;
  margin-left: 7px;
  margin-top: 7px;
  text-align: center;
  line-height: 76px;
  font-size: .8em;
}

/* Assumes background behind radial is #DEF0ED */
.progress-80 {
  background-image: linear-gradient(-18deg, #028CD5 50%, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0)), linear-gradient(90deg, #028CD5 50%, #DFE0ED 50%, #DFE0ED);
}

.progress-90 {
  background-image: linear-gradient(-54deg, #028CD5 50%, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0)), linear-gradient(90deg, #028CD5 50%, #DFE0ED 50%, #DFE0ED);
}

.progress-100 {
  background-image: linear-gradient(270deg, #028CD5 50%, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0)), linear-gradient(90deg, #028CD5 50%, #DFE0ED 50%, #DFE0ED);
}
```

## Good Ways to Get Exact Colors

The `eyedropper` tool in Firefox will get any color on a page.

The `gpick` program in Linux will get any color on the screen.
