define(['bases/control'], (BaseControl)->

    BaseControl.extend({
        init: ()->
            this.render('footer/default/footer')
    })
)