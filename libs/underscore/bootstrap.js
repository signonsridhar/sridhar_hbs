define([
    'libs/underscore/underscore',
    'libs/underscore/underscore.date',
    'libs/underscore/underscore_string',
    'libs/underscore/underscore_inflection'
], function (_, _str) {
    require(['underscore.string'],function(_str){
        window._.str = _str
        window._.inflect = function(qty, singular){
            return qty > 1? window._.pluralize(singular): singular
        }
        window._.inflect_full = function(qty, singular){
            return qty + ' ' + window._.inflect(qty, singular)
        }

    })
    return window._
})