define(['bases/control',
        '_',
        '../../config_edit_item/line/config_edit_item_line',
        'bases/model/list',
        'models/user/user',
        'css!modules/config_edit_item_list/config_edit_item_list'
], (BaseControl,_, ConfigEditItemLine, BaseModelList, User)->
    BaseControl.extend({
        init:(elem, options)->
            this.setup_viewmodel({
            })


    })
)