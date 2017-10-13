# Notes from Programming for the Web with JavaScript

<!-- TOC depthFrom:2 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Week One](#week-one)

<!-- /TOC -->
## Week One

Review of HTML and CSS, but didn't cover semantics of tags or specifically semantic tags. Better reference would be the [Code in HTML and CSS Course notes](../code-html-css/notes.md).

Also talked about Bootstrap 3 for grids, but didn't mention flexbox or grid CSS.

## Week Two

Up until Homework assignment 2, is review of JavaScript (ES5 only). Next comes review of DOM.

Here's example of using localStorage to save JSON:

```html
You have accessed this page <span id="report"></span> times.
<p>
Your last visit was <span id="lastVisitDate"></span>.

<script>
var timesVisited = 0;
var lastVisitDate = 'never';

if (localStorage.lastVisit) {
  var lastVisit = JSON.parse(localStorage.lastVisit);
  timesVisited = lastVisit.numVisits;
  lastVisitDate = lastVisit.date;
}

document.getElementById('lastVisitDate').innerHTML = lastVisitDate;

timesVisited++;
document.getElementById('report').innerHTML = timesVisited;

var myLastVisit = {};
myLastVisit.date = new Date();
myLastVisit.numVisits = timesVisited;
localStorage.lastVisit = JSON.stringify(myLastVisit);
</script>
```

Then there's jQuery usage.

For homework assignment 3, I made a domain analysis. I added a "Behavior" section, with pseudocode for solving the cases. This helped me iron out a lot of the problems before writing any JavaScript. Although, there were still some that I caught and fixed while coding. TDD with Jest or something would have made this easier. 
