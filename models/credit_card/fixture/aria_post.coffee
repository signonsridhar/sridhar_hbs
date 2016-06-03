define(['can_fixture'], (can)->
    #can.fixture('POST /aria/direct_post.php?partner_code=tmus', '/bss/dphandler/addcreditcardhandler?partner_code=tmus')
    setTimeout(()=>
        console.log('rerendering')
        $iframe = $('iframe')
        $form = $iframe.contents().find('form')
        console.log('form action', $form.attr('action'))
        $form.submit(()->
            $iframe[0].src = 'models/credit_card/fixture/addcreditcardhandler.html'
            return false
        )


    , 3000)
)