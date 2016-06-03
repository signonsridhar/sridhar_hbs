define([
    'bases/page'
    'css! pages/error/index/error_index'
],
(BasePage)->

    BasePage.extend({
        messages:{
            reset_password_link_sent: "A link to reset your password has been sent to your email account.
                                        <a class='link_to_security_questions'>I didn\’t get the reset password email.</a>",
            activation_link_sent: "A new activation link has been sent to your email account.",
            reset_password_success: "Your password has been reset. We sent you a notification email. You will now be directed to
                                    <a class='link_to_login'>the login page.</a>",
            account_locked: "We have problems logging you in. Please contact customer support center at 1 (800) 286-0203 or at support@t-mobileatwork.com."

            invalid_user: "     Your account does not exist. Please contact customer support center at 1 (800) 286-0203 or at support@t-mobileatwork.com."
            access_denied: "    Your account is restricted. Please contact customer support center at 1 (800) 286-0203 or at support@t-mobileatwork.com."
            terminated: "    Your account is restricted. Please contact customer support center at 1 (800) 286-0203 or at support@t-mobileatwork.com."
            unknown_error: "  Unknown service error"
            1177:   "We have problems log you in. Please contact customer support center at 1 (800) 286-0203 or at support@t-mobileatwork.com."
        },
        init:(elem, options)->
            this.setup_viewmodel({
                msg: ''
                title: ''
            })
            this.render('error/index/error_index')


        '.link_to_security_questions click':()->
            window.location = can.route.url({ main:'security_questions', email: can.route.attr('email')})

        '.link_to_login click':()->
            window.location = can.route.url({ main:'auth',sub: 'login'})

        switch_sub: (sub)->
            this.viewmodel.attr('msg', this.messages[sub])
            if !isNaN(parseInt(sub))
                sub = 'Error'

            this.viewmodel.attr('title', sub)
    })
)