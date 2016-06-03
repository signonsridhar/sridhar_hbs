define(['bases/control'], (BaseControl)->
    BaseControl.extend({
        init:(elem, options)->
            this.setup_viewmodel({
                name: if options.name then options.name else options.attr
            })
            self = this;
            this.render('state_list/state_list')
            state_options = this.find('select option')
            state_options.each((idx,state_option)=>
                if(state_option.getAttribute('value') == self.options.model.primary_address_state)
                    state_option.setAttribute("selected","selected")
            )
            this.bind_view(this.viewmodel)


        'select change':(e)->
            this.options.model.attr(this.options.attr, this.find('select').val())

        '{model} change':()->
            value = this.options.model.attr(this.options.attr)
            this.find('select').val(value)
    })
)