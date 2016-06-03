define(['can', '_', 'libs/jsurl', 'bases/model'], (can, _, JSURL, BaseModel)->

    #setup state so that the controllers can share one state
    #and we dont have to type {can.route} state.something to listen
    # we will just do {state} header or something

    window.state = new can.Map({})
    can.route.bind('state change', ()->
        new_state = JSURL.parse(can.route.attr('state'))
        curr_state = window.state.serialize()
        return if _.isEqual(new_state, curr_state)
        window.state.attr(new_state, true)
    )

    BaseContol = can.Control.extend({
        TEMPLATE_BASE_URL: 'modules'
        NORMALIZED_INPUT_TYPES:{
            email: 'text'
            number: 'text'
            url: 'text'
            date: 'text'
            #add more here if we need more input types
        }
        BIND_EVENTS:
            text: ['keyup', 'change'],
            textarea: 'keyup',
            number: 'keyup',
            radio: 'change',
            checkbox: 'change',
            select: 'change'
        defaults:
            id:null,
            state:{}
        }
    ,
        bound_models: null,
        set_options: (options)->
            this.options = options
            this.on()
            this


        set_validity: (validity)->
            if not this.validity?
                this.validity = this.options.validity = can.compute()
                this.on()

            this.validity(validity)

        get_validity:()->
            return null if not this.validity?
            this.validity()
#   '{state} <key>':(state, e, params)-> #all changes in state
    #options passed, look for the state
        state: { #this is just a wrapper for can.route.attr('state')
            get_all:()->
                curr_state = can.route.attr('state')
                curr_state =  unless _.isEmpty(curr_state) then {} else JSURL.parse(curr_state)
                curr_state
            set: (key, val)->
                curr_state = this.get_all()

                if val == null
                    delete curr_state[key]
                else
                    curr_state[key] = val
                can.route.attr("state", JSURL.stringify(curr_state))

            get:(key)->
                curr_state = this.state.get_all()
                curr_state[key]
        }
        setup_viewmodel:( default_vals = {} )->
            this.viewmodel = this.options.viewmodel = new BaseModel($.extend({
                errors:{},
                valid:{}
            }, default_vals))
            this.on()

        #dump all the errors out
        show_all_errors: ()->
            return unless this.bound_models?

            raw_errors = {}
            for key of this.bound_models
                raw_errors[key] =  this.bound_models[key].model.errors()
            this.viewmodel.attr('errors').attr(raw_errors, true)

        set_component: ($element, klass, options)->
            if typeof($element) == 'string'
                $element = this.element.find($element)
            else
                $element = $($element)
            controls = $element.data('controls')

            if controls?
                for control in controls
                    #if found the klass, just change the state
                    return control.set_options(options) if control instanceof klass
            else
                #component is not set then create one
                return new klass($element, options)

        #this is weird, given an element, it will just return it
        #if it's a string it will find it, inside its element
        elementize:($input)->
            $input = this.element.find($input) if _.isString($input)
            $input

        #given the url, return the html
        get_raw_html:(tmpl, data)->
            tmpl = "#{this.constructor.TEMPLATE_BASE_URL}/#{tmpl}" if tmpl.charAt(0) != '/'
            tmpl = tmpl + '.html'
            can.view(require.toUrl(tmpl), data)

#        renders template to the given element
#        @ejs        path to the ejs file, modularly named ex: main/header without ejs
#        @data       data to be passed to the view
#        @element    (optional)element to be rendered on

        render: (tmpl, data = {}, element)->
            element = element || this.element
            this.setup_viewmodel() if not this.options.viewmodel?
            data.viewmodel = this.options.viewmodel
            data.validity = this.options.validity

            data.LANG = this.constructor.LANG(this) if this.constructor.LANG?
            html = this.get_raw_html(tmpl, data)
            element.html(html)
            return element

        render_string: (tmpl_str, data = {}, element)->
            element = element || this.element
            this.setup_viewmodel() if not this.options.viewmodel?
            data.viewmodel = this.options.viewmodel
            data.validity = this.options.validity
            data.LANG = this.constructor.LANG(this) if this.constructor.LANG?
            renderer = can.view.ejs(tmpl_str)
            html = renderer(data)
            element.html(html)
            return element

        #given the $input, it will get the value of it
        get_input_value:($input)->
            val = null
            $input = this.elementize($input)
            switch this.get_input_type_of($input)
                when 'checkbox'
                    val = $input.filter(':checked').map(()->
                        $(this).attr('value')
                    ).get()
                    val.sort() unless _.isEmpty(val)
                when 'radio'
                    val = $input.filter(':checked').val()
                else
                    val = $input.val()
            val = null if _.isEmpty(val)
            return val

        set_input_value:($input, values)->
            $input = this.elementize($input)
            #return if not values? #this is commented out because calling removeAttr wont update the input
            return if _.isEqual(this.get_input_value($input), values)
            switch this.get_input_type_of($input)
                when 'button', 'submit', 'hidden'
                    $input
                when 'radio'
                    $input.val([values])
                when 'checkbox'
                    if values?
                        $input.filter("[value=#{value}]") for value in values
                else #it could be input type="email"
                    $input.val(values)

        #give the input type of the given input element
        #@$input the given input element

        get_input_type_of: ($input)->
            $input = this.elementize($input)
            type = $input.prop('tagName') #it could be a <select>
            type = (type or 'text').toLocaleLowerCase()
            type = $input.prop('type') if (type == 'input')
            type = this.constructor.NORMALIZED_INPUT_TYPES[type] if this.constructor.NORMALIZED_INPUT_TYPES[type]?
            return type
        find: ()->
            this.element.find.apply(this.element, arguments)
        #bind model to view
        bind_view: (model, $element, override) ->
            $element = this.element if not $element?
            $inputs = _.groupBy($element.find(':input'), 'name')
            for name, $grouped_inputs of $inputs
                $grouped_inputs = $($grouped_inputs) #change it from regular array to jquery
                event = this.constructor.BIND_EVENTS[this.get_input_type_of($grouped_inputs)]
                event = this.constructor.BIND_EVENTS.text if not event?
                path = name.replace(/-/g, '.')
                this.set_input_value($grouped_inputs, model.value(path))

                events = if _.isArray(event) then event else [event]

                for event in events
                    $grouped_inputs.on(event, do ($grouped_inputs, path)=>
                        ()=>
                            new_val = this.get_input_value($grouped_inputs)
                            #console.log 'arguments', path, new_val
                            #return if _.isEqual(model.attr(path), new_val)
                            model.attr(path, new_val)
                    )

                model.bind(path, do ($grouped_inputs, path)=>
                    () =>
                        #console.trace('path', path,  model.attr(path), $grouped_inputs)
                        this.set_input_value($grouped_inputs, model.attr(path))
                )
        destroy:()->
            if this.bound_models?
                #remove bound models
                for key, cbs of this.bound_models
                    model = this.bound_models[key]
                    model.unbind(event, cb) for event, cb of cbs

            can.Control.prototype.destroy.call(this)
    )

)