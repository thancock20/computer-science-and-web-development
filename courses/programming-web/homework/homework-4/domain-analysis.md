# Domain Analysis


## Props

`min` - (`String`) minimum allowed font size
`max` - (`String`) maximum allowed font size
`size` - (`String`) initial font size
`text` - (`String`) text to display
`bold` - (`Boolean`) whether or not text is bold

## State

`isHidden` - (`Boolean`) whether or not controls are hidden (`true`)
`isBold` - (`Boolean`) whether or not the text is bold (`this.props.bold`)
`isRed` - (`Boolean`) whether or not the text is red (depends on props: `min`, `max`, and `size`)
`min` - (`Number`) minimum allowed font size (depends on props: `min` and `max`)
`max` - (Number) maximum allowed font size (depends on props: `min` and `max`)
`initialSize` - (Number) initial font size
`size` - (`Number`) current font size (depends on props: `min`, `max`, and `size`)

## Events

`onChange` on `boldCheckbox`
`onClick` on `decreaseButton`
`onDoubleClick` on `fontSizeSpan`
`onClick` on `increaseButton`
`onClick` on `textSpan`
