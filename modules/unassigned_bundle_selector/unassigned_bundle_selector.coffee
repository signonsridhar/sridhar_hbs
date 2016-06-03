define(['bases/control',
        '_',
        'models/bundle/bundle',
        'css!modules/unassigned_bundle_selector/unassigned_bundle_selector'
], (BaseControl, _, Bundle, BundleSelectorCss)->
    BaseControl.extend({
        init: (elem, options)->
            this.setup_viewmodel({
                bundle_list:[]#list of unassigned bundles
            })

            this.viewmodel.attr('bundle_list', options.bundles)
            this.render('unassigned_bundle_selector/unassigned_bundle_selector')
            this.$bundle_list = this.find('.bundle_list_js')

        '.bundle_list_js .choice_js click':(elem)->
            index = elem.data('index')
            did_obj = this.viewmodel.bundle_list[index]
            this.viewmodel.attr('selected', did_obj )

        '{viewmodel} selected change': ()->
            bundle_list = this.viewmodel.attr('bundle_list')
            did_obj = this.viewmodel.selected
            index = bundle_list.indexOf(did_obj)
            this.$bundle_list.find('ul').children().removeClass('selected_js')
            nth_child = this.$bundle_list.find('.choice_js:nth-child('+(index+1)+')')
            nth_child.addClass('selected_js')

        show_hide_search_form:(hide)->
            if hide
                this.element.find('.navbar_main').hide()
            else
                this.element.find('.navbar_main').show()

        refresh:()->
            #this.viewmodel.attr('bundle_list',[])
            return this.viewmodel

        get_selected: ()->
            this.options.viewmodel.selected

    })
)