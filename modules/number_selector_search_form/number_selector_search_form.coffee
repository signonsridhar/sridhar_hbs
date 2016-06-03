define(['bases/control',
        '_',
        'models/phone_number/phone_number',
        'modules/state_list/state_list',
        'libs/jquery_numeric',
        'modules/pagination/pagination',
        'css!modules/number_selector_search_form/number_selector_search_form'
], (BaseControl, _, PhoneNumber, StateList, Pagination, SearchFormCss)->
    BaseControl.extend({
        phone_list:{},#TODO needed ?
        init: (elem, options)->
            console.log('init number selector form options ', options)
            this.setup_viewmodel({
                area_code:'',#input
                city: '',#input
                state: '',#select/option,
                phone_list:[],#list of div phonenumbers
                show_spinner: true
            })
            this.render('number_selector_search_form/number_selector_search_form')
            new StateList(this.element.find('.state_dropdown_container'), {
                model: this.viewmodel
                attr: 'state'
            })
            this.find('input[name="area_code"]').numeric()

            #            StateList.load().done (response)=>
            #                this.render('html/abbr_state_dropdown', {states:response, name:'state'}, )
            #                this.bind_view(this.viewmodel)
            this.bind_view(this.viewmodel)
            this.$number_list = this.find('.number_list_js')
            console.log('this.$number_list dom >>>>', this.$number_list)


        checkViewModelChange : ()->

            phone_options = _.pick(this.viewmodel, 'area_code', 'city', 'state')
            phone_options = $.extend(phone_options,
            {country: this.options.country, partnerid: this.options.partnerid, count: 10})
            if(phone_options.area_code || (phone_options.city && phone_options.state))
                if (phone_options.area_code)
                    phone_options.country = undefined
                this.viewmodel.attr('show_spinner', true)
                promise = PhoneNumber.find_local(phone_options)
                this.viewmodel.attr_promise('phone_list', promise)
                promise.done((data)=>
                    ###if (data.length > 0)
                        pagination###
                ).fail((data)=>
                    this.viewmodel.attr('phone_list',[])
                ).always(()=>
                    this.viewmodel.attr('show_spinner', false)
                )
            else
                this.viewmodel.attr('show_spinner', false)
                this.viewmodel.attr('phone_list',[])

        show_hide_search_form:(hide)->
            if hide
                this.element.find('.dt_navbar_main').hide()
            else
                this.element.find('.dt_navbar_main').show()

        '{viewmodel} area_code change':()->
            if this.viewmodel.area_code
                this.viewmodel.attr('city', '')
                this.viewmodel.attr('state', '')
            #this.checkViewModelChange()

        '{viewmodel} city change':()->
            if this.viewmodel.city
                this.viewmodel.attr('area_code', '')
            #this.checkViewModelChange()

        '{viewmodel} state change':()->
            if this.viewmodel.state
                this.viewmodel.attr('area_code', '')
            console.log(' state change >>>', this.viewmodel.attr('state'))
            #this.checkViewModelChange()

        '.number_list_js .choice_js click':(elem)->
            index = elem.data('index')
            console.log('index ', index)
            did_obj = this.viewmodel.phone_list[index]
            console.log('did_obj ', did_obj)
            this.viewmodel.attr('selected', did_obj )

        '{viewmodel} selected change': ()->
            phone_list = this.viewmodel.attr('phone_list')
            did_obj = this.viewmodel.selected
            index = phone_list.indexOf(did_obj)
            console.log('index :', index)
            this.$number_list.find('ul').children().removeClass('selected_js')
            nth_child = this.$number_list.find('.choice_js:nth-child('+(index+1)+')')
            nth_child.addClass('selected_js')

        refresh:(city='',state='')->
            this.viewmodel.attr('phone_list',[])
            this.viewmodel.attr('area_code', '')
            this.viewmodel.attr('city', '')
            this.viewmodel.attr('state', '')
            this.viewmodel.attr('city', city)
            this.viewmodel.attr('state', state)
            return this.viewmodel

        refresh_toll:()->
            this.refresh()
            phone_options = {country: this.options.country, partnerid: this.options.partnerid, start_offset:0, count: 10}
            promise = PhoneNumber.find_toll(phone_options)
            this.viewmodel.attr_promise('phone_list', promise)
            promise.always(()=>
                this.viewmodel.attr('show_spinner', false)
            )
        get_selected: ()->
            this.options.viewmodel.selected

        'form submit':()->
            this.viewmodel.attr('show_spinner', true)
            this.checkViewModelChange()

            return false

    })
)