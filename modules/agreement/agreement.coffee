define(['bases/control'], (BaseControl)->
    BaseControl.extend({
        LANG:()->
            LANG = {
                tos:'By checking this box, I accept the <a href="http://t-mobileatwork.com/legal/pbx_legal/index.html" target="_blank">Terms and Conditions</a> of this service'
                e911: 'I understand that <a href="http://t-mobileatwork.com/support/e911" target="_blank">E911 service</a> may be limited or unavailable'
            }
            LANG.errors = {
                tos: {}
                e911: {}
            }
            LANG.errors.tos[VALID.ERROR.REQUIRED] = 'You are required to our Terms of Service'
            LANG.errors.e911[VALID.ERROR.REQUIRED] = 'You are required to agree to 911 service limitations'

            return LANG
    },{
        init:(elem, options)->

            this.set_validity(false)
            validations = {
                tos: ()->
                    tos = this.attr('tos')
                    this.check(tos, VALID.ERROR.REQUIRED).notEmpty()
                    this.validity('tos', VALID.YES)
                e911: ()->
                    e911 = this.attr('e911')
                    this.check(e911, VALID.ERROR.REQUIRED).notEmpty()
                    this.validity('e911', VALID.YES)
            }
            this.setup_viewmodel({
                enable:options.enable
            })
            this.viewmodel.setup_validations(_.pick(validations, options.enable))
            this.viewmodel.validate(options.enable)
            this.render('agreement/agreement')

            this.bind_view(this.viewmodel)

        enable:(new_enable)->
            this.viewmodel.attr('enable', new_enable)
        '{viewmodel} change':()->
            this.set_validity(this.viewmodel.valid())
        validate:()->
            this.viewmodel.validate()

    })
)