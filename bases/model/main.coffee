define(['can', '_', 'etc/valid', 'libs/validator'], (can, _, VALID, validator)->
    $.ajaxSetup(
        contentType : 'application/json; charset=utf-8',
        timeout: 120000

    )
    orig_ajax = $.ajax
    $.ajaxSetup({
        beforeSend:(request)->
            auth = window.auth
            return if not auth?
            request.setRequestHeader("X-AUTHORIZATION", auth.get_access_key())
    })

    parse_response_to_massaged_data = (data)->
        if(data && data.response)
            response_code = data.response.response_code
            response_data = data.response.response_data
            error_message = data.response.error_message
            return {data: response_data, code: response_code, msg: error_message}
        else
            return {}

    $.ajax = ()->

        url = null
        result = null

        if _.isString(arguments[0])
            url = arguments[0]
        else
            url = arguments[0].url

        if url.indexOf('/bss/') >= 0
            #do the wrapper
            console.log('AJAX:', url)
            my_promise = $.Deferred()
            orig_ajax.apply(null, arguments).done((data)->
                massaged = parse_response_to_massaged_data(data)
                switch massaged.code
                    when 100
                        my_promise.resolve(massaged)
                    when 1009 #access key expired
                        window.auth.logged_out()
                    else
                        my_promise.reject(massaged)
            ).fail((data)->
                my_promise.reject(parse_response_to_massaged_data(data))
            )
            result = my_promise
        else
            result = orig_ajax.apply(null, arguments)
        return result

    can.Model.extend({
        #wrapper so that we dont have to do try catch on all
        #of our validations
    },
    {
        get_id:()-> this.attr(this.constructor.id)

        validator:(key, cb)->
            try
                cb()
            catch e
                this.validity(key, e.message)
            return null
        ###
            what to validate for this model to reach that VALID.YES state
        ###
        set_validated_attrs:(attrs)->
            this.attr('__valid.__attr', attrs)
        get_validated_attrs: ()->
            this.value('__valid.__attr')
        ###
            setup all that's needed to run validation
        ###
        setup_validations:(validations=null)->
            this.validations = validations if not this.validations
            return if not this.validations

            this.valid = can.compute(false)
            this.attr('__valid', {})

            this.delegate('__valid.**', 'change', (e, attr, action, param_validated_attrs, old_val)=>
                return if attr == '__attr'
                real_attr = attr.split('.').pop()
                validated_attrs = this.get_validated_attrs()
                validated_attrs = _.keys(this.get_validity_object()) if not validated_attrs?
                delete validated_attrs['__attr']

                can.trigger(this, 'validity', [real_attr, validated_attrs, old_val])

                for attr in validated_attrs
                    validity = this.validity(attr)

                    #it has not been validated but it has a value already
                    if validity == undefined and !_.isEmpty(this.attr(attr))
                        this.validate(attr)

                    if validity != VALID.YES
                        console.log('ATTR', attr, validity, VALID)
                        this.valid(false)
                        return
                console.log(param_validated_attrs, 'hre yeah???')
                this.valid(true)

            )

            this.bind('change', (e, attr, action, new_val, old_val)=>
                return if attr.indexOf('__valid') >= 0
                this.validate(attr)
            )

            this.validations = this.validations.serialize() if _.isFunction(this.validations.serialize) #make it just as an object
            this.get_wrapped_validation_function = _.memoize(this.get_wrapped_validation_function)
        ###
            a wrapper to check, so that we don't need to inject validator on every model
        ###

        check:()->
            validator.check.apply(null, arguments)

        ###
            set the validity of the attr
        ###
        validity:(attr, validity_type = undefined )->
            if validity_type == undefined
                this.attr("__valid.#{attr}")
            else
                this.attr("__valid.#{attr}", validity_type)



        ###
            get the validity object, to mask the __valid
        ###
        get_validity_object:()->
            validity = this.value('__valid')


        ###
            validate the object
        ###
        validate:(keys = '*')->

            return if not _.isObject(this.validations)

            keys = _.keys(this.validations) if keys == '*'
            keys = [keys] if not _.isArray(keys)
            can.batch.start()

            for key in keys
                validation = this.get_wrapped_validation_function(key)
                continue if not validation?

                validation()

            can.batch.stop()

        get_wrapped_validation_function:(attr)->
            func = this.get_validation_function(attr)
            return if not func?
            ()=>
                this.validity(attr, VALID.MAYBE)
                this.validator(attr, _.bind(func, this))

        get_validation_function:(attr)-> this.validations[attr]

        value: (path)->
            value = this.attr(path)
            value = value.serialize() if value instanceof can.Map
            value

        attr_promise:(key, promise)->
            promise.done((data)=>
                this.attr(key, data)
            )
        serialize:()->
            result = this._super()
            delete result.validations
            result

        #set the whole promise in as the data
        set_promise:(promise)->
            promise.done((data)=>
                can.batch.start()
                data = data.serialize() if data instanceof can.Map
                this.attr(data, true)
                can.batch.stop()
            )
    })
)