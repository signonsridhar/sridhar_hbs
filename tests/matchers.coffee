define([], ()->

    beforeEach ()->
        this.addMatchers({

            #check whether the given element has the can.control
            hasControl:($expected)->
                data = this.actual.data()
                return false unless data?
                for control in data.controls
                    return true if control == $expected
                return false

            toContain:(expected)->
                this.actual.indexOf(expected) >= 0
        })
)