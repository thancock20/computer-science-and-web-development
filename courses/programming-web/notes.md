# Notes from Programming for the Web with JavaScript


<!-- MDTOC maxdepth:6 firsth1:0 numbering:0 flatten:0 bullets:1 updateOnSave:1 -->

- [Introduction to the Internet and the World Wide Web](#Introduction-to-the-Internet-and-the-World-Wide-Web)   
   - [What is the Internet?](#What-is-the-Internet)   
   - [What is the World Wide Web?](#What-is-the-World-Wide-Web)   
   - [Web Page Addresses](#Web-Page-Addresses)   
   - [Content on the World Wide Web](#Content-on-the-World-Wide-Web)   

<!-- /MDTOC -->

## Introduction to the Internet and the World Wide Web

### What is the Internet?

* **Internet** - network of machines (servers, clients, routers, switches, etc.) connected by media (fiber, wifi, etc.) that allows communication among devices
* We can think of the Internet as a graph:
  * Nodes represent devices and information
  * Edges represent a connection (physical or virtual)

  ### What is the World Wide Web?

  * **World Wide Web (WWW)** - an application on the Internet that combines many protocols to allow for communication and transfer of data between machines
  * Web is composed of documents that are logically **linked** to each other
  * Originally designed to:
    * Provide easy access to documents for anyone
    * Provide way in which users can discover documents through a **browser**
    * Web follows similar network structure as the Internet
    * Web pages link to other web pages, thus forming a graph where:
      * Nodes represent an individual document/resource
      * Edges represent a link from one document/resource to another (directed edges)

  ### Web Page Addresses

  * **Uniform Resource Identifier (URI)** - alphanumeric string of characters used to uniquely identify a web page or resource
  * **Uniform Resource Locator (URL)** - type of URI that specifies the location on the WWW and mechanism (protocol) for retrieving it

  ```
  http://www.example.com/home/index.html?a=12&b=34
  ```

  ### Content on the World Wide Web

  * **Static:** same for all users and at all times
    * Appearance may vary based on specific browser, but content itself is the same
    * Technologies: HTML, CSS
  * **Dynamic:** programmatically generated depending on the user, context, configuration, arguments, etc.
    * Technologies: JavaScript
