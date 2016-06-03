define(['modules/tab/tab'],(Tab)->
    Tab.extend({
        init:(elem, options)->
            options = {
                css: 'tab_header',
                tabs:{
                    map:{
                        config:{
                            label: 'Configuration',
                            desc: 'Extensions and Call Groups'
                        },
                        account:{
                            label:'My Account',
                            desc:'Service and Billing'
                        },
                        settings:{
                            label:'My Settings',
                            desc:'Profile and Extension Settings'
                        }

                    }
                    change:(key, value)->
                        console.log(key, value)
                        can.route.attr({main: key, sub:'index'}, true)

                    renderer:(key, value)->
                        if key == 'config'
                            "
                                <h4 class='config_label'>Configuration</h4>
                                <h4 class='company_dir_label'>Company Directory</h4>
                                <span class='config_desc'>Extensions and Call Groups</span>
                                <span class='company_dir_desc'>Company Contact List</span>
                            "

                        else
                            "
                                <h4>#{value.label}</h4>
                                <span>#{value.desc}</span>
                            "
                }
            }
            this._super.apply(this, [elem, options])
            this.set_active(can.route.attr('main'))

    })
)