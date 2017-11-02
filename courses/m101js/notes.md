# Notes related to what I learned while completing this


## Week One: Introduction

Simple example app running express, mongodb and nunjucks as templating engine:

```js
// app.js
var express = require('express'),
    app = express(),
    engines = require('consolidate'),
    MongoClient = require('mongodb').MongoClient,
    assert = require('assert');

app.engine('html', engines.nunjucks);
app.set('view engine', 'html');
app.set('views', __dirname + '/views');

MongoClient.connect('mongodb://localhost:27017/video', function(err, db) {

  assert.equal(null, err);
  console.log("Successfully connected to MongoDB.");

  app.get('/', function(req, res) {

    db.collection('movies').find({}).toArray(function(err, docs) {
      res.render('movies', { 'movies': docs });
    });

  });

  app.use(function(req, res) {
    res.sendStatus(404);
  });

  var server = app.listen(3000, function() {
    var port = server.address().port;
    console.log('Express server listening on port %s.', port);
  });

});
```

```html
<!-- movies.html -->
<head>
<style>
body { font-family: 'Helvetica', 'Arial', sans-serif; }
</style>
</head>

<h1>Movies</h1>
<ul>
{% for movie in movies %}
  <li><a href="http://www.imdb.com/title/{{ movie.imdb }}">{{ movie.title }}, {{ movie.year }}</a></li>
{% else %}
  <li>No movies found.</li>
{% endfor %}
</ul>
```

## Week Two: CRUD


* **Creating Documents**
  * `insertOne()`
  * `insertMany()`
* **Reading Documents**
  * `find()`
  * `findOne()`
* **Updating Documents**
  * `updateOne()`
  * `updateMany()`
  * `replaceOne()`
* **Deleting Documents**
  * `deleteOne()`
  * `deleteMany()`

  ## Week Three: The Node.js Driver


  ```js
  var MongoClient = require('mongodb').MongoClient,
    commandLineArgs = require('command-line-args'),
    assert = require('assert');


var options = commandLineOptions();


MongoClient.connect('mongodb://localhost:27017/crunchbase', function(err, db) {

    assert.equal(err, null);
    console.log("Successfully connected to MongoDB.");

    var query = queryDocument(options);
    var projection = {"_id": 0, "name": 1, "founded_year": 1,
                      "number_of_employees": 1};

    var cursor = db.collection('companies').find(query);
    cursor.project(projection);
    cursor.limit(options.limit);
    cursor.skip(options.skip);
    cursor.sort([["founded_year", 1], ["number_of_employees", -1]]);

    var numMatches = 0;

    cursor.forEach(
        function(doc) {
            numMatches = numMatches + 1;
            console.log(doc.name + "\n\tfounded " + doc.founded_year +
                        "\n\t" + doc.number_of_employees + " employees");
        },
        function(err) {
            assert.equal(err, null);
            console.log("Our query was:" + JSON.stringify(query));
            console.log("Documents displayed: " + numMatches);
            return db.close();
        }
    );

});


function queryDocument(options) {

    console.log(options);

    var query = {
        "founded_year": {
            "$gte": options.firstYear,
            "$lte": options.lastYear
        }
    };

    if ("employees" in options) {
        query.number_of_employees = { "$gte": options.employees };
    }

    return query;

}


function commandLineOptions() {

    var cli = commandLineArgs([
        { name: "firstYear", alias: "f", type: Number },
        { name: "lastYear", alias: "l", type: Number },
        { name: "employees", alias: "e", type: Number },
        { name: "skip", type: Number, defaultValue: 0 },
        { name: "limit", type: Number, defaultValue: 20000 }
    ]);

    var options = cli.parse()
    if ( !(("firstYear" in options) && ("lastYear" in options))) {
        console.log(cli.getUsage({
            title: "Usage",
            description: "The first two options below are required. The rest are optional."
        }));
        process.exit();
    }

    return options;

}
```
