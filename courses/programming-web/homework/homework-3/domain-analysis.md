# Domain Analysis


## Constant Information:


## Changing Information:


`dispNum` - Displayed number. `''`
`prevNum` - Previous number. `''`
`operation` - Operation to perform. `''`
`prevOperation` - Previous operation and displayed number. `''`
`lastPressed` - Last button pressed. `'digit'`, `'operator'`, `'equals'`, or `'clear'`. `'clear'`

## DOM Events:


`click` on `digitButton` class.
`click` on `operatorButton` class.
`click` on `clearButton` ID.
`click` on `equalsButton` ID.

## Behavior:


* `digitButton` pressed:
  * `lastPressed` is `digit`:
    * `dispNum = dispNum * 10 + {button's value}`
  * else:
    * `dispNum = {button's value}`
* `operatorButton` pressed:
  * `lastPressed` is `digit`:
    * `prevNum = dispNum`
    * `operation = {button's value}`
  * `lastPressed` is `operator`:
    * `operation = {button's value}`
  * `lastPressed` is `equals`:
    * same as if `digit`
  * `lastPressed` is `clear`:
    * do nothing
* `clearButton` is pressed:
  * `dispNum = prevNum = operation = ''`
* `equalsButton` is pressed:
  * `lastPressed` is `digit`:
    * `if (!prevNum) return`
    * `if (operation === '/' && dispNum === '0')`:
      * `dispNum = 'Infinity'`
    * else:
      * `prevOperation = operation + dispNum`
      * `dispNum = String(eval(prevNum + prevOperation))`
  * `lastPressed` is `equals`:
    * `dispNum = String(eval(dispNum + prevOperation))`
  * else:
    * `return`
