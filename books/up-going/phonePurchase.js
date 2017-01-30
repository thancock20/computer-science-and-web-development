const taxRate           = 0.08;
const phonePrice        = 99.99;
const accessoryPrice    = 19.99;
const spendingThreshold = 300;

var bankBalance = 525.54;
var amount      = 0;

function calculateTax(amt) {
  return amt * taxRate;
}

function formatPrice(price) {
  return "$" + price.toFixed(2);
}

while (amount < bankBalance) {
  amount += phonePrice;

  if ( amount < spendingThreshold) {
    amount += accessoryPrice;
  }
}

amount += calculateTax(amount);

console.log("Total Price: " + formatPrice(amount));

if (amount > bankBalance) {
  console.log("You can't afford it!!");
}
