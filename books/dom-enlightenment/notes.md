# Notes from DOM Enlightenment


<!-- @import "[TOC]" {cmd:"toc", depthFrom:2, depthTo:6, orderedList:false} -->

<!-- code_chunk_output -->

* [Node Overview](#node-overview)
	* [Sub-node objects inherit from the `Node` object:](#sub-node-objects-inherit-from-the-node-object)
	* [Properties and methods for working nodes](#properties-and-methods-for-working-nodes)
	* [Identifying the type and name of a node](#identifying-the-type-and-name-of-a-node)

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
