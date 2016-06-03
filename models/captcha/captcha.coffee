define([
    'bases/model',
    'env!dev:models/captcha/fixture/get_captcha',
], (BaseModel)->
    BaseModel.extend({
        update:()->
            this.attr('update', _.uniqueId('captcha_update_'))

        load: (email)->
            $.get('/bss/authentication?action=getcaptcha&identification=' + encodeURIComponent(email)).then((response, code)=>
                this.attr('is_locked', false)
                this.attr('key', response.data)
                this.update()

            ).fail((response)=>
                if response.code == 1177
                    this.attr('is_locked', true)
                this.update()
            )

    })
)