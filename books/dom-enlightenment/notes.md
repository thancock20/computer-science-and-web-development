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
* [Element Node Geometry & Scrolling Geometry](#element-node-geometry-scrolling-geometry)
	* [Element node size, offsets, and scrolling overview](#element-node-size-offsets-and-scrolling-overview)
	* [Getting an elements `offsetTop` and `offsetLeft` values releative to the `offsetParent`](#getting-an-elements-offsettop-and-offsetleft-values-releative-to-the-offsetparent)
	* [Getting an elements top, right, bottom, and left border edge offset relative to the viewport using `getBoundingClientRect()`](#getting-an-elements-top-right-bottom-and-left-border-edge-offset-relative-to-the-viewport-using-getboundingclientrect)
	* [Getting an elements size (border + padding + content) in the viewport](#getting-an-elements-size-border-padding-content-in-the-viewport)
	* [Getting an elements size (padding + content) in the viewport excluding borders](#getting-an-elements-size-padding-content-in-the-viewport-excluding-borders)
	* [Getting topmost element in viewport at specific point using `elementFromPoint()`](#getting-topmost-element-in-viewport-at-specific-point-using-elementfrompoint)
	* [Getting the size of the element being scrolled using `scrollHeight` and `scrollWidth`](#getting-the-size-of-the-element-being-scrolled-using-scrollheight-and-scrollwidth)
	* [Getting & Setting pixels scrolled from the top and left using `scrollTop` and `scrollLeft`](#getting-setting-pixels-scrolled-from-the-top-and-left-using-scrolltop-and-scrollleft)
	* [Scrolling an element into view using `scrollIntoView()`](#scrolling-an-element-into-view-using-scrollintoview)
* [Element Node Inline Styles](#element-node-inline-styles)
	* [Style Attribute (aka element inline CSS properties) Overview](#style-attribute-aka-element-inline-css-properties-overview)
	* [Getting, setting, & removing individual inline CSS properties](#getting-setting-removing-individual-inline-css-properties)
	* [Getting, setting, & removing all inline CSS properties](#getting-setting-removing-all-inline-css-properties)
	* [Getting an elements computed styles (i.e. actual styles including any from the cascade) using `getComputedStyle()`](#getting-an-elements-computed-styles-ie-actual-styles-including-any-from-the-cascade-using-getcomputedstyle)
	* [Apply & remove CSS properties on an element using `class` & `id` attributes](#apply-remove-css-properties-on-an-element-using-class-id-attributes)
* [Text Nodes](#text-nodes)
	* [`Text` object overview](#text-object-overview)
	* [`Text` object & properties](#text-object-properties)
	* [White space creates `Text` nodes](#white-space-creates-text-nodes)
	* [Creating & Injecting `Text` Nodes](#creating-injecting-text-nodes)
	* [Getting a `Text` node value with `.data` or `nodeValue`](#getting-a-text-node-value-with-data-or-nodevalue)
	* [Manipulating `Text` nodes with `appendData()`, `deleteData()`, `insertData()`, `replaceData()`, `subStringData()`](#manipulating-text-nodes-with-appenddata-deletedata-insertdata-replacedata-substringdata)
	* [When multiple sibling `Text` nodes occur](#when-multiple-sibling-text-nodes-occur)
	* [Remove markup and return all child `Text` nodes using `textContent`](#remove-markup-and-return-all-child-text-nodes-using-textcontent)
	* [Combine sibling `Text` nodes into one text node using `normalize()`](#combine-sibling-text-nodes-into-one-text-node-using-normalize)
	* [Splitting a text node using `splitText()`](#splitting-a-text-node-using-splittext)
* [DocumentFragment Nodes](#documentfragment-nodes)
	* [`DocumentFragment` object overview](#documentfragment-object-overview)
	* [Creating `DocumentFragment`'s using `createDocumentFragment()`](#creating-documentfragments-using-createdocumentfragment)
	* [Adding a `DocumentFragment` to the live DOM](#adding-a-documentfragment-to-the-live-dom)
	* [Using `innerHTML` on a `documentFragment`](#using-innerhtml-on-a-documentfragment)
	* [Leaving a fragment's containing nodes in memory by cloning](#leaving-a-fragments-containing-nodes-in-memory-by-cloning)
* [CSS Style Sheets & CSS rules](#css-style-sheets-css-rules)
	* [CSS Style sheet overview](#css-style-sheet-overview)
	* [Accessing all style sheets (i.e. `CSSStylesheet` objects) in the DOM](#accessing-all-style-sheets-ie-cssstylesheet-objects-in-the-dom)
	* [`CSSStyleSheet` properties and methods](#cssstylesheet-properties-and-methods)
	* [`CSSStyleRule` overview](#cssstylerule-overview)
	* [`CSSStyleRule` properties and methods](#cssstylerule-properties-and-methods)
	* [Getting a list of CSS Rules in a style sheet using `CSSRules`](#getting-a-list-of-css-rules-in-a-style-sheet-using-cssrules)
	* [Inserting & deleting CSS rules in a style sheet using `.insertRule()` and `.deleteRule()`](#inserting-deleting-css-rules-in-a-style-sheet-using-insertrule-and-deleterule)
	* [Editing the value of a `CSSStyleRule` using the `.style` property](#editing-the-value-of-a-cssstylerule-using-the-style-property)
	* [Creating a new inline CSS style sheet](#creating-a-new-inline-css-style-sheet)
	* [Programatically adding external style sheets to an HTML document](#programatically-adding-external-style-sheets-to-an-html-document)
	* [Disabling/Enabling style sheets using `disabled` property](#disablingenabling-style-sheets-using-disabled-property)

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

## Element Node Geometry & Scrolling Geometry

### Element node size, offsets, and scrolling overview

DOM nodes are parsed and painted into visual shapes when viewing html documents in a web browser. Nodes, mostly element nodes, have a corresponding visual representation made viewable/visual by browsers. To inspect and in some cases manipulate the visual representation and geometry of nodes programatically a set of API's exists and are specified in the CSSOM View Module. A subset of methods and properties found in this specification provide an API to determine the geometry (i.e. size & position using offset) of element nodes as well as hooks for manipulating scrollable nodes and getting values of scrolled nodes.

### Getting an elements `offsetTop` and `offsetLeft` values releative to the `offsetParent`

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
body{margin:0;}
#blue{height:100px;width:100px;background-color:blue;border:10px solid gray; padding:25px;margin:25px;}
#red{height:50px;width:50px;background-color:red;border:10px solid gray;}
</style>
</head>
<body>

<div id="blue"><div id="red"></div></div>

<script>

var div = document.querySelector('#red');

console.log(div.offsetLeft); //logs 60
console.log(div.offsetTop); //logs 60
console.log(div.offsetParent); //logs <body>

</script>
</body>
</html>
```

### Getting an elements top, right, bottom, and left border edge offset relative to the viewport using `getBoundingClientRect()`

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
body{margin:0;}
div{height:50px;width:50px;background-color:red;border:10px solid gray;margin:100px;}
</style>
</head>
<body>

<div></div>

<script>

var divEdges = document.querySelector('div').getBoundingClientRect();

console.log(divEdges.top, divEdges.right, divEdges.bottom, divEdges.left); //logs '100 170 170 100'

</script>
</body>
</html>
```

### Getting an elements size (border + padding + content) in the viewport

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
div{height:25px;width:25px;background-color:red;border:25px solid gray;padding:25px;}
</style>
</head>
<body>

<div></div>

<script>

var div = document.querySelector('div').getBoundingClientRect();

console.log(div.height, div.width); //logs '125 125'
//because 25px border + 25px padding + 25 content + 25 padding + 25 border = 125

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
div{height:25px;width:25px;background-color:red;border:25px solid gray;padding:25px;}
</style>
</head>
<body>

<div></div>

<script>

var div = document.querySelector('div');

console.log(div.offsetHeight, div.offsetWidth); //logs '125 125'
//because 25px border + 25px padding + 25 content + 25 padding + 25 border = 125

</script>
</body>
</html>
```

### Getting an elements size (padding + content) in the viewport excluding borders

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
div{height:25px;width:25px;background-color:red;border:25px solid gray;padding:25px;}
</style>
</head>
<body>

<div></div>

<script>

var div = document.querySelector('div');

console.log(div.clientHeight, div.clientWidth); //logs '75 75' because 25px padding + 25 content + 25 padding = 75

</script>
</body>
</html>
```

### Getting topmost element in viewport at specific point using `elementFromPoint()`

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
div{height:50px;width:50px;background-color:red;position:absolute;top:50px;left:50px;}
</style>
</head>
<body>

<div id="bottom"></div><div id="top"></div>

<script>

console.log(document.elementFromPoint(50,50)); //logs <div id="top">

</script>
</body>
</html>
```

### Getting the size of the element being scrolled using `scrollHeight` and `scrollWidth`

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
*{margin:0;padding:0;}
div{height:100px;width:100px; overflow:auto;}
p{height:1000px;width:1000px;background-color:red;}
</style>
</head>
<body>

<div><p></p></div>

<script>

var div = document.querySelector('div');

console.log(div.scrollHeight, div.scrollWidth); //logs '1000 1000'

</script>
</body>
</html>
```

### Getting & Setting pixels scrolled from the top and left using `scrollTop` and `scrollLeft`

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
div{height:100px;width:100px;overflow:auto;}
p{height:1000px;width:1000px;background-color:red;}
</style>
</head>
<body>

<div><p></p></div>

<script>

var div = document.querySelector('div');

div.scrollTop = 750;
div.scrollLeft = 750;

console.log(div.scrollTop,div.scrollLeft); //logs '750 750'

</script>
</body>
</html>
```

### Scrolling an element into view using `scrollIntoView()`

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
div{height:30px;width:30px; overflow:auto;}
p{background-color:red;}
</style>
</head>
<body>

<div>
<content>
<p>1</p>
<p>2</p>
<p>3</p>
<p>4</p>
<p>5</p>
<p>6</p>
<p>7</p>
<p>8</p>
<p>9</p>
<p>10</p>
</content>
</div>

<script>

//select <p>5</p> and scroll that element into view, I pass children '4' because its a zero index array-like structure
document.querySelector('content').children[4].scrollIntoView(true);

</script>
</body>
</html>
```

## Element Node Inline Styles

### Style Attribute (aka element inline CSS properties) Overview

Every HTML element has a style attribute that can be used to inline CSS properties specific to the element.

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div style="background-color:red;border:1px solid black;height:100px;width:100px;"></div>

<script>

var divStyle = document.querySelector('div').style;

//logs CSSStyleDeclaration {0="background-color", ...}
console.log(divStyle);

 </script>
</body>
</html>
```

### Getting, setting, & removing individual inline CSS properties

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div></div>

<script>

var divStyle = document.querySelector('div').style;

//set
divStyle.backgroundColor = 'red';
divStyle.border = '1px solid black';
divStyle.width = '100px';
divStyle.height = '100px';

//get
console.log(divStyle.backgroundColor);
console.log(divStyle.border);
console.log(divStyle.width);
console.log(divStyle.height);

/*remove
divStyle.backgroundColor = '';
divStyle.border = '';
divStyle.width = '';
divStyle.height = '';
*/

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
</style>
</head>

<body>

<div style="background-color:green;border:1px solid purple;"></div>

<script>

var divStyle = document.querySelector('div').style;

//set
divStyle.setProperty('background-color','red');
divStyle.setProperty('border','1px solid black');
divStyle.setProperty('width','100px');
divStyle.setProperty('height','100px');

//get
console.log(divStyle.getPropertyValue('background-color'));
console.log(divStyle.getPropertyValue('border'));
console.log(divStyle.getPropertyValue('width'));
console.log(divStyle.getPropertyValue('height'));

/*remove
divStyle.removeProperty('background-color');
divStyle.removeProperty('border');
divStyle.removeProperty('width');
divStyle.removeProperty('height');
*/

</script>
</body>
</html>
```

### Getting, setting, & removing all inline CSS properties

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div></div>

<script>

var div = document.querySelector('div');
var divStyle = div.style;

//set using cssText
divStyle.cssText = 'background-color:red;border:1px solid black;height:100px;width:100px;';
//get using cssText
console.log(divStyle.cssText);
//remove
divStyle.cssText = '';

//exactly that same outcome using setAttribute() and getAttribute()

//set using setAttribute
div.setAttribute('style','background-color:red;border:1px solid black;height:100px;width:100px;');
//get using getAttribute
console.log(div.getAttribute('style'));
//remove
div.removeAttribute('style');

</script>
</body>
</html>
```

### Getting an elements computed styles (i.e. actual styles including any from the cascade) using `getComputedStyle()`

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
​div{
    background-color:red;
    border:1px solid black;
    height:100px;
    width:100px;
}
</style>
</head>

<body>

<div style="background-color:green;border:1px solid purple;"></div>

<script>

var div = document.querySelector('div');

//logs rgb(0, 128, 0) or green, this is an inline element style
console.log(window.getComputedStyle(div).backgroundColor);

//logs 1px solid rgb(128, 0, 128) or 1px solid purple, this is an inline element style
console.log(window.getComputedStyle(div).border);

//logs 100px, note this is not an inline element style
console.log(window.getComputedStyle(div).height);

//logs 100px, note this is not an inline element style
console.log(window.getComputedStyle(div).width);

</script>
</body>
</html>
```

### Apply & remove CSS properties on an element using `class` & `id` attributes

```html
<!DOCTYPE html>
<html lang="en">
<head>
<style>
.foo{
  background-color:red;
  padding:10px;
}
#bar{
  border:10px solid #000;
  margin:10px;
}
</style>
</head>
<body>

<div></div>

<script>

var div = document.querySelector('div');

//set
div.setAttribute('id','bar');
div.classList.add('foo');

/*remove
div.removeAttribute('id');
div.classList.remove('foo');
*/

</script>
</body>
</html>
```

## Text Nodes

### `Text` object overview


Text in an HTML document is represented by instances of the `Text()` constructor function, which produces text nodes. When an HTML document is parsed the text mixed in among the elements of an HTML page are converted to text nodes.

```html
<!DOCTYPE html>
<html lang="en">
<body>

<p>hi</p>

<script>

//select 'hi' text node
var textHi = document.querySelector('p').firstChild

console.log(textHi.constructor); //logs Text()

//logs Text {textContent="hi", length=2, wholeText="hi", ...}
console.log(textHi);

</script>
</body>
</html>
```

### `Text` object & properties

* `textContent`
* `splitText()`
* `appendData()`
* `deleteData()`
* `insertData()`
* `replaceData()`
* `subStringData()`
* `nomalize()`
* `data`

### White space creates `Text` nodes

```html
<!DOCTYPE html>
<html lang="en">
<body>

<p id="p1"></p>
<p id="p2"> </p>

<script>

console.log(document.querySelector('#p1').firstChild) //logs null
console.log(document.querySelector('#p2').firstChild.nodeName) //logs #text

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<p id="p1"></p>
<!-- yes there is a carriage return text node before this comment, even this comment is a node -->
<p id="p2"></p>

<script>

console.log(document.querySelector('#p1').nextSibling) //logs Text

</script>
</body>
</html>
```

### Creating & Injecting `Text` Nodes

```html
<!DOCTYPE html>
<html lang="en">
<body>

<div></div>

<script>

var textNode = document.createTextNode('Hi');
document.querySelector('div').appendChild(textNode);

console.log(document.querySelector('div').innerText); // logs Hi

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">

<div></div>

<body>

<script>

var elementNode = document.createElement('p');
var textNode = document.createTextNode('Hi');
elementNode.appendChild(textNode);
document.querySelector('div').appendChild(elementNode);

console.log(document.querySelector('div').innerHTML); //logs <div>Hi</div>

</script>
</body>
</html>
```

### Getting a `Text` node value with `.data` or `nodeValue`

```html
<!DOCTYPE html>
<html lang="en">

<p>Hi, <strong>cody</strong></p><body>

<script>

console.log(document.querySelector('p').firstChild.data); //logs 'Hi,'
console.log(document.querySelector('p').firstChild.nodeValue); //logs 'Hi,'

</script>
</body>
</html>
```

### Manipulating `Text` nodes with `appendData()`, `deleteData()`, `insertData()`, `replaceData()`, `subStringData()`

```html
<!DOCTYPE html>
<html lang="en">

<p>Go big Blue Blue<body>

<script>

var pElementText = document.querySelector('p').firstChild;

//add !
pElementText.appendData('!');
console.log(pElementText.data);

//remove first 'Blue'
pElementText.deleteData(7,5);
console.log(pElementText.data);

//insert it back 'Blue'
pElementText.insertData(7,'Blue ');
console.log(pElementText.data);

//replace first 'Blue' with 'Bunny'
pElementText.replaceData(7,5,'Bunny ');
console.log(pElementText.data);

//extract substring 'Blue Bunny'
console.log(pElementText.substringData(7,10));

</script>
</body>
</html>
```

### When multiple sibling `Text` nodes occur

```html
<!DOCTYPE html>
<html lang="en">
<body>

<p>Hi, <strong>cody</strong> welcome!</p>

<script>

var pElement = document.querySelector('p');

console.log(pElement.childNodes.length); //logs 3

console.log(pElement.firstChild.data); // is text node or 'Hi, '
console.log(pElement.firstChild.nextSibling); // is Element node or <strong>
console.log(pElement.lastChild.data); ​// is text node or ' welcome!'

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>

<script>

var pElementNode = document.createElement('p');
var textNodeHi = document.createTextNode('Hi ');
var textNodeCody = document.createTextNode('Cody');

pElementNode.appendChild(textNodeHi);
pElementNode.appendChild(textNodeCody);

document.querySelector('div').appendChild(pElementNode);

console.log(document.querySelector('div p').childNodes.length); //logs 2​​​​​​​​​​​​​​​​​​

</script>
</body>
</html>
```

### Remove markup and return all child `Text` nodes using `textContent`

```html
<!DOCTYPE html>
<html lang="en">
<body>
<h1> Dude</h2>
<p>you <strong>rock!</strong></p>
<script>

console.log(document.body.textContent); //logs 'Dude you rock!' with some added white space

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<body>
<div>
<h1> Dude</h2>
<p>you <strong>rock!</strong></p>
</div>
<script>

document.querySelector('div').textContent = 'You don\'t rock!'
console.log(document.querySelector('div').textContent); //logs 'You don't rock!'

</script>
</body>
</html>
```

### Combine sibling `Text` nodes into one text node using `normalize()`

```html
<!DOCTYPE html>
<html lang="en">
<body>
<div></div>
<script>

var pElementNode = document.createElement('p');
var textNodeHi = document.createTextNode('Hi');
var textNodeCody = document.createTextNode('Cody');

pElementNode.appendChild(textNodeHi);
pElementNode.appendChild(textNodeCody);

document.querySelector('div').appendChild(pElementNode);

console.log(document.querySelector('p').childNodes.length); //logs 2

document.querySelector('div').normalize(); //combine our sibling text nodes

console.log(document.querySelector('p').childNodes.length); //logs 1

</script>
</body>
</html>
```

### Splitting a text node using `splitText()`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<p>Hey Yo!</p>

<script>

//returns a new text node, taken from the DOM
console.log(document.querySelector('p').firstChild.splitText(4).data); //logs Yo!

//What remains in the DOM...
console.log(document.querySelector('p').firstChild.textContent); //logs Hey

</script>
</body>
</html>
```

## DocumentFragment Nodes

### `DocumentFragment` object overview

The creation and use of a `DocumentFragment` node provides a light weight document DOM that is external to the live DOM tree. Think of `DocumentFragment` as an empty document template that acts just like the live DOM tree, but only lives in memory, and its child nodes can easily be manipulated in memory and then appended to the live DOM.

### Creating `DocumentFragment`'s using `createDocumentFragment()`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<script>

var docFrag = document.createDocumentFragment();

["blue", "green", "red", "blue", "pink"].forEach(function(e) {
    var li = document.createElement("li");
    li.textContent = e;
    docFrag.appendChild(li);
});

console.log(docFrag.textContent); //logs bluegreenredbluepink

</script>
</body>
</html>
```

Differences between using a `DocumentFragment` and creating an element in memory:
* A document fragment may contain any kind of node (except `<body>` or `<html>`) where as an element may not
* The document fragment itself is not added to the DOM when you append a fragment. The contents of the node are. As opposed to appending an element node in which the element itself is part of the appending.
* When a document fragment is appended to the DOM it transfers from the document fragment to the place it's appended. It's no longer in memory in the place you created it. This is not true for element nodes that are temporarily used to contain nodes briefly and then are moved to the live DOM.

### Adding a `DocumentFragment` to the live DOM

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul></ul>

<script>

var ulElm = document.queryselector('ul');
var docFrag = document.createDocumentFragment();

["blue", "green", "red", "blue", "pink"].forEach(function(e) {
    var li = document.createElement("li");
    li.textContent = e;
    docFrag.appendChild(li);
});

ulElm.appendChild(docFrag);

//logs <ul><li>blue</li><li>green</li><li>red</li><li>blue</li><li>pink</li></ul>
console.log(document.body.innerHTML);

</script>
</body>
</html>
```

### Using `innerHTML` on a `documentFragment`

```html
<!DOCTYPE html>
<html lang="en">
<body>

<script>

//create a <div> and document fragment
var divElm = document.createElement('div');
var docFrag = document.createDocumentFragment();

//append div to document fragment
docFrag.appendChild(divElm);

//create a DOM structure from a string
docFrag.querySelector('div').innerHTML = '<ul><li>foo</li><li>bar</li></ul>';

//the string becomes a DOM structure I can call methods on like querySelectorAll()
//Just don't forget the DOM structure is wrapped in a <div>
console.log(docFrag.querySelectorAll('li').length); //logs 2

//append, starting with the first child node contained inside of the <div>
document.querySelector('div').appendChild(docFrag.querySelector('div').firstChild);

//logs <ul><li>foo</li><li>bar</li></ul>
console.log(document.querySelector('div').innerHTML);

</script>
</body>
</html>
```

### Leaving a fragment's containing nodes in memory by cloning

```html
<!DOCTYPE html>
<html lang="en">
<body>

<ul></ul>

<script>

//create ul element and document fragment
var ulElm = document.querySelector('ul');
var docFrag = document.createDocumentFragment();

//append li's to document fragment
["blue", "green", "red", "blue", "pink"].forEach(function(e) {
    var li = document.createElement("li");
    li.textContent = e;
    docFrag.appendChild(li);
});

//append cloned document fragment to ul in live DOM
ulElm.appendChild(docFrag.cloneNode(true));

//logs <li>blue</li><li>green</li><li>red</li><li>blue</li><li>pink</li>
console.log(document.querySelector('ul').innerHTML);

//logs [li,li,li,li,li]
console.log(docFrag.childNodes);

</script>
</body>
</html>
```

## CSS Style Sheets & CSS rules

### CSS Style sheet overview

A style sheet is added to an HTML document by either using the `HTMLLinkElement` node (i.e `<link href="stylesheet.css" rel="stylesheet" type="text/css">`) to include an external style sheet or the `HTMLStyleElement` node (i.e. `<style></style>`) to define a style sheet inline.

```html
<!DOCTYPE html>
<html lang="en">
<head>

<link id="linkElement" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css" rel="stylesheet" type="text/css">

<style id="styleElement">
body{background-color:#fff;}
</style>

</head>
<body>

<script>

//logs function HTMLLinkElement() { [native code] }
console.log(document.querySelector('#linkElement').constructor);

//logs function HTMLStyleElement() { [native code] }
console.log(document.querySelector('#styleElement').constructor);

</script>
</body>
</html>
```

Once a style sheet is added to an HTML document it's represented by the `CSSStylesheet` object. Each CSS rule inside of a style sheet is represented by a `CSSStyleRule` object.

```html
<!DOCTYPE html>
<html lang="en">
<head>

<style id="styleElement">
body{background-color:#fff;}
</style>

</head>
<body>

<script>

//logs function CSSStyleSheet() { [native code] } because this object is the stylesheet itself
console.log(document.querySelector('#styleElement').sheet.constructor);

//logs function CSSStyleRule() { [native code] } because this object is the rule inside of the style sheet
console.log(document.querySelector('#styleElement').sheet.cssRules[0].constructor);

</script>
</body>
</html>
```

### Accessing all style sheets (i.e. `CSSStylesheet` objects) in the DOM

```html
<!DOCTYPE html>
<html lang="en">
<head>

<link href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css" rel="stylesheet" type="text/css">

<style>
body{background-color:red;}
</style>

</head>
<body>

<script>

console.log(document.styleSheets.length); //logs 2
console.log(document.styleSheets[0]); // the <link>
console.log(document.styleSheets[1]); // the <style>

</script>
</body>
</html>
```

```html
<!DOCTYPE html>
<html lang="en">
<head>

<link id="linkElement" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css" rel="stylesheet" type="text/css">

<style id="styleElement">
body{background-color:#fff;}
</style>

</head>
<body>

<script>

//get CSSStylesheeet object for <link>
console.log(document.querySelector('#linkElement').sheet); //same as document.styleSheets[0]

//get CSSSstylesheet object for <style>
console.log(document.querySelector('#styleElement').sheet); //same as document.styleSheets[1]

</script>
</body>
</html>
```

### `CSSStyleSheet` properties and methods

(ro = read only)
* `disabled`
* `href` (ro)
* `media` (ro)
* `ownerNode` (ro)
* `parentStylesheet` (ro)
* `title` (ro)
* `type` (ro)
* `cssRules`
* `ownerRule`
* `deleteRule`
* `insertRule`

### `CSSStyleRule` overview

A `CSSStyleRule` object represents each CSS rule contained in a style sheet. Basically, a `CSSStyleRule` is the interface to the CSS properties and values attached to a selector.

```html
<!DOCTYPE html>
<html lang="en">
<head>

<style id="styleElement">
body{background-color:#fff;margin:20px;} /*this is a css rule*/
p{line-height:1.4em; color:blue;} /*this is a css rule*/
</style>

</head>
<body>

<script>

var sSheet = document.querySelector('#styleElement');

console.log(sSheet.cssRules[0].cssText); //logs "body { background-color: red; margin: 20px; }"
console.log(sSheet.cssRules[1].cssText); //logs "p { line-height: 1.4em; color: blue; }"

</script>
</body>
</html>
```

### `CSSStyleRule` properties and methods

* `cssText`
* `parentRule`
* `parentStyleSheet`
* `selectorText`
* `style`
* `type`

### Getting a list of CSS Rules in a style sheet using `CSSRules`

```html
<!DOCTYPE html>
<html lang="en">
<head>

<style id="styleElement">
body{background-color:#fff;margin:20px;}
p{line-height:1.4em; color:blue;}
</style>

</head>
<body>

<script>

var sSheet = document.querySelector('#styleElement').sheet;

//array like list containing all of the CSSrule objects repreesenting each CSS rule in the style sheet
console.log(sSheet.cssRules);

console.log(sSheet.cssRules.length); //logs 2

//rules are index in a CSSRules list starting at a 0 index
console.log(sSheet.cssRules[0]); //logs first rule
console.log(sSheet.cssRules[1]); //logs second rule

</script>
</body>
</html>
```

### Inserting & deleting CSS rules in a style sheet using `.insertRule()` and `.deleteRule()`

```html
<!DOCTYPE html>
<html lang="en">
<head>

<style id="styleElement">
p{line-height:1.4em; color:blue;} /*index 0*/
p{font-size:50px;} /*index 1*/
</style>

</head>
<body>

<p>Hi</p>

<script>

//add a new CSS rule at index 1 in the inline style sheet
document.querySelector('#styleElement').sheet.insertRule('p{color:red}',1);

//verify it was added
console.log(document.querySelector('#styleElement').sheet.cssRules[1].cssText);

//Delete what we just added
document.querySelector('#styleElement').sheet.deleteRule(1);

//verify it was removed
console.log(document.querySelector('#styleElement').sheet.cssRules[1].cssText);

</script>
</body>
</html>
```

### Editing the value of a `CSSStyleRule` using the `.style` property

```html
<!DOCTYPE html>
<html lang="en">
<head>

<style id="styleElement">
p{color:blue;}
strong{color:green;}
</style>

</head>
<body>

<p>Hey <strong>Dude!</strong></p>

<script>

var styleSheet = document.querySelector('#styleElement').sheet;

//Set css rules in stylesheet
styleSheet.cssRules[0].style.color = 'red';
styleSheet.cssRules[1].style.color = 'purple';

//Get css rules
console.log(styleSheet.cssRules[0].style.color); //logs 'red'
console.log(styleSheet.cssRules[1].style.color); //logs 'purple'

</script>
</body>
</html>
```

### Creating a new inline CSS style sheet

```html
<!DOCTYPE html>
<html lang="en">
<head></head>
<body>

<p>Hey <strong>Dude!</strong></p>

<script>

var styleElm = document.createElement('style');
styleElm.innerHTML = 'body{color:red}';

//notice markup in the document changed to red from our new inline stylesheet
document.querySelector('head').appendChild(styleElm);

</script>
</body>
</html>
```

### Programatically adding external style sheets to an HTML document

```html
<!DOCTYPE html>
<html lang="en">
<head></head>
<body>

<script>

//create & add attributes to <link>
var linkElm = document.createElement('link');
linkElm.setAttribute('rel', 'stylesheet');
linkElm.setAttribute('type', 'text/css');
linkElm.setAttribute('id', 'linkElement');
linkElm.setAttribute('href', 'http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css');

//Append to the DOM
document.head.appendChild(linkElm);

//confrim its addition to the DOM
// logs <link id="linkElement" rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css">
console.log(document.querySelector('#linkElement'));

</script>
</body>
</html>
```

### Disabling/Enabling style sheets using `disabled` property

```html
<!DOCTYPE html>
<html lang="en">
<head>

<link id="linkElement" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css" rel="stylesheet" type="text/css">

<style id="styleElement">
body{color:red;}
</style>

</head>
<body>

<script>

//Get current boolean disabled value
console.log(document.querySelector('#linkElement').disabled); //log 'false'
console.log(document.querySelector('#styleElement').disabled); //log 'false'

//Set disabled value, which of course disables all styles for this document
document.document.querySelector('#linkElement').disabled = true;
document.document.querySelector('#styleElement').disabled = true;

</script>
</body>
</html>
```
