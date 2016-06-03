define(['bases/control'],
    (BaseControl )->
        BaseControl.extend({
            init: (elem, options)->
                console.log('options!!!', options.email)
                this.setup_viewmodel({
                    questions:{}
                })

                window.auth.get_security_questions(options.email).then((questions)=>
                    validations = {}

                    this.viewmodel.setup_validations(validations)
                    this.viewmodel.attr('questions', questions)
                    this.bind_view(this.viewmodel)
                )
                this.render('security_questions_form/challenge_security_questions_form')

            get_answers: (e)->
                result = {}
                this.viewmodel.attr('questions').each((question, id)=>
                    result[id] = this.viewmodel.attr('answer_' + id)
                )
                return result
        })
)