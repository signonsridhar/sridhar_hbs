define(['bases/control',
        '_',
        'models/phone/phone',
        'css!modules/phone_selector_search_form/phone_selector_search_form'
], (BaseControl, _, Phone, SearchFormCss)->
    BaseControl.extend({
        phone_list:{},#TODO needed ?
        init: (elem, options)->
            console.log('init number selector form options ', options)
            this.setup_viewmodel({
                phone_list:[]#list of div phones
            })


            this.viewmodel.attr_promise('phone_list', Phone.find_phone())
            this.render('phone_selector_search_form/phone_selector_search_form')
            this.$phone_list = this.find('.phone_list_js')

        '.phone_list_js .choice_js click':(elem)->
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
            this.$phone_list.find('ul').children().removeClass('selected_js')
            nth_child = this.$phone_list.find('.choice_js:nth-child('+(index+1)+')')
            nth_child.addClass('selected_js')

        refresh:()->
            #this.viewmodel.attr('phone_list',[])
            return this.viewmodel

        get_selected: ()->
            this.options.viewmodel.selected

    })
)