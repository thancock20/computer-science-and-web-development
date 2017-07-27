# Notes from DOM Enlightenment


<!-- @import "[TOC]" {cmd:"toc", depthFrom:2, depthTo:6, orderedList:false} -->

<!-- code_chunk_output -->

* [Node Overview](#node-overview)
	* [Sub-node objects inherit from the `Node` object:](#sub-node-objects-inherit-from-the-node-object)
	* [Properties and methods for working nodes](#properties-and-methods-for-working-nodes)
	* [Identifying the type and name of a node](#identifying-the-type-and-name-of-a-node)
	* [Getting a nodes value](#getting-a-nodes-value)
	* [Creating element and text nodes using JavaScript methods](#creating-element-and-text-nodes-using-javascript-methods)
	* [Creating and adding element and text nodes to the DOM using JavaScript strings](#creating-and-adding-element-and-text-nodes-to-the-dom-using-javascript-strings)
	* [Extracting parts of the DOM tree as JavaScript strings](#extracting-parts-of-the-dom-tree-as-javascript-strings)
	* [Adding node objects to the DOM using `appendChild()` & `insertBefore()`](#adding-node-objects-to-the-dom-using-appendchild-insertbefore)
	* [Removing and replacing nodes using `removeChild()` and `replaceChild()`](#removing-and-replacing-nodes-using-removechild-and-replacechild)
	* [Cloning nodes using `cloneNode()`](#cloning-nodes-using-clonenode)
	* [Grokking node collections (i.e. `Nodelist` & `HTMLcollection`)](#grokking-node-collections-ie-nodelist-htmlcollection)
	* [Getting a list/collection of all immediate child nodes](#getting-a-listcollection-of-all-immediate-child-nodes)
	* [Traversing nodes in the DOM](#traversing-nodes-in-the-dom)

<!-- /code_chunk_output -->


## Node Overview

The *Document Object Model* (aka the DOM) is a hierarchy/tree of JavaScript node objects.

**Node Object Types**:
| **Interface/Constructor**:               | **nodeType (returned from `.nodeType`)**: |
|:-----------------------------------------|:------------------------------------------|
| `HTML*Element`, (e.g. `HTMLBodyElement`) | **1** (i.e. `ELEMENT_NODE`)               |
| `Text`                                   | **3** (i.e. `TEXT_NODE`)                  |
| `Attr`                                   | **2** (i.e. `ATTRIBUTE_NODE`)             |
| `HTMLDocument`                           | **9** (i.e. `DOCUMENT_NODE`)              |
| `DocumentType`                           | **10** (i.e. `DOCUMENT_TYPE_NODE`)        |

### Sub-node objects inherit from the `Node` object:

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href="#">Hi</a> <!-- this is a HTMLAnchorElement -->

<script>

// get reference to element node object
var  nodeAnchor = document.querySelector('a');

// create props array to store property keys for element node object
var props = [];

// loop over element node ovject getting all properties & methods (inherited too)
for (var key in nodeAnchor) {
  props.push(key);
}

// log alphabetical list of properties & methods
console.log(props.sort());

/* on Firefox this logs:
 ["ATTRIBUTE_NODE", "CDATA_SECTION_NODE", "COMMENT_NODE", "DOCUMENT_FRAGMENT_NODE", "DOCUMENT_NODE", "DOCUMENT_POSITION_CONTAINED_BY", "DOCUMENT_POSITION_CONTAINS", "DOCUMENT_POSITION_DISCONNECTED", "DOCUMENT_POSITION_FOLLOWING", "DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC", "DOCUMENT_POSITION_PRECEDING", "DOCUMENT_TYPE_NODE", "ELEMENT_NODE", "ENTITY_NODE", "ENTITY_REFERENCE_NODE", "NOTATION_NODE", "PROCESSING_INSTRUCTION_NODE", "TEXT_NODE", "accessKey", "accessKeyLabel", "addEventListener", "after", "animate", "append", "appendChild", "attributes", "baseURI", "before", "blur", "charset", "childElementCount", "childNodes", "children", "classList", "className", "click", "clientHeight", "clientLeft", "clientTop", "clientWidth", "cloneNode", "closest", "compareDocumentPosition", "contains", "contentEditable", "contextMenu", "coords", "dataset", "dir", "dispatchEvent", "download", "draggable", "firstChild", "firstElementChild", "focus", "getAttribute", "getAttributeNS", "getAttributeNames", "getAttributeNode", "getAttributeNodeNS", "getBoundingClientRect", "getClientRects", "getElementsByClassName", "getElementsByTagName", "getElementsByTagNameNS", "getRootNode", "hasAttribute", "hasAttributeNS", "hasAttributes", "hasChildNodes", "hash", "hidden", "host", "hostname", "href", "hreflang", "id", "innerHTML", "innerText", "insertAdjacentElement", "insertAdjacentHTML", "insertAdjacentText", "insertBefore", "isConnected", "isContentEditable", "isDefaultNamespace", "isEqualNode", "isSameNode", "lang", "lastChild", "lastElementChild", "localName", "lookupNamespaceURI", "lookupPrefix", "matches", "mozMatchesSelector", "mozRequestFullScreen", "name", "namespaceURI", "nextElementSibling", "nextSibling", "nodeName", "nodeType", "nodeValue", "normalize", "offsetHeight", "offsetLeft", "offsetParent", "offsetTop", "offsetWidth", "onabort", "onanimationcancel", "onanimationend", "onanimationiteration", "onanimationstart", "onauxclick", "onblur", "oncanplay", "oncanplaythrough", "onchange", "onclick", "onclose", "oncontextmenu", "oncopy", "oncut", "ondblclick", "ondrag", "ondragend", "ondragenter", "ondragexit", "ondragleave", "ondragover", "ondragstart", "ondrop", "ondurationchange", "onemptied", "onended", "onerror", "onfocus", "oninput", "oninvalid", "onkeydown", "onkeypress", "onkeyup", "onload", "onloadeddata", "onloadedmetadata", "onloadend", "onloadstart", "onmousedown", "onmouseenter", "onmouseleave", "onmousemove", "onmouseout", "onmouseover", "onmouseup", "onmozfullscreenchange", "onmozfullscreenerror", "onpaste", "onpause", "onplay", "onplaying", "onprogress", "onratechange", "onreset", "onresize", "onscroll", "onseeked", "onseeking", "onselect", "onselectstart", "onshow", "onstalled", "onsubmit", "onsuspend", "ontimeupdate", "ontoggle", "ontransitioncancel", "ontransitionend", "ontransitionrun", "ontransitionstart", "onvolumechange", "onwaiting", "onwebkitanimationend", "onwebkitanimationiteration", "onwebkitanimationstart", "onwebkittransitionend", "onwheel", "origin", "outerHTML", "ownerDocument", "parentElement", "parentNode", "password", "pathname", "ping", "port", "prefix", "prepend", "previousElementSibling", "previousSibling", "protocol", "querySelector", "querySelectorAll", "referrerPolicy", "rel", "relList", "releaseCapture", "remove", "removeAttribute", "removeAttributeNS", "removeAttributeNode", "removeChild", "removeEventListener", "replaceChild", "replaceWith", "requestPointerLock", "rev", "scroll", "scrollBy", "scrollHeight", "scrollIntoView", "scrollLeft", "scrollLeftMax", "scrollTo", "scrollTop", "scrollTopMax", "scrollWidth", "search", "setAttribute", "setAttributeNS", "setAttributeNode", "setAttributeNodeNS", "setCapture", "shape", "spellcheck", "style", "tabIndex", "tagName", "target", "text", "textContent", "title", "toString", "type", "username", "webkitMatchesSelector"]
 This shows that the properties & methods from the Node object are in this list as well
 */

</script>
</body>
</html>
```

### Properties and methods for working nodes

* Node Properties:
	* `childNodes`
	* `firstChild`
	* `lastChild`
	* `nextSibling`
	* `nodeName`
	* `nodeType`
	* `nodeValue`
	* `parentNode`
	* `previousSibling`
* Node Methods:
	* `appendChild()`
	* `cloneNode()`
	* `compareDocumentPosition()`
	* `contains()`
	* `hasChildNodes()`
	* `insertBefore()`
	* `isEqualNode()`
	* `removeChild()`
	* `replaceChild()`
* Document Methods:
	* `document.createElement()`
	* `document.createTextNode()`
* HTML*Element Properties:
	* `innerHTML`
	* `outerHTML`
	* `textContent`
	* `innerText`
	* `outerText`
	* `firstElementChild`
	* `lastElementChild`
	* `nextElementChild`
	* `previousElementChild`
	* `children`
* HTML element Methods:
	* `insertAdjacentHTML()`

### Identifying the type and name of a node

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href="#">Hi</a>

<script>

// This is DOCUMENT_TYPE_NODE or nodeType 10 because Node.DOCUMENT_TYPE_NODE === 10
console.log(
	document.doctype.nodeName, // logs 'html' also try document.doctype to get <!DOCTYPE html>
	document.doctype.nodeType // logs 10 which maps to DOCUMENT_TYPE_NODE
);

// This is DOCUMENT_NODE or nodeType 9 because Node.DOCUMENT_NODE === 9
console.log(
	document.nodeName, // logs '#document'
	document.nodeType // logs 9 which maps to DOCUMENT_NODE
);

// This is DOCUMENT_FRAGMENT_NODE or nodeType 11 because Node.DOCUMENT_FRAGMENT_NODE === 11
console.log(
	document.createDocumentFragment().nodeName, // logs '#document-fragment'
	document.createDocumentFragment().nodeType // logs 11 which maps to DOCUMENT_FRAGMENT_NODE
);

// This is ELEMENT_NODE or nodeType 1 because Node.ELEMENT_NODE === 1
console.log(
	document.querySelector('a').nodeName, // logs 'A'
	document.querySelector('a').nodeType // logs 1 which maps to ELEMENT_NODE
);

// This is ATTRIBUTE_NODE or nodeType 2 because Node.ATTRIBUTE_NODE === 2
console.log(
	document.querySelector('a').attributes['href'].nodeName, // logs 'href'
	document.querySelector('a').attributes['href'].nodeType // logs 2 which maps to ATTRIBUTE_NODE
);

// This is TEXT_NODE or nodeType 3 because Node.TEXT_NODE === 3
console.log(
	document.querySelector('a').firstChild.nodeName, // logs '#text'
	document.querySelector('a').firstChild.nodeType // logs 3 which maps to TEXT_NODE
);

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href="#">Hi</a>

<script>

//is <a> a ELEMENT_NODE?
console.log(document.querySelector('a').nodeType === 1); //logs true, <a> is an Element node

//or use Node.ELEMENT_NODE which is a property containg the numerice value of 1
console.log(document.querySelector('a').nodeType === Node.ELEMENT_NODE); //logs true, <a> is an Element node

</script>
</body>
</html>
```

### Getting a nodes value

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href="#">Hi</a>

<script>

//logs null for DOCUMENT_TYPE_NODE, DOCUMENT_NODE, DOCUMENT_FRAGMENT_NODE, ELEMENT_NODE below
console.log(document.doctype.nodeValue);
console.log(document.nodeValue);
console.log(document.createDocumentFragment().nodeValue);
console.log(document.querySelector('a').nodeVale);

//logs string of text
console.log(document.querySelector('a').firstChild.nodeValue); //logs 'Hi'

</script>
</body>
</html>
```

### Creating element and text nodes using JavaScript methods

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

var elementNode = document.createElement('div');
console.log(elementNode, elementNode.nodeType); //log <div> 1, and 1 indicates an element node

var textNode = document.createTextNode('Hi');
console.log(textNode, textNode.nodeType); //logs Text {} 3, and 3 indicates a text node

</script>
</body>
</html>
```

### Creating and adding element and text nodes to the DOM using JavaScript strings

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div id="A"></div>
<span id="B"></span>
<div id="C"></div>
<div id="D"></div>
<div id="E"></div>

<script>

//create a strong element and text node and add it to the DOM
document.getElementById('A').innerHTML = '<strong>Hi</strong>';

//create a div element and text node to replace <span id="B"></div> (notice span#B is replaced)
document.getElementById('B').outerHTML = '<div id="B" class="new">Whats Shaking</div>'

//create a text node and update the div#C with the text node
document.getElementById('C').textContent = 'dude';


//NON standard extensions below i.e. innerText & outerText

//create a text node and update the div#D with the text node
document.getElementById('D').innerText = 'Keep it';

//create a text node and replace the div#E with the text node (notice div#E is gone)
document.getElementById('E').outerText = 'real!';

console.log(document.body.innerHTML);
/* logs
<div id="A"><strong>Hi</strong></div>
<div id="B" class="new">Whats Shaking</div>
<span id="C">dude</span>
<div id="D">Keep it</div>
real!
*/

</script>
</body>
</html>
```

### Extracting parts of the DOM tree as JavaScript strings

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div id="A"><i>Hi</i></div>
<div id="B">Dude<strong> !</strong></div>

<script>

console.log(document.getElementById('A').innerHTML); //logs '<i>Hi</i>'

console.log(document.getElementById('A').outerHTML); //logs <div id="A">Hi</div>

//notice that all text is returned even if its in child element nodes (i.e. <strong> !</strong>)
console.log(document.getElementById('B').textContent); //logs 'Dude !'

//NON standard extensions below i.e. innerText & outerText

console.log(document.getElementById('B').innerText); //logs 'Dude !'

console.log(document.getElementById('B').outerText); //logs 'Dude !'​​

</script>
</body>
</html>
```

### Adding node objects to the DOM using `appendChild()` & `insertBefore()`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<p>Hi</p>

<script>

//create a blink element node and text node
var elementNode = document.createElement('strong');
var textNode = document.createTextNode(' Dude');

//append these nodes to the DOM
document.querySelector('p').appendChild(elementNode);
document.querySelector('strong').appendChild(textNode);

//log's <p>Hi<strong> Dude</strong></p>
console.log(document.body.innerHTML);

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul>
    <li>2</li>
    <li>3</li>
</ul>

<script>

//create a text node and li element node and append the text to the li
var text1 = document.createTextNode('1');
var li = document.createElement('li');
li.appendChild(text1);

//select the ul in the document
var ul = document.querySelector('ul');

/*
add the li element we created above to the DOM, notice I call on <ul> and pass reference to <li>2</li> using ul.firstChild
*/
ul.insertBefore(li,ul.firstChild);

console.log(document.body.innerHTML);
/*logs
<ul>
<li>1</li>
<li>2</li>
<li>3</li>
</ul>
*/

</script>
</body>
</html>
```

### Removing and replacing nodes using `removeChild()` and `replaceChild()`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div id="A">Hi</div>
<div id="B">Dude</div>

<script>

//remove element node
var divA = document.getElementById('A');
divA.parentNode.removeChild(divA);

//remove text node
var divB = document.getElementById('B').firstChild;
divB.parentNode.removeChild(divB);

//log the new DOM updates, which should only show the remaining empty div#B
console.log(document.body.innerHTML);

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div id="A">Hi</div>
<div id="B">Dude</div>

<script>

//replace element node
var divA = document.getElementById('A');
var newSpan = document.createElement('span');
newSpan.textContent = 'Howdy';
divA.parentNode.replaceChild(newSpan,divA);

//replace text node
var divB = document.getElementById('B').firstChild;
var newText = document.createTextNode('buddy');
divB.parentNode.replaceChild(newText, divB);

//log the new DOM updates,
console.log(document.body.innerHTML);

</script>
</body>
</html>
```

### Cloning nodes using `cloneNode()`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul>
  <li>Hi</li>
  <li>there</li>
</ul>

<script>

var cloneUL = document.querySelector('ul').cloneNode();

console.log(cloneUL.constructor); //logs HTMLUListElement()
console.log(cloneUL.innerHTML); //logs (an empty string) as only the ul was cloned

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul>
  <li>Hi</li>
  <li>there</li>
</ul>

<script>

var cloneUL = document.querySelector('ul').cloneNode(true);

console.log(cloneUL.constructor); //logs HTMLUListElement()
console.log(cloneUL.innerHTML); //logs <li>Hi</li><li>there</li>

</script>
</body>
</html>
```

### Grokking node collections (i.e. `Nodelist` & `HTMLcollection`)

When selecting groups of nodes from a tree or accessing pre-defined nodes, the nodes are either placed in a `NodeList` (e.g. `document.querySelectorAll('*')`) or `HTMLCollection` (e.g. `document.scripts`). These array like (i.e. not a real `Array`) object collections have the following characteristics:

* A collection can either be live or static. Meaning that the nodes contained in the collection are either literally part of the live document or a snapshot of the live document.
* By default, nodes are sorted inside of the collection by tree order. Meaning the order matches the linear path from the tree trunk to branches.
* The collections have a `length` property that reflects the number of elements to the list.

### Getting a list/collection of all immediate child nodes

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul>
  <li>Hi</li>
  <li>there</li>
</ul>

<script>

var ulElementChildNodes = document.querySelector('ul').childNodes;

console.log(ulElementChildNodes); //logs an array like list of all nodes inside of the ul

// Call forEach as if its a method of NodeLists so we can loop over the
// NodeList. Done because NodeLists are array like, but do not directly inherit
// from Array
Array.prototype.forEach.call(ulElementChildNodes,function(item){
   console.log(item); //logs each item in the array
});

</script>
</body>
</html>
```

### Traversing nodes in the DOM

```html
<!DOCTYPE html>
<html lang="en">
<body><ul><!-- comment -->
<li id="A"></li>
<li id="B"></li>
<!-- comment -->
</ul>

<script>
// traversing  all nodes:

//cache selection of the ul
var ul = document.querySelector('ul');

//What is the parentNode of the ul?
console.log(ul.parentNode.nodeName); //logs body

//What is the first child of the ul?
console.log(ul.firstChild.nodeName); //logs comment

//What is the last child of the ul?
console.log(ul.lastChild.nodeName); //logs text not comment, because there is a line break

//What is the nextSibling of the first li?
console.log(ul.querySelector('#A').nextSibling.nodeName); //logs text

//What is the previousSibling of the last li?
console.log(ul.querySelector('#B').previousSibling.nodeName); //logs text

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body><ul><!-- comment -->
<li id="A"></li>
<li id="B"></li>
<!-- comment -->
</ul>

<script>
// traversing only elements:

//cache selection of the ul
var ul = document.querySelector('ul');

//What is the first child of the ul?
console.log(ul.firstElementChild.nodeName); //logs li

//What is the last child of the ul?
console.log(ul.lastElementChild.nodeName); //logs li

//What is the nextSibling of the first li?
console.log(ul.querySelector('#A').nextElementSibling.nodeName); //logs li

//What is the previousSibling of the last li?
console.log(ul.querySelector('#B').previousElementSibling.nodeName); //logs li

//What are the element only child nodes of the ul?
console.log(ul.children); //HTMLCollection, all child nodes including text nodes

</script>
</body>
</html>
```
