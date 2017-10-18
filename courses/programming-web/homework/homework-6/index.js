var express = require('express');
var app = express();

var Animal = require('./Animal.js');
var Toy = require('./Toy.js');

app.use('/findToy', (req, res) => {
	if (!req.query.id) {
		res.json({});
		return;
	}
	Toy.findOne({id: req.query.id}, (err, toy) => {
		if (err) {
			console.log(err);
			res.json({});
		}
		if (toy) res.json(toy);
		else res.json({});
	});
});

app.use('/findAnimals', (req, res) => {
	var query = {};
	if (req.query.species) query.species = req.query.species;
	if (req.query.gender) query.gender = req.query.gender;
	if (req.query.trait) query.traits = req.query.trait;

	if (Object.keys(query).length === 0)  res.json({});
	Animal.find(query, '-_id name species breed gender age', (err, animals) => {
		if (err) {
			console.log(err);
			res.json({});
		}
		if (animals.length !== 0) res.json(animals);
		else res.json({});
	})
});

app.use('/animalsYoungerThan', (req, res) => {
	if (!req.query.age || Number.isNaN(req.query.age)) res.json({});
	else {
		Animal.find({age: {$lt: req.query.age}}, (err, animals) => {
			if (err) {
				console.log(err);
				res.json({});
			}
			else {
				if (animals.length === 0) res.json({count: 0});
				else {
					var count = animals.length;
					var names = [];
					animals.forEach((animal) => {
						names.push(animal.name);
					})
					res.json({count, names});
				}
			}
		});
	}
});

app.use('/calculatePrice', (req, res) => {
	if (!req.query) {
		res.json({});
		return;
	}

	var ids = req.query.id;
	var qtys = req.query.qty;

	if (ids.length !== qtys.length) {
		res.json({});
		return;
	}

	var resMap = new Map();
	qtys.forEach((qty, idx) => {
		qty = Number(qty);
		if (Number.isNaN(qty) || qty < 1) return;
		var id = ids[idx];
		if (resMap.has(id)) {
			resMap.set(id, resMap.get(id) + qty);
		} else {
			resMap.set(id, qty);
		}
	});

	if (resMap.size === 0) {
		res.json({totalPrice: 0, items: []});
		return;
	}

	Toy.find({id: {$in: [...resMap.keys()]}}, (err, toys) => {
		if (err) {
			console.log(err);
			res.json({});
			return;
		}

		var items = [];
		var totalPrice = 0;
		toys.forEach((toy) => {
			var item = toy.id;
			var qty = resMap.get(item);
			var subtotal = qty * toy.price;
			totalPrice += subtotal;
			items.push({
				item,
				qty,
				subtotal
			});
		});

		res.json({totalPrice, items});
	});
});

app.use('/', (req, res) => {
	res.json({ msg : 'It works!' });
    });

app.listen(3000, () => {
	console.log('Listening on port 3000');
    });



// Please do not delete the following line; we need it for testing!
module.exports = app;
