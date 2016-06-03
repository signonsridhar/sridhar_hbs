define(['bases/control'], (BaseControl)->

    BaseControl.extend({
        init:(elem, options)->
            this.setup_viewmodel({})
            this.viewmodel.bind('enabled', ()=>

                $elements = this.find(':input').filter(':not(input[type=submit])').filter(':not(.toggle_switch)')
                #console.log('input children', $elements)
                if this.viewmodel.attr('enabled')
                    $elements.removeAttr('disabled')
                else
                    $elements.attr('disabled', 'disabled')
            )
    })
)