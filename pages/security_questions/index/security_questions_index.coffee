define([
    'bases/page',
    'modules/security_questions_form/challenge_security_questions_form',
    'css!modules/security_questions_form/challenge_security_questions_form'
],
(BasePage, ChallengeSecurityQuestionsForm)->

    BasePage.extend({
        init:(elem, options)->
            this.render('security_questions/index/security_questions_index')
            this.options.email = can.route.attr('email')
            this.security_form = new ChallengeSecurityQuestionsForm(this.find('.security_questions_form'), {email: this.options.email})
        submit: ()->
            answers = this.security_form.get_answers()
            window.auth.validate_security_questions(this.options.email, answers).then((response)=>
                window.location = can.route.url({
                                                    main:'auth',
                                                    sub:'change_password',
                                                    email:this.options.email,
                                                    access_key: response.data.authToken,
                                                    partner:'tmus'
                                                })

                #this is call back after it's successful
            ).fail((e)->
                window.location = can.route.url({main:'error', sub:e.code}) if e.code == 1177
            )
            return false
    })
)
