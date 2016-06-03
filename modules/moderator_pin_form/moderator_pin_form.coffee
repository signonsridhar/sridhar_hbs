define([
    'bases/control',
    'models/auth/auth',
    'models/conference_pin/conference_pin',
    'css!modules/moderator_pin_form/moderator_pin_form'
], (BaseControl,Auth, ConferencePin)->
    BaseControl.extend({
        LANG:()->
            errors = {
                pin:{},
                confirm_pin:{}
            }

            LANG = {
                errors:errors
            }
            errors.pin[VALID.ERROR.REQUIRED] = 'new pin is required'
            errors.pin[VALID.ERROR.FORMAT] = 'must be 4 digits'
            errors.confirm_pin[VALID.ERROR.REQUIRED] = 'confirm pin is required'
            errors.confirm_pin[VALID.ERROR.EQUAL] = 'the confirm pin you entered does not match'

            LANG.title='Change Conference PIN'
            LANG.desc='PIN must be 4 digits'
            LANG.pin_changed= 'PIN changed'

            LANG.errors[VALID.ERROR.INVALID] = 'Failed to update PIN'

            LANG

    }, {
        init:(elem, options)->
            options.conference_pin = new ConferencePin({
                userid: Auth.get_auth().get_user_id()
            })
            this.setup_viewmodel({
                is_pin_changed: false
            })
            this.render('moderator_pin_form/moderator_pin_form', {conference_pin: options.conference_pin})
            options.conference_pin.set_validated_attrs(['pin','confirm_pin'])
            this.bind_view(options.conference_pin)
            this.set_validity(false)
            this.on()

        validate: ()->
            this.options.conference_pin.validate()


        '{conference_pin.valid} change': ()->
            this.set_validity(this.options.conference_pin.valid())

        'form submit':()->
            this.viewmodel.attr('errors.display', null)
            this.viewmodel.attr('is_pin_changed', false)
            if this.options.conference_pin.valid()
                form_data = {
                    pin: this.options.conference_pin.attr('pin')
                    confirm_pin: this.options.conference_pin.attr('confirm_pin')
                }
                req = {
                    user_id: Auth.get_auth().get_user_id()
                    pin: form_data.pin
                }
                this.options.settings.change_moderator_pin(req).done(()=>
                        this.viewmodel.attr('is_pin_changed', true)
                    ).fail(()=>
                        #show error here>
                        this.viewmodel.attr('is_pin_changed', false)
                        this.viewmodel.attr('errors.display', "invalid")
                    )

                return false
            else
                this.validate()
                return false

    })
)