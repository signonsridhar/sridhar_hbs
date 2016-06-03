define(['bases/model',
        'models/user/user',
        'models/phone_number/phone_number',
        'env!dev:models/auth/fixture/authenticate',
        'env!dev:models/auth/fixture/validateaccesskey',
        'env!dev:models/auth/fixture/validateemailaccesskey',
        'env!dev:models/auth/fixture/keepalive',
        'env!dev:models/auth/fixture/forgot_password',
        'env!dev:models/auth/fixture/resend_activation',
        'env!dev:models/auth/fixture/get_security_questions',
        'env!dev:models/auth/fixture/validate_security_questions',
        'env!dev:models/phone_number/fixture/get_conference_numbers'
], (BaseModel, User, PhoneNumber)->

    Auth = BaseModel.extend({
        pages:[
            {main:'config'},
            {main:'account'},
            {main:'group_settings'},
            {main:'wizard'},
            {main:'settings'}
        ],

        check_page_needs_auth: (param_page)->
            for page in this.pages
                return true if page.main == param_page.main
            return false

        auth:null,

        get_auth:()->
            this.auth = new Auth() if not this.auth?
            this.auth



        check:(page = null)->

            result = $.Deferred()
            #return result.resolve()

            #we don't need to check the auth of this page
            if not this.check_page_needs_auth(page)
                return result.resolve()

            auth = this.get_auth()
            auth.collect_access_info_from_route()

            #1. grab access key
            access_key = auth.get_access_key()
            #alert(access_key)
            user_id = auth.get_user_id()

            if access_key? #2.1 if we have accessKey, check whether it's still valid

                auth.validate_access_key().then((expiry_status)->
                    result.reject() if not expiry_status
                ).then(()->
                    User.get_authenticated_user(auth).then((authenticated_user)->
                        auth.attr('auth_user', authenticated_user)
                        authenticated_user
                    )
                ).then((auth_user)->
                    auth.attr('logged_in', true)
                    auth.extend_access_key()
                    auth.attr('tenant_id', auth_user.attr('tenant_id'))
                    auth.attr('account_id', auth_user.attr('account_id'))
                    auth.attr('tenant_name', auth_user.attr('tenant_name'))
                    result.resolve(auth_user)
                ).then((auth_user)->
                    PhoneNumber.get_conference_numbers({partnerid: auth_user.attr('partner_id')}).then((conf_numbers)->
                        auth.attr('conference_numbers', conf_numbers )
                    )
                )
            else #2.2 if we don't then..okay.
                result.reject()
            #result.resolve()
            result
        forgot_password:(email)->
            $.post('/bss/authentication?action=forgotpassword',
                JSON.stringify({"identification": email, "partner_code": "tmus"})
            )
        validate_email_access_key:(access_key)->

            $.get("/bss/authentication?action=validateemailaccesskey&accesskeyid=#{access_key}").then( (response)->
                return response.data
            )
    }, {
        init:()->

        collect_access_info_from_route:()->

            check_access_info_attrs = ['accesskey', 'userid', 'expires']
            result = {}
            can.batch.start()
            for access_attr in check_access_info_attrs
                result[access_attr] = can.route.attr(access_attr) #check url
                can.route.attr(access_attr, null) if result[access_attr]? #if it exists, remove it from url

            this.set_access_info(result) if _.chain(result).values().compact().value().length

            can.batch.stop()
            result

        login_attempt:(email, password, recaptcha_response_field, recaptcha_challenge_field)->

            result = $.Deferred()
            data = {}
            data.identification = email
            data.credential = password
            data.recaptcha_response_field = recaptcha_response_field
            data.recaptcha_challenge_field = recaptcha_challenge_field
            data.partner_code = 'tmus'

            $.post("/bss/authentication?action=authenticate",
                JSON.stringify(data)
            ).done((response)->
                data = response.data
                if response.code == 100
                    result.resolve(data)
                else
                    result.reject()
            ).fail((response)->
                result.reject(response)
            )

            result

        logout:()->
            $.get("/bss/authentication?action=signout&accesskeyid=#{this.get_access_key()}", ()=>
                this.logged_out()
            )

        ###
        logged in, record the access info and do the redirect to the last visited page.
        ###
        logged_in: (access_info, redirect = true)->

            this.set_access_info(access_info)
            history = localStorage.getItem('history')
            localStorage.removeItem('history')
            this.attr('logged_in', true)
            if redirect and not history? or window.location.hash != can.route.url({main:'auth', sub:'login'})
                window.location = can.route.url({main:'config'})
            else if redirect and history
                window.location = history


        ###
        log user out, remove the access info, record the last visited place
        ###
        logged_out:()->
            localStorage.setItem('history', window.location)
            this.set_access_info(null)
            return if window.location.hash == can.route.url({main:'auth', sub:'login'})
            window.location = can.route.url({main:'auth', sub:'login'})
            window.location.reload()

        ###
        record the access info, parses, normalizes the attributes(userid->user_id) and caches it.
        This function is the backbone to getting attributes such as access_key, expires
        ###
        set_access_info:(access_info)->
            if access_info == null
                this.access_info_cache = result

            else
                normalize_keys = [
                    ['userid', 'user_id'],
                    ['accesskey', 'access_key'],
                    ['expires', 'expires']
                ]
                result = {}
                for normalize_key in normalize_keys
                    backend_attr = normalize_key[0]
                    our_attr = normalize_key[1]
                    result[normalize_key[1]] = if access_info[backend_attr]? then access_info[backend_attr] else access_info[our_attr]

                this.access_info_cache = result
                result = JSON.stringify(result)

            localStorage.setItem('access_info', result)

        ###
            get and cache the access info
        ###
        get_access_info:()->
            if not this.access_info_cache?
                raw_access_info = localStorage.getItem('access_info')
                this.access_info_cache = if raw_access_info != 'undefined' then JSON.parse(raw_access_info) else {}
                this.access_info_cache = {} if not this.access_info_cache?
            this.access_info_cache

        get_access_key:()->
            this.get_access_info().access_key

        get_expiry:()->
            return Date.parse(this.get_access_info().expires)

        set_expiry:(new_expiry)->
            access_info = this.get_access_info()
            access_info.expires = new_expiry.toUTCString()
            this.set_access_info(access_info)

        get_user:()->
            this.attr('auth_user')
        get_user_id:()->
            this.get_access_info().user_id

        ###
        extends the access_key validity, promises a date object which is the new expiry
        ###
        extend_access_key:()->
            access_key = this.get_access_key()
            $.get("/bss/authentication?action=keepalive&accesskeyid=#{access_key}").then((response)=>
                new Date(Date.parse(response.data))
            ).done( (new_expiry_date)=>
                this.set_expiry(new_expiry_date)
            )

        ###
        validates whether the access key is still valid or not
        ###
        validate_access_key:()->

            access_key = this.get_access_key()
            $.get("/bss/authentication?action=validateaccesskey&accesskeyid=#{access_key}").then( (response)->

                return response.data
            )
        transform_security_questions_from:(raw_questions)->
            result = {}
            result[raw_question.securityQuestionId] = raw_question.securityQuestion for raw_question in raw_questions
            return result

        transform_security_questions_to:(questions, value_type = 'securityAnswer')->
            result = []
            for id, value of questions
                q = {}
                q.securityQuestionId = id
                q[value_type] = value
                result.push(q)
            return result

        get_security_questions:(email)->

            if email
                url = "/bss/user?action=getusersecurityquestion&identification=#{email}"
            else
                url = "/bss/system?action=getsecurityquestions"

            $.get(url).then( (response)=>
                return this.transform_security_questions_from(response.data.securityQuestions)
            )

        validate_security_questions: (email, questions)->
            data = {
                security_questions: this.transform_security_questions_to(questions),
                identification: email
            }

            $.post('/bss/user?action=validateusersecurityquestion', JSON.stringify(data))
    })

    window.auth = Auth.get_auth()
    return Auth
)