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
	* [Verify a node position in the DOM tree with `contains()` & `compareDocumentPosition()`](#verify-a-node-position-in-the-dom-tree-with-contains-comparedocumentposition)
	* [How to determine if two nodes are identical](#how-to-determine-if-two-nodes-are-identical)
* [Document Nodes](#document-nodes)
	* [`document` node overview](#document-node-overview)
	* [`HTMLDocument` properties and methods](#htmldocument-properties-and-methods)
	* [Getting general HTML document information](#getting-general-html-document-information)
	* [`document` child nodes](#document-child-nodes)
	* [`document` provides shortcuts to `<!DOCTYPE>`, `<html lang="en">`, `<head>`, and `<body>`](#document-provides-shortcuts-to-doctype-html-langen-head-and-body)
	* [Detecting DOM specifications/features using `document.implementation.hasFeature()`](#detecting-dom-specificationsfeatures-using-documentimplementationhasfeature)
	* [Get a reference to the focus/active node in the `document`](#get-a-reference-to-the-focusactive-node-in-the-document)
	* [Determining if the `document` has focus](#determining-if-the-document-has-focus)
	* [`document.defaultview` is a shortcut to the head/global object](#documentdefaultview-is-a-shortcut-to-the-headglobal-object)
	* [Getting a reference to the `Document` from an `element` using `ownerDocument`](#getting-a-reference-to-the-document-from-an-element-using-ownerdocument)
* [Element Nodes](#element-nodes)
	* [`HTML*Element` object overview](#htmlelement-object-overview)
	* [`HTML*Element` object properties and methods](#htmlelement-object-properties-and-methods)
	* [Creating Elements](#creating-elements)
	* [Get the tag name of an element](#get-the-tag-name-of-an-element)
	* [Getting a list/collection of element attributes and values](#getting-a-listcollection-of-element-attributes-and-values)
	* [Getting, Setting, & Removing an element's attribute value](#getting-setting-removing-an-elements-attribute-value)
	* [Verifying an element has a specific attribute](#verifying-an-element-has-a-specific-attribute)
	* [Getting a list of class attribute values](#getting-a-list-of-class-attribute-values)
	* [Adding & removing sub-values to a class attribute](#adding-removing-sub-values-to-a-class-attribute)
	* [Toggling a class attribute value](#toggling-a-class-attribute-value)
	* [Determining if a class attribute value contains a specific value](#determining-if-a-class-attribute-value-contains-a-specific-value)
	* [Getting & Setting data-* attributes](#getting-setting-data-attributes)
* [Element Node Selecting](#element-node-selecting)
	* [Selecting a specific element node](#selecting-a-specific-element-node)
	* [Selecting/creating a list (aka `NodeList`) of element nodes](#selectingcreating-a-list-aka-nodelist-of-element-nodes)
	* [Selecting all immediate child element nodes](#selecting-all-immediate-child-element-nodes)
	* [Contextual element selecting](#contextual-element-selecting)
	* [Pre-configured selections/lists of element nodes](#pre-configured-selectionslists-of-element-nodes)
	* [Verify an element will be selected using `matches()`](#verify-an-element-will-be-selected-using-matches)

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

### Verify a node position in the DOM tree with `contains()` & `compareDocumentPosition()`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<script>

// is <body> inside <html lang="en"> ?
var inside = document.querySelector('html').contains(document.querySelector('body'));

console.log(inside); //logs true

</script>
</body>
</html>
```

| **number code returned from** `compareDocumentPosition()`: | **number code info:**          |
|:-----------------------------------------------------------|:-------------------------------|
| 0                                                          | Elements are identical.        |
| 1                                                          | DOCUMENT_POSITION_DISCONNECTED |
| 2                                                          | DOCUMENT_POSITION_PRECEDING    |
| 4                                                          | DOCUMENT_POSITION_FOLLOWING    |
| 8                                                          | DOCUMENT_POSITION_CONTAINS     |
| 16 (10 in hexadecimal)                                     | DOCUMENT_POSITION_CONTAINED_BY |

### How to determine if two nodes are identical

Two nodes are equal if, and only if, the following conditions are satisfied:
* The two nodes are of the same type.
* The following string attributes are equal:
	* `nodeName`
	* `localName`
	* `namespaceURI`
	* `prefix`
	* `nodeValue`
* The `attributes NamedNodeMaps` are equal.
* The `childNodes NodeLists` are equal.

```html
<!DOCTYPE html>
<html lang="en">
<body>

<input type="text">
<input type="text">

<textarea>foo</textarea>
<textarea>bar</textarea>

<script>

//logs true, because they are exactly idential
var input = document.querySelectorAll('input');
console.log(input[0].isEqualNode(input[1]));

//logs false, because the child text node is not the same
var textarea = document.querySelectorAll('textarea');
console.log(textarea[0].isEqualNode(textarea[1]));

</script>
</body>
</html>
```

## Document Nodes

### `document` node overview

The `HTMLDocument` constructor (which inherits from `document`) when instantiated represents a `DOCUMENT_NODE` (i.e. `window.document`) in the DOM.

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

console.log(window.document.constructor); //logs function HTMLDocument() { [native code] }
console.log(window.document.nodeType); //logs 9, which is a numeric key mapping to DOCUMENT_NODE

</script>
</body>
</html>
```

### `HTMLDocument` properties and methods

* `doctype`
* `documentElement`
* `implementation.*`
* `activeElement`
* `body`
* `head`
* `title`
* `lastModified`
* `referrer`
* `URL`
* `defaultview`
* `compatMode`
* `ownerDocument`
* `hasFocus()`

### Getting general HTML document information

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

var d = document;
console.log('title = ' +d.title);
console.log('url = ' +d.URL);
console.log('referrer = ' +d.referrer);
console.log('lastModified = ' +d.lastModified);

//logs either BackCompat (Quirks Mode) or CSS1Compat (Strict Mode)
console.log('compatibility mode = ' +d.compatMode);

</script>
</body>
</html>
```

### `document` child nodes

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

//This is the doctype/DTD
console.log(document.childNodes[0].nodeType); //logs 10, which is a numeric key mapping to DOCUMENT_TYPE_NODE

//This is the <html> element
console.log(document.childNodes[1].nodeType); //logs 1, which is a numeric key mapping to ELEMENT_TYPE_NODE

</script>
</body>
</html>
```

### `document` provides shortcuts to `<!DOCTYPE>`, `<html lang="en">`, `<head>`, and `<body>`

* `document.doctype` refers to `<!DOCTYPE>`
* `document.documentElement` refers to `<html lang="en">`
* `document.head` refers to `<head>`
* `document.body` refers to `<body>`

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

console.log(document.doctype); // logs DocumentType {nodeType=10, ownerDocument=document, ...}

console.log(document.documentElement); // logs <html lang="en">

console.log(document.head); // logs <head>

console.log(document.body); // logs <body>

</script>

</body>
</html>
```

### Detecting DOM specifications/features using `document.implementation.hasFeature()`

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

console.log(document.implementation.hasFeature('Core','2.0'));
console.log(document.implementation.hasFeature('Core','3.0'));

</script>
</body>
</html>
```

The following table defines the features and versions you can pass the `hasFeature()` method

| **Feature**                                                             | **Supported Versions** |
|:------------------------------------------------------------------------|:-----------------------|
| Core                                                                    | 1.0, 2.0, 3.0          |
| XML                                                                     | 1.0, 2.0, 3.0          |
| HTML                                                                    | 1.0, 2.0               |
| Views                                                                   | 2.0                    |
| StyleSheets                                                             | 2.0                    |
| CSS                                                                     | 2.0                    |
| CSS2                                                                    | 2.0                    |
| Events                                                                  | 2.0, 3.0               |
| UIEvents                                                                | 2.0, 3.0               |
| MouseEvents                                                             | 2.0, 3.0               |
| MutationEvents                                                          | 2.0, 3.0               |
| HTMLEvents                                                              | 2.0                    |
| Range                                                                   | 2.0                    |
| Traversal                                                               | 2.0                    |
| LS (Loading and saving between files and DOM trees sychronously)        | 3.0                    |
| LS-asnc (Loading and saving between files and DOM trees asynchronously) | 3.0                    |
| Validation                                                              | 3.0                    |

### Get a reference to the focus/active node in the `document`

```html
<!DOCTYPE html>
<html lang="en">
<body>
<textarea></textarea>

<script>

//set focus to <textarea>
document.querySelector('textarea').focus();

​//get reference to element that is focused/active in the document
console.log(document.activeElement); //logs <textarea>

</script>
</body>
</html>
```

### Determining if the `document` has focus

```html
<!DOCTYPE html>
<html lang="en">
<body>

<script>

//If you keep focus on the window/tab that has the document loaded its true. If not it's false.
setTimeout(function(){console.log(document.hasFocus())},5000);

</script>
</body>
</html>
```

### `document.defaultview` is a shortcut to the head/global object

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

console.log(document.defaultView) //reference, head JS object. Would be window object in a browser.

</script>
</body>
</html>
```

### Getting a reference to the `Document` from an `element` using `ownerDocument`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<iframe src="http://someFileServedFromServerOnSameDomain.html"></iframe>

<script>

//get the window.document that the <body> is contained within
console.log(document.body.ownerElement);

//get the window.document the <body> inside of the iframe is contained within
console.log(window.frames[0].document.body.ownerElement);

</script>
</body>
</html>
```

## Element Nodes

### `HTML*Element` object overview

Elements in an html document all have a unique nature and as such they all have a unique JavaScript constructor that instantiates the element as a  node object in a DOM tree.

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a></a>

<script>

// grab <a> element node from DOM and ask for the name of the constructor that constructed it
console.log(document.querySelector('a').constructor);
//logs function HTMLAnchorElement() { [native code] }

</script>
</body>
</html>
```

There's a [complete list](https://html.spec.whatwg.org/multipage/indices.html#index) at the whatwg page.

### `HTML*Element` object properties and methods

* `createElement()`
* `tagName`
* `children`
* `getAttribute()`
* `setAttribute()`
* `hasAttribute()`
* `removeAttribute()`
* `classList()`
* `dataset`
* `attributes`

### Creating Elements

```html
<!DOCTYPE html>
<html lang="en">
<body>
<script>

var elementNode = document.createElement('textarea'); //HTMLTextAreaElement() constructs <textarea>
document.body.appendChild(elementNode);

console.log(document.querySelector('textarea')); //verify it's now in the DOM

</script>
</body>
</html>
```

### Get the tag name of an element

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href="#">Hi</a>

<script>

console.log(document.querySelector('a').tagName); //logs A

//the nodeName property returns the same value
console.log(document.querySelector('a').nodeName); //logs A

</script>
</body>
</html>
```

### Getting a list/collection of element attributes and values

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href='#' title="title" data-foo="dataFoo" class="yes" style="margin:0;" foo="boo"></a>

<script>

var atts = document.querySelector('a').attributes;

for(var i=0; i< atts.length; i++){
	console.log(atts[i].nodeName +'='+ atts[i].nodeValue);
}

</script>
</body>
</html>
```

### Getting, Setting, & Removing an element's attribute value

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href='#' title="title" data-foo="dataFoo" style="margin:0;" class="yes" foo="boo" hidden="hidden">#link</a>

<script>

var atts = document.querySelector('a');

//remove attributes
atts.removeAttribute('href');
atts.removeAttribute('title');
atts.removeAttribute('style');
atts.removeAttribute('data-foo');
atts.removeAttribute('class');
atts.removeAttribute('foo'); //custom attribute
atts.removeAttribute('hidden'); //boolean attribute

//set (really re-set) attributes
atts.setAttribute('href','#');
atts.setAttribute('title','title');
atts.setAttribute('style','margin:0;');
atts.setAttribute('data-foo','dataFoo');
atts.setAttribute('class','yes');
atts.setAttribute('foo','boo');
atts.setAttribute('hidden','hidden'); //boolean attribute requires sending the attribute as the value too

//get attributes
console.log(atts.getAttribute('href'));
console.log(atts.getAttribute('title'));
console.log(atts.getAttribute('style'));
console.log(atts.getAttribute('data-foo'));
console.log(atts.getAttribute('class'));
console.log(atts.getAttribute('foo'));
console.log(atts.getAttribute('hidden'));

</script>
</body>
</html>
```

### Verifying an element has a specific attribute

```html
<!DOCTYPE html>
<html lang="en">
<body>

<a href='#' title="title" data-foo="dataFoo" style="margin:0;" class="yes" goo></a>

<script>

var atts = document.querySelector('a');

console.log(
	atts.hasAttribute('href'),
	atts.hasAttribute('title'),
	atts.hasAttribute('style'),
	atts.hasAttribute('data-foo'),
	atts.hasAttribute('class'),
	atts.hasAttribute('goo') //Notice this is true regardless if a value is defined
)

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<input type="checkbox" checked></input>

<script>

var atts = document.querySelector('input');

console.log(atts.hasAttribute('checked')); //logs true

</script>
</body>
</html>
```

### Getting a list of class attribute values

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div class="big brown bear"></div>

<script>

var elm = document.querySelector('div');

console.log(elm.classList); //big brown bear {0="big", 1="brown", 2="bear", length=3, ...}
console.log(elm.className); //logs 'big brown bear'

</script>
</body>
</html>
```

### Adding & removing sub-values to a class attribute

```html
<!DOCTYPE html>
<html lang="en">
<body>
<div class="dog"></div>​

<script>

var elm = document.querySelector('div');

elm.classList.add('cat');
elm.classList.remove('dog');
console.log(elm.className); //'cat'

</script>
</body>
</html>
```

### Toggling a class attribute value

```html
<!DOCTYPE html>
<html lang="en">
<body>
<div class="visible"></div>​

<script>

var elm = document.querySelector('div');

elm.classList.toggle('visible');
elm.classList.toggle('grow');
console.log(elm.className); //'grow'

</script>
</body>
</html>
```

### Determining if a class attribute value contains a specific value

```html
<!DOCTYPE html>
<html lang="en">
<body>
<div class="big brown bear"></div>​

<script>

var elm = document.querySelector('div');

console.log(elm.classList.contains('brown')); //logs true

</script>
</body>
</html>
```

### Getting & Setting data-* attributes

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div data-foo-foo="foo" data-bar-bar="bar"></div>​

<script>

var elm = document.querySelector('div');

//get
console.log(elm.dataset.fooFoo); //logs 'foo'
console.log(elm.dataset.barBar); //logs 'bar'

//set
elm.dataset.gooGoo = 'goo';
console.log(elm.dataset); //logs DOMStringMap {fooFoo="foo", barBar="bar", gooGoo="goo"}

//what the element looks like in the DOM
console.log(elm); //logs <div data-foo-foo="foo" data-bar-bar="bar" data-goo-goo="goo">

</script>
</body>
</html>
```

## Element Node Selecting

### Selecting a specific element node

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul>
<li>Hello</li>
<li>big</li>
<li>bad</li>
<li id="last">world</li>
</ul>

<script>

console.log(document.querySelector('li').textContent); //logs Hello
console.log(document.getElementById('last').textContent); //logs world

</script>
</body>
</html>
```

### Selecting/creating a list (aka `NodeList`) of element nodes

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul>
<li class="liClass">Hello</li>
<li class="liClass">big</li>
<li class="liClass">bad</li>
<li class="liClass">world</li>
</ul>

<script>

//all of the methods below create/select the same list of <li> elements from the DOM
console.log(document.querySelectorAll('li'));            // static
console.log(document.getElementsByTagName('li'));        // live
console.log(document.getElementsByClassName('liClass')); // live

</script>
</body>
</html>
```

### Selecting all immediate child element nodes

```html <!DOCTYPE html>
<html lang="en">
<body>

<ul>
<li><strong>Hi</strong></li>
<li>there</li>
</ul>

<script>

var ulElement = document.querySelector('ul').children; // live

//logs a list/array of all immediate child element nodes
console.log(ulElement); //logs [<li>, <li>]

</script>
</body>
</html>
```

### Contextual element selecting

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div>
<ul>
<li class="liClass">Hello</li>
<li class="liClass">big</li>
<li class="liClass">bad</li>
<li class="liClass">world</li>
</ul>
</div>

<ul>
<li class="liClass">Hello</li>
</ul>

<script>

//select a div as the context to run the selecting methods only on the contents of the div
var div = document.querySelector('div');

console.log(div.querySelector('ul'));
console.log(div.querySelectorAll('li'));
console.log(div.getElementsByTagName('li'));
console.log(div.getElementsByClassName('liClass'));

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<script>

//create DOM structure
var divElm = document.createElement('div');
var ulElm = document.createElement('ul');
var liElm = document.createElement('li');
liElm.setAttribute('class','liClass');
ulElm.appendChild(liElm);
divElm.appendChild(ulElm);

//use selecting methods on DOM structure
console.log(divElm.querySelector('ul'));
console.log(divElm.querySelectorAll('li'));
console.log(divElm.getElementsByTagName('li'));
console.log(divElm.getElementsByClassName('liClass'));

</script>
</body>
</html>
```

### Pre-configured selections/lists of element nodes

* `document.all` - all elements in HTML document
* `document.forms` - all `<form>` elements in HTML document
* `document.images` - all `<img>` elements in HTML document
* `document.links` - all `<a>` elements in HTML document
* `document.scripts` - all `<script>` elements in HTML document
* `document.styleSheets` - all `<link>` or `<style>` objects in HTML document

### Verify an element will be selected using `matches()`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul>
<li>Hello</li>
<li>world</li>
</ul>

<script>

console.log(document.querySelector('li').matches('li:first-child')); // logs true

</script>
</body>
</html>
```
