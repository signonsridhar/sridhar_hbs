define(['bases/control', 'models/auth/auth'], (BaseControl, Auth)->
    BaseControl.extend({
        init:(elem, options)->
            this.setup_viewmodel({
                questions: [],
                count: 3,
                selected: []
            })
            auth = new Auth()
            this.set_validity(false)
            this.generated_questions = {}
            auth.get_security_questions().then((questions)=>
                copied_questions = []
                this.master_list = questions
                for i in [0..this.viewmodel.attr('count') - 1]
                    copied_questions.push(_.clone(questions))

                this.viewmodel.attr('questions', copied_questions)
                #console.log('viewmodel', questions, this.viewmodel.attr('questions.1'))
            )
            this.render('security_questions_form/setup_security_questions_form')

        '.answer change': ($elem)->
            this.viewmodel.attr($elem.attr('name'), $elem.val())

        #unable to make use of the model validation schema because the model structure changes
        validate_inputs:()->

            inputs = this.find(':input')
            has_invalid = false
            for input in inputs
                $input = $(input)
                if not $input.val()
                    if $input.is('select')
                        msg = 'Select a question'
                    else
                        msg = 'Type the answer'
                    VALID.show_tooltip($input, msg)
                    this.set_validity(false)
                    has_invalid = true
                else
                    VALID.show_tooltip($input, false)

            this.set_validity(true) if not has_invalid


        'input keyup':()->
            this.validate_inputs()


        'select change':(elem)->
            idx = parseInt(elem.attr('name').split('_').pop())
            value = parseInt(elem.val())
            viewmodel = this.viewmodel
            selecteds = viewmodel.attr('selected')
            selecteds.attr(idx, value)
            new_questions = []

            for i in [0..viewmodel.attr('count') - 1]
                new_list = _.clone(this.master_list)
                delete new_list[selected] for selected in selecteds
                selected_id = selecteds[i]
                if selected_id
                    new_list[selected_id] = this.master_list[selected_id]

                new_questions[i] = new_list
            this.viewmodel.attr('questions', new_questions)
            this.validate_inputs()

        get_questions:()->
            result = {}
            for selected, i in this.viewmodel.attr('selected')
                result[selected] = this.viewmodel.attr('answer_' + i)
            return window.auth.transform_security_questions_to(result)
    })
)