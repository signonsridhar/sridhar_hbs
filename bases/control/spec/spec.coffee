define(['bases/control',
        'bases/model',
        '_',
        'tests/mocks'], (BaseControl, BaseModel, _ )->

    describe "control's normal operation", ()->
        inputs = {
            text:
                name: 'name'
                val: _.uniqueId('text_')
            textarea:
                name: 'comment'
                val: _.uniqueId('comment_')
            checkbox:
                name: 'colors'
                val: _.sample(['red', 'green', 'blue'],_.random(1, 3)).sort()
            radio:
                name: 'gender'
                val: _.sample(['m', 'f'])
            select:
                name: 'dessert'
                val: _.sample(['cake', 'ice_cream', 'cookie'])
            email:
                name: 'personal'
                val: 'shamalamadingdong@gmail.com'
        }

        state_options =
            state:
                id: 'state_id'
                starting:
                    open:'one'

        it 'should initiate correctly', ()->
            $binding_form = load_fixture('bases/control/spec/fixture-binding', 'binding_form')
            expect($binding_form.data().controls).toBeUndefined()
            $control = new BaseControl($binding_form)

            #is initiated
            expect($binding_form.data().controls).toBeDefined()

            expect($binding_form).hasControl($control)

        it 'should correctly set component', ()->
            $fixture = setFixtures('<div id="outside"><div id="inside"></div></div>')
            $outside = $fixture.find('#outside')
            $inside = $fixture.find('#inside')

            $outside_control = new BaseControl($outside)
            $inside_control = $outside_control.set_component('#inside', BaseControl)

            #correctly set component
            expect($outside).hasControl($outside_control)
            expect($inside).hasControl($inside_control)
            expect($inside_control.options.state).toEqual({})

            $inside_control = $outside_control.set_component('#inside', BaseControl, state_options)

            #update the component's options but it is the same instance
            expect($inside).hasControl($inside_control)
            expect($inside_control.options.state.id).toBeDefined(state_options.state.id)

        it 'should render correctly', ()->
            #in here we are testing our own mo cks actually
            #but in validating our mock works then the test would run
            #correctly, so meta
            $sandbox = get_sandbox()
            $control = new BaseControl($sandbox)
            $control.render('/bases/control/spec/fixture-binding')
            expect($control.element.html().length).toBeGreaterThan(0)

        it 'get/set input value and type it should get correctly', ()->
            $binding_form = load_fixture('bases/control/spec/fixture-binding', 'binding_form')
            $control = new BaseControl($binding_form)

            input_checker = ($input, input)->
                expect($control.get_input_value($input)).toBeNull()
                $control.set_input_value($input, input.val)
                expect($control.get_input_value($input)).toEqual(input.val)

            for type, input of inputs
                selector = ":input[name=#{input.name}]"
                input_checker($binding_form.find(selector), input)
                $binding_form[0].reset()
                input_checker(selector, input)
                expect($control.get_input_type_of(selector)).toEqual(type)

        it 'should bind to model correctly', ()->
            $binding_form = load_fixture('bases/control/spec/fixture-binding', 'binding_form')
            extracted = {}
            extracted[input.name] = input.val for type, input of inputs

            $model = new BaseModel(extracted)
            $control = new BaseControl($binding_form)
            $control.bind_view($model)

            for type, input of inputs
                selector = ":input[name=#{input.name}]"
                expect($control.get_input_value(selector)).toEqual(input.val)


)