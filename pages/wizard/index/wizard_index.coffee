define([
    'bases/page'
    'modules/tab/tab_header',
    'models/user/user',
    'models/directory/directory',
    '_',
    'modules/dt_dialog/dt_dialog',
    'modules/steps/steps',
    'models/phone/phone',
    'bases/model',
    'models/auth/auth',
    'css! pages/wizard/index/wizard_index'
], (BasePage, TabHeader, User, Directory, _, DTDialog,Steps,Phone,BaseModel,Auth)->

    BasePage.extend({
        init:($elem, options)->

            data = {
                LANG: {
                    buttons: {
                        next: ['Continue','Confirm','Done']
                        prev: 'Back'
                    }
                }
            }

            this.options.curr_step = this.curr_step = data.curr_step = can.compute(1)
            data.total_steps = 3
            tenant_id = this.options.tenant_id = Auth.get_auth().attr('tenant_id')

            this.set_validity(false)

            this.render('wizard/index/wizard_index',data)
            this.$content_elem = this.find('.wizard_content_container_js')
            this.$elem = $elem.find('.wizard_index')

            this.header = new TabHeader(this.find('.tab_header_container'))

            this.options.models = models = new BaseModel()
            models.phone = new Phone()
            this.options.directory = this.options.models.directory = this.directory = new Directory()
            this.options.models.tenant = this.directory.get_tenant_info()
            this.directory.load_wizard_bundles(tenant_id)

        '{directory} length':_.debounce(()->
            if(this.options.directory.length)
                this.switch_sub('index')
        , 100 )

        switch_sub: (sub)->
            sub = 'step_1' if sub == 'index'
            curr_step = parseInt(sub.split('_')[1])
            require(["pages/wizard/#{sub}/wizard_#{sub}"], (PageStep)=>
                this.curr_step(curr_step)
                this.$content_elem.children('.wizard_steps').hide()
                $wizard_cont = $("<div class='wizard_steps wizard_#{sub}'></div>")
                this.$content_elem.append($wizard_cont)
                this.options.page = new PageStep($wizard_cont, { models: this.options.models})
                page = this.options.page
                this.on()
                page.on_show and this.options.page.on_show()
                this.set_validity(this.options.page.validity())
            )

        '{page.validity} change':()->
            console.log 'here? page validity changed?',this.options.page.validity()
            this.set_validity(this.options.page.validity())

        '.step_button.disabled_js click':(elem, e)->
            this.options.page.show_errors and this.options.page.show_errors()
            this.options.page.validate? and this.options.page.validate()
            return false

        '.step_button.enabled_js click': ($elem, e)->
            handle_promise = (promise)->
                if typeof promise == "boolean"
                    return promise
                else
                    promise.done(()=>
                        console.log('handle promise resolved')
                        location.hash = $elem.attr('href')
                    ).fail(()=>
                        console.log('promise failed')#TODO handle error
                    )

                return false
            if $elem.hasClass('next_js')
                promise = this.options.page.on_next()
                handle_promise(promise)
            else #prev_js clicked
                promise = this.options.page.on_prev()
                console.log('this.options.page :', this.options.page)
                handle_promise(promise)

    })
)