define([
    'bases/control',
    'css! modules/toggle/toggle'],(BaseControl)->
    BaseControl.extend({
        defaults:{
            toggle:{
                ON:true,
                OFF:false
            }
        }

    },
    {
        init:(elem, options)->
            this.setup_viewmodel({})

            this.set_toggle(options.toggle)
            this.set_css(options.css)

            this.render("toggle/toggle")
            this.set_value(this.get_model_value())

        get_model_value:()->
            return null if not this.options.model?
            #console.log('get_model_value', this.options.attr, this.options.model.attr())
            this.options.model.attr(this.options.attr)

        set_toggle: (toggle)->
            return if not toggle?
            this.viewmodel.attr('toggle',  toggle)

        set_css:(css)->
            this.viewmodel.attr('css', css)

        turn_val_to_raw:(string_val)->
            toggles = this.options.toggle
            for label of toggles
                toggle_val = toggles[label]
                return toggle_val if toggle_val.toString() == string_val
            throw new Error('invalid value, not found in the selections')

        'input:radio change':($el,e)->
            return if not this.options.model?
            raw_val = this.turn_val_to_raw($el.val())

            this.options.model.attr(this.options.attr, raw_val)

        '{model} change':()->
            model_val = this.get_model_value()
            if model_val?
                this.set_checked_the_value(this.get_model_value().toString())

        get_left_or_right:(val)->
            counter = 0
            for label, value of this.options.toggle
                break if val.toString() == value.toString()
                counter++

            #console.log('counter', counter, val)
            ['on', 'off'][counter]

        set_checked_the_value:(val)->
            this.element.find("input:radio").attr('checked')
            this.element.find("input:radio[value=#{val}]").attr('checked', true)
            #console.log('element switch??', this.get_left_or_right(val))
            this.element.children('.switch').removeClass('on off').addClass(this.get_left_or_right(val))

        set_value:(val)->
            return if not val?
            this.set_checked_the_value(val.toString())
    })
)
