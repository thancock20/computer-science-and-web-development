/*
 * Implement all your JavaScript in this file!
 */

var dispNum = '';
var prevNum = '';
var operation = '';
var prevOperation = '';
var lastPressed = 'clear';

$('.digitButton').click(handleDigit);
$('.operatorButton').click(handleOperator);
$('#clearButton').click(handleClear);
$('#equalsButton').click(handleEquals);

function handleDigit(event) {
  if (lastPressed === 'digit') {
    dispNum = dispNum + event.target.value;
  }
  else {
    dispNum = event.target.value;
  }
  lastPressed = 'digit';
  display();
}

function handleOperator(event) {
  if (lastPressed === 'clear') return;
  else if (lastPressed === 'operator') {
    operation = event.target.value;
  } else {
    if (lastPressed === 'digit') handleEquals(event);
    prevNum = dispNum;
    operation = event.target.value;
  }
  lastPressed = 'operator';
  display();
}

function handleClear(event) {
  dispNum = prevNum = operation = '';
  lastPressed = 'clear';
  display();
}

function handleEquals(event) {
  if (lastPressed === 'digit') {
    if (!prevNum) return;
    if (operation === '/' && dispNum === '0') {
      dispNum = 'Infinity';
    } else {
      prevOperation = operation + dispNum;
      dispNum = String(eval(prevNum + prevOperation))
      prevNum = operation = '';
    }
  }
  else if (lastPressed === 'equals') {
    dispNum = String(eval(dispNum + prevOperation))
  }
  else return;
  lastPressed = 'equals'
  display();
}

function display() {
  $('#display').val(dispNum);
}
