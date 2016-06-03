define(['libs/qtip/qtip', 'css!libs/qtip/qtip'], ()->
    ###
        there is no VALID.NO because we do not need it,
        we just return the type of error
    ###
    window.VALID = {
        YES:1,
        MAYBE:2,
        ERROR:{
            REQUIRED:'required',
            SIZE:'size',
            FORMAT:'format',
            UNIQUE:'unique',
            EQUAL:'equal',
            INVALID:'invalid',
            RANGE:'range'
        },
        show_tooltip:($el, msg, $contents = null)->
            $el_test = $el
            $el.removeClass('success error')
            if not msg
                #remove the qtip
                console.log('remove qtip', msg, $el)
                $el.qtip and $el.qtip('destroy', true)
                $el.addClass('success')
            else #this is error
                #add qtip
                    $el.addClass('error')
                    if not $el.data('qtip')
                        if not $contents #if not iframe
                            position = {
                                my:'bottom center',
                                at: 'top center'
                            }

                        else #if iframe
                            position = {
                                my: 'bottom center',
                                at: 'top center',
                                adjust: {
                                    x: $contents.offset().left,
                                    y: $contents.offset().top
                                }
                            }
                        $el.qtip({
                            style:{
                                classes:'qtip-light qtip-rounded qtip-shadow'
                                tip: {
                                    corner: true
                                }
                            },
                            show: {
                                event: 'focus mouseenter mouseover'
                                solo: true
                            },
                            hide:{
                                event: 'blur mouseout'
                            },
                            position: position,
                            content:{
                                text: 'something'
                            }
                        })
                    $el.qtip('api').set('content.text', _.str.capitalize(msg))
                    $el.qtip('toggle', true)

        render:(map, model, key, $el, $contents)->
            model.bind('__valid.' + key, (e, status)=>
                this.show_tooltip($el, map[key][status], $contents)
            )

    }
    VALID.show_tooltip = _.debounce(VALID.show_tooltip, 500)
    return VALID
)