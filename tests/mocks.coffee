define(['bases/control'], (BaseControl)->

    BaseControl.prototype.render = (tmpl, data, element)->
        #console.log('html>>', tmpl)
        element = element || this.element
        tmpl = "modules/#{tmpl}" if tmpl.charAt(0) != '/'
        tmpl = tmpl + '.html'
        tmpl = window.__html__[tmpl.substr(1)]
        throw "Empty Template" unless tmpl?
        html = can.view.ejs(tmpl, data)
        this.$cont = this.element.children()
        element.html(html)

)