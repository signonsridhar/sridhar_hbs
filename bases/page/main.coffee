define([
    'bases/control',
    'css!libs/foundation-4.3.2.custom/css/normalize',
    'css!libs/foundation-4.3.2.custom/css/foundation',
    'css!bases/page/css/base'
    'css!bases/page/css/access'
], (BaseControl)->
    BaseControl.extend({
        TEMPLATE_BASE_URL:'pages'
    },
    {
        switch_sub:(sub)->
            path_to_func = "#{sub} sub"
            this[path_to_func]() if this[path_to_func]

        '{can.route} sub':(route, e, new_val, old_val)->
            this.switch_sub(new_val)
    })
)