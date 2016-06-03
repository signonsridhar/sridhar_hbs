define(['bases/control'], (BaseControl)->
    BaseControl.extend({
        init:(elem, options)->
            this.setup_viewmodel({
                offset:0,
                page:1,
                per_page:options.per_page,
                last_visited:null
            })

            this.render('pagination/pagination')
            this.bind_view(this.viewmodel)

        page: ()->
            return Math.floor(this.viewmodel.attr('offset') / this.viewmodel.attr('per_page')) + 1

        next: ()->
            this.viewmodel.attr('offset', this.viewmodel.attr('offset') + this.viewmodel.attr('per_page') )


        '.next_js click': ()->
            this.next()
    })
)