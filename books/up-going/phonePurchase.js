const TAX_RATE           = 0.08;
const PHONE_PRICE        = 99.99;
const ACCESSORY_PRICE    = 19.99;
const SPENDING_THRESHOLD = 300;

var bankBalance = 525.54;
var amount      = 0;

function calculateTax(amt) {
  return amt * TAX_RATE;
}

function formatPrice(price) {
  return "$" + price.toFixed(2);
}

while (amount < bankBalance) {
  amount += PHONE_PRICE;

  if ( amount < SPENDING_THRESHOLD) {
    amount += ACCESSORY_PRICE;
  }
}

amount += calculateTax(amount);

console.log("Total Price: " + formatPrice(amount));

if (amount > bankBalance) {
  console.log("You can't afford it!!");
}
