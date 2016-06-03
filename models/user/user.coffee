define(['bases/model',
        '_',
        'models/auth/auth',
        'models/bundle/bundle',
        'env!dev:models/user/fixture/email_uniqueness',
        'env!dev:models/user/fixture/get_user',
        'env!dev:models/user/fixture/delete_user',
        'env!dev:models/user/fixture/remove_bundle_for_user',
        'env!dev:models/user/fixture/add_bundle_for_user',
        'env!dev:models/user/fixture/set_name'
        'env!dev:models/user/fixture/change_user_email'
        'env!dev:models/user/fixture/confirm_reset_credential'
],
(BaseModel, _, Auth, Bundle)->

    password_format_check = (password)->
        special_chars = "! @ # $ % ^ & * ( ) - _ = + , < . > [ { ] }  | ~".split(' ')
        has_number = false
        has_alpha = false
        has_invalid_char = false
        len = password.length
        if len < 8 or len > 16
            return false

        for i in [0..len]
            #this.check(password, VALID.ERROR.FORMAT).regex(/^(?=.*[_$@.])(?=.*[^_$@.])[\w$@.]{8,15}$/)
            raw_val = password[i]
            int_val = parseInt(raw_val)
            #console.log('int_val', int_val)
            if !_.isNaN(int_val) and int_val >= 0 and int_val <= 9
                has_number = true
            if /^[a-zA-Z()]$/.test(raw_val)
                has_alpha = true
            #console.log('invalid_char', /^[a-z0-9]+$/i.test(raw_val), special_chars.indexOf(raw_val))
            if !(/^[a-z0-9]+$/i.test(raw_val)) and special_chars.indexOf(raw_val) < 0
                has_invalid_char = true


        if !(has_alpha and has_number) or has_invalid_char

            return false
        else
            return true

    User = BaseModel.extend({
        id:'userid'
        TYPE:'USER',
        get_authenticated_user:(auth = null)->

            auth = Auth.get_auth() if not auth?
            access_key = auth.get_access_key()
            user_id = auth.get_user_id()

            $.get("/bss/user?action=getuser&accesskeyid=#{access_key}&userid=#{user_id}").then((response)->
                data = response.data
                code = response.code
                return new User(data)
            )

    },{
        init:()->
            this.setup_validations()
            this.debounced_validate_email_unique = _.debounce(()=>
                this.is_email_unique().then((status)=>
                    this.validity('email', status)
                )
            , 300)


        is_email_unique:()->
            user_id = auth.get_user_id() if auth?
            $.get('/bss/authentication?action=checkcredentialavailability',
                {identification: this.attr('email'), user_id: user_id})
                .then((response)=>
                    if response.data == "true" then VALID.YES else VALID.ERROR.UNIQUE
                ).fail((response)=>
                    this.validity('email', VALID.ERROR.INVALID)
                )

        validations:{
            first_name:()->
                first_name = this.attr('first_name')
                this.check(first_name, VALID.ERROR.REQUIRED).notEmpty()
                this.check(first_name, VALID.ERROR.SIZE).len(2, 40)
                this.check(first_name, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.,&()!?-@\' ]*$')
                this.validity('first_name', VALID.YES)

            last_name:()->
                last_name = this.attr('last_name')
                this.check(last_name, VALID.ERROR.REQUIRED).notEmpty()
                this.check(last_name, VALID.ERROR.SIZE).len(2, 40)
                this.check(last_name, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.,&()!?-@\' ]*$')
                this.validity('last_name', VALID.YES)

            phone:()->
                phone = this.attr('phone')
                this.check(phone, VALID.ERROR.REQUIRED).notEmpty()
                ###
                this.check(phone, VALID.ERROR.FORMAT).isNumeric().len(10)
                ###
                this.validity('phone', VALID.YES)
            email:()->
                email = this.attr('email')
                this.check(email, VALID.ERROR.REQUIRED).notEmpty()
                this.check(email, VALID.ERROR.SIZE).len(3, 70)
                this.check(email, VALID.ERROR.FORMAT).regex("^\\s*[_+A-Za-z0-9-]+(\\.[_+A-Za-z0-9-]+)*@[A-Za-z0-9.-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})\\s*$")
                this.debounced_validate_email_unique()

            valid_email_format:()->
                email = this.attr('valid_email_format')
                this.check(email, VALID.ERROR.REQUIRED).notEmpty()
                this.check(email, VALID.ERROR.SIZE).len(3, 70)
                this.check(email, VALID.ERROR.FORMAT).regex("^\\s*[_+A-Za-z0-9-]+(\\.[_+A-Za-z0-9-]+)*@[A-Za-z0-9.-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})\\s*$")
                this.validity('valid_email_format', VALID.YES)

            confirm_email:()->
                confirm_email = this.attr('confirm_email')
                this.check(confirm_email, VALID.ERROR.REQUIRED).notEmpty()
                this.check(confirm_email, VALID.ERROR.SIZE).len(3, 70)
                this.check(email, VALID.ERROR.FORMAT).regex("^\\s*[_+A-Za-z0-9-]+(\\.[_+A-Za-z0-9-]+)*@[A-Za-z0-9.-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})\\s*$")
                if this.attr('email') == this.attr('confirm_email')
                    this.validity('confirm_email', VALID.YES)
                else
                    this.validity('confirm_email', VALID.ERROR.EQUAL)

            password:()->
                password = this.attr('password')
                this.check(password, VALID.ERROR.REQUIRED).notEmpty()
                if not password_format_check(password)
                    this.validity('password', VALID.ERROR.FORMAT)
                    return
                    
                this.validity('password', VALID.YES)

            confirm_password:()->
                password = this.attr('confirm_password')
                this.check(password, VALID.ERROR.REQUIRED).notEmpty()
                if not password_format_check(password)
                    console.log(' IS IT HERE????', password)
                    this.validity('confirm_password', VALID.ERROR.FORMAT)
                    return
                result = if this.attr('password') == this.attr('confirm_password') then VALID.YES else VALID.ERROR.EQUAL

                this.validity('confirm_password', result)

        }
        get_bundles:()->
            $.get('/bss/user?action=getuser', {userid: this.attr('userid') }).then (response)->
                bundles = response.data.bundles
                BaseModel.models.call(Bundle, bundles)

        get_name:()-> this.full_name()
        full_name:can.compute(()->
            return this.attr("first_name") + ' ' + this.attr('last_name')
        )

        delete_item:()->
            $.get('/bss/user?action=deleteuser', {userid: this.attr('userid') })

        remove_bundle_for_user:(bundleid)->
            $.get('/bss/user?action=removebundleforuser', {userid: this.attr('userid'), bundleid: bundleid } )


        add_bundle_for_user:(bundle_ids)->
            addUserWithBundleReq ={}
            addUserWithBundleReq.user_id = this.attr('userid')
            addUserWithBundleReq.bundle_ids = bundle_ids

            $.post('/bss/user?action=addbundleforuser', JSON.stringify(addUserWithBundleReq) )

        set_name:()->
            $.get('/bss/user?action=setname', {userid: this.attr('userid'), firstname: this.attr('first_name'), lastname: this.attr('last_name') } )

        set_email:()->
            $.get('/bss/authentication?action=changeuseremail', {userid: this.attr('userid'), email: this.attr('email')} )

        set_password: (access_key)->
            req = {
                temporary_token : access_key,
                new_credential:this.attr('password'),
                partner_code: 'tmus'
            }
            $.post('/bss/authentication?action=confirmresetcredential', JSON.stringify(req))


        ###
            userid:
            identification:
            old_credential:
            new_credential:
        ###
        update_password:(form_data)->
            #/bss/authentication?action=setcredential&accesskeyid=&userid=&identification=&old_credential=&new_credential=
            req = {
                    identification: this.attr('user.email'),
                    old_credential: form_data.old_credential,
                    new_credential: form_data.new_credential,
                    partner_code: 'tmus'
            }
            $.post('/bss/authentication?action=setcredential', JSON.stringify(req))

        get_all_extensions_chained:()->
            _.chain(this.bundles).pluck('extensions').compact().pluck(0).flatten().compact()

        get_first_extension_number:()->
            this.get_all_extensions_chained().first().pick('extension_number').value().extension_number

        save_security: (access_key)->
            req = {
                temporary_token : access_key,
                new_credential:this.attr('password'),
                partner_code: 'tmus',
                security_questions: this.value('security_questions')
            }
            $.post('/bss/authentication?action=savesecuritysetup', JSON.stringify(req))

    })
)