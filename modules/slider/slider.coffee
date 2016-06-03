define(['bases/control'], (BaseControl)->
    BaseControl.extend({

        init: (element, options)->

            element.slider({
                range: 'max',
                min: options.min,
                max: options.max,
                change:(e)-> options.value(element.slider('value'))
                slide:(e)-> options.value(element.slider('value'))
            })
            element.slider('value', options.value())
    })
)