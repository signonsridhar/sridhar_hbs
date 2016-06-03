/*!
 * CanJS - 2.0.3
 * http://canjs.us/
 * Copyright (c) 2013 Bitovi
 * Wed, 27 Nov 2013 00:20:31 GMT
 * Licensed MIT
 * Includes: can/util/object/object.js,can/util/fixture/fixture.js
 * Download from: http://bitbuilder.herokuapp.com/can.custom.js?configuration=jquery&plugins=can%2Futil%2Fobject%2Fobject.js&plugins=can%2Futil%2Ffixture%2Ffixture.js
 */
(function(undefined) {

    // ## can/util/can.js
    var __m4 = (function() {
        var can = window.can || {};
        if (typeof GLOBALCAN === 'undefined' || GLOBALCAN !== false) {
            window.can = can;
        }

        can.isDeferred = function(obj) {
            var isFunction = this.isFunction;
            // Returns `true` if something looks like a deferred.
            return obj && isFunction(obj.then) && isFunction(obj.pipe);
        };

        var cid = 0;
        can.cid = function(object, name) {
            if (object._cid) {
                return object._cid
            } else {
                return object._cid = (name || "") + (++cid)
            }
        }
        can.VERSION = '@EDGE';

        can.simpleExtend = function(d, s) {
            for (var prop in s) {
                d[prop] = s[prop]
            }
            return d;
        }

        return can;
    })();

    // ## can/util/array/each.js
    var __m5 = (function(can) {
        can.each = function(elements, callback, context) {
            var i = 0,
                key;
            if (elements) {
                if (typeof elements.length === 'number' && elements.pop) {
                    if (elements.attr) {
                        elements.attr('length');
                    }
                    for (key = elements.length; i < key; i++) {
                        if (callback.call(context || elements[i], elements[i], i, elements) === false) {
                            break;
                        }
                    }
                } else if (elements.hasOwnProperty) {
                    for (key in elements) {
                        if (elements.hasOwnProperty(key)) {
                            if (callback.call(context || elements[key], elements[key], key, elements) === false) {
                                break;
                            }
                        }
                    }
                }
            }
            return elements;
        };

        return can;
    })(__m4);

    // ## can/util/inserted/inserted.js
    var __m6 = (function(can) {
        // Given a list of elements, check if they are in the dom, if they
        // are in the dom, trigger inserted on them.
        can.inserted = function(elems) {
            var inDocument = false,
                checked = false,
                children;
            for (var i = 0, elem;
                 (elem = elems[i]) !== undefined; i++) {
                if (!inDocument) {
                    if (elem.getElementsByTagName) {
                        if (can.has(can.$(document), elem).length) {
                            inDocument = true;
                        } else {
                            return;
                        }
                    } else {
                        continue;
                    }
                }

                if (inDocument && elem.getElementsByTagName) {
                    can.trigger(elem, "inserted", [], false);
                    children = can.makeArray(elem.getElementsByTagName("*"));
                    for (var j = 0, child;
                         (child = children[j]) !== undefined; j++) {
                        // Trigger the destroyed event
                        can.trigger(child, "inserted", [], false);
                    }
                }
            }
        }


        can.appendChild = function(el, child) {
            if (child.nodeType === 11) {
                var children = can.makeArray(child.childNodes);
            } else {
                var children = [child]
            }
            el.appendChild(child);
            can.inserted(children)
        }
        can.insertBefore = function(el, child, ref) {
            if (child.nodeType === 11) {
                var children = can.makeArray(child.childNodes);
            } else {
                var children = [child];
            }
            el.insertBefore(child, ref);
            can.inserted(children)
        }

    })(__m4);

    // ## can/util/event.js
    var __m7 = (function(can) {

        // event.js
        // ---------
        // _Basic event wrapper._
        can.addEvent = function(event, fn) {
            var allEvents = this.__bindEvents || (this.__bindEvents = {}),
                eventList = allEvents[event] || (allEvents[event] = []);

            eventList.push({
                handler: fn,
                name: event
            });
            return this;
        };

        // can.listenTo works without knowing how bind works
        // the API was heavily influenced by BackboneJS:
        // http://backbonejs.org/
        can.listenTo = function(other, event, handler) {


            var idedEvents = this.__listenToEvents;
            if (!idedEvents) {
                idedEvents = this.__listenToEvents = {};
            }
            var otherId = can.cid(other);
            var othersEvents = idedEvents[otherId];
            if (!othersEvents) {
                othersEvents = idedEvents[otherId] = {
                    obj: other,
                    events: {}
                };
            }
            var eventsEvents = othersEvents.events[event]
            if (!eventsEvents) {
                eventsEvents = othersEvents.events[event] = []
            }
            eventsEvents.push(handler);
            can.bind.call(other, event, handler);
        }

        can.stopListening = function(other, event, handler) {
            var idedEvents = this.__listenToEvents,
                iterIdedEvents = idedEvents,
                i = 0;
            if (!idedEvents) {
                return this;
            }
            if (other) {
                var othercid = can.cid(other);
                (iterIdedEvents = {})[othercid] = idedEvents[othercid];
                // you might be trying to listen to something that is not there
                if (!idedEvents[othercid]) {
                    return this;
                }
            }


            for (var cid in iterIdedEvents) {
                var othersEvents = iterIdedEvents[cid],
                    eventsEvents;
                other = idedEvents[cid].obj;
                if (!event) {
                    eventsEvents = othersEvents.events;
                } else {
                    (eventsEvents = {})[event] = othersEvents.events[event]
                }
                for (var eventName in eventsEvents) {
                    var handlers = eventsEvents[eventName] || [];
                    i = 0;
                    while (i < handlers.length) {
                        if ((handler && handler === handlers[i]) || (!handler)) {
                            can.unbind.call(other, eventName, handlers[i])
                            handlers.splice(i, 1);

                        } else {
                            i++;
                        }
                    }
                    // no more handlers?
                    if (!handlers.length) {
                        delete othersEvents.events[eventName]
                    }
                }
                if (can.isEmptyObject(othersEvents.events)) {
                    delete idedEvents[cid]
                }
            }
            return this;
        }

        can.removeEvent = function(event, fn) {
            if (!this.__bindEvents) {
                return this;
            }

            var events = this.__bindEvents[event] || [],
                i = 0,
                ev,
                isFunction = typeof fn == 'function';

            while (i < events.length) {
                ev = events[i]
                if ((isFunction && ev.handler === fn) || (!isFunction && ev.cid === fn)) {
                    events.splice(i, 1);
                } else {
                    i++;
                }
            }


            return this;
        };

        can.dispatch = function(event, args) {
            if (!this.__bindEvents) {
                return;
            }
            if (typeof event == "string") {
                event = {
                    type: event
                }
            }
            var eventName = event.type,
                handlers = (this.__bindEvents[eventName] || []).slice(0),
                args = [event].concat(args || []);

            for (var i = 0, len = handlers.length; i < len; i++) {
                ev = handlers[i];
                ev.handler.apply(this, args);
            };
        }

        return can;

    })(__m4);

    // ## can/util/jquery/jquery.js
    var __m2 = (function($, can) {
        var isBindableElement = function(node) {
            //console.log((node.nodeName && (node.nodeType == 1 || node.nodeType == 9) || node === window))
            return (node.nodeName && (node.nodeType == 1 || node.nodeType == 9) || node == window);
        };

        // _jQuery node list._
        $.extend(can, $, {
            trigger: function(obj, event, args) {
                if (obj.nodeName || obj === window) {
                    $.event.trigger(event, args, obj, true);
                } else if (obj.trigger) {
                    obj.trigger(event, args);
                } else {
                    if (typeof event === 'string') {
                        event = {
                            type: event
                        }
                    }
                    event.target = event.target || obj;
                    can.dispatch.call(obj, event, args);
                }
            },
            addEvent: can.addEvent,
            removeEvent: can.removeEvent,
            // jquery caches fragments, we always needs a new one
            buildFragment: function(elems, context) {
                var oldFragment = $.buildFragment,
                    ret;

                elems = [elems];
                // Set context per 1.8 logic
                context = context || document;
                context = !context.nodeType && context[0] || context;
                context = context.ownerDocument || context;

                ret = oldFragment.call(jQuery, elems, context);

                return ret.cacheable ? $.clone(ret.fragment) : ret.fragment || ret;
            },
            $: $,
            each: can.each,
            bind: function(ev, cb) {
                // If we can bind to it...
                if (this.bind && this.bind !== can.bind) {
                    this.bind(ev, cb)
                } else if (isBindableElement(this)) {
                    $.event.add(this, ev, cb);
                } else {
                    // Make it bind-able...
                    can.addEvent.call(this, ev, cb)
                }
                return this;
            },
            unbind: function(ev, cb) {
                // If we can bind to it...
                if (this.unbind && this.unbind !== can.unbind) {
                    this.unbind(ev, cb)
                } else if (isBindableElement(this)) {
                    $.event.remove(this, ev, cb);
                } else {
                    // Make it bind-able...
                    can.removeEvent.call(this, ev, cb)
                }
                return this;
            },
            delegate: function(selector, ev, cb) {
                if (this.delegate) {
                    this.delegate(selector, ev, cb)
                } else if (isBindableElement(this)) {
                    $(this).delegate(selector, ev, cb)
                } else {
                    // make it bind-able ...
                }
                return this;
            },
            undelegate: function(selector, ev, cb) {
                if (this.undelegate) {
                    this.undelegate(selector, ev, cb)
                } else if (isBindableElement(this)) {
                    $(this).undelegate(selector, ev, cb)
                } else {
                    // make it bind-able ...

                }
                return this;
            }
        });

        // Wrap binding functions.


        // Aliases
        can.on = can.bind;
        can.off = can.unbind;

        // Wrap modifier functions.
        $.each(["append", "filter", "addClass", "remove", "data", "get", "has"], function(i, name) {
            can[name] = function(wrapped) {
                return wrapped[name].apply(wrapped, can.makeArray(arguments).slice(1));
            };
        });

        // Memory safe destruction.
        var oldClean = $.cleanData;

        $.cleanData = function(elems) {
            $.each(elems, function(i, elem) {
                if (elem) {
                    can.trigger(elem, "removed", [], false);
                }
            });
            oldClean(elems);
        };

        var oldDomManip = $.fn.domManip,
            cbIndex;

        // feature detect which domManip we are using
        $.fn.domManip = function(args, cb1, cb2) {
            for (var i = 1; i < arguments.length; i++) {
                if (typeof arguments[i] === "function") {
                    cbIndex = i;
                    break;
                }
            }
            return oldDomManip.apply(this, arguments)
        }
        $(document.createElement("div")).append(document.createElement("div"))

        $.fn.domManip = (cbIndex == 2 ? function(args, table, callback) {
            return oldDomManip.call(this, args, table, function(elem) {
                if (elem.nodeType === 11) {
                    var elems = can.makeArray(elem.childNodes);
                }
                var ret = callback.apply(this, arguments);
                can.inserted(elems ? elems : [elem]);
                return ret;
            })
        } : function(args, callback) {
            return oldDomManip.call(this, args, function(elem) {
                if (elem.nodeType === 11) {
                    var elems = can.makeArray(elem.childNodes);
                }
                var ret = callback.apply(this, arguments);
                can.inserted(elems ? elems : [elem]);
                return ret;
            })
        })

        $.event.special.inserted = {};
        $.event.special.removed = {};

        return can;
    })(jQuery, __m4, __m5, __m6, __m7);

    // ## can/util/object/object.js
    var __m1 = (function(can) {

        var isArray = can.isArray,
        // essentially returns an object that has all the must have comparisons ...
        // must haves, do not return true when provided undefined
            cleanSet = function(obj, compares) {
                var copy = can.extend({}, obj);
                for (var prop in copy) {
                    var compare = compares[prop] === undefined ? compares["*"] : compares[prop];
                    if (same(copy[prop], undefined, compare)) {
                        delete copy[prop]
                    }
                }
                return copy;
            },
            propCount = function(obj) {
                var count = 0;
                for (var prop in obj) count++;
                return count;
            };

        can.Object = {};

        var same = can.Object.same = function(a, b, compares, aParent, bParent, deep) {
            var aType = typeof a,
                aArray = isArray(a),
                comparesType = typeof compares,
                compare;

            if (comparesType == 'string' || compares === null) {
                compares = compareMethods[compares];
                comparesType = 'function'
            }
            if (comparesType == 'function') {
                return compares(a, b, aParent, bParent)
            }
            compares = compares || {};

            if (a instanceof Date) {
                return a === b;
            }
            if (deep === -1) {
                return aType === 'object' || a === b;
            }
            if (aType !== typeof b || aArray !== isArray(b)) {
                return false;
            }
            if (a === b) {
                return true;
            }
            if (aArray) {
                if (a.length !== b.length) {
                    return false;
                }
                for (var i = 0; i < a.length; i++) {
                    compare = compares[i] === undefined ? compares["*"] : compares[i]
                    if (!same(a[i], b[i], a, b, compare)) {
                        return false;
                    }
                };
                return true;
            } else if (aType === "object" || aType === 'function') {
                var bCopy = can.extend({}, b);
                for (var prop in a) {
                    compare = compares[prop] === undefined ? compares["*"] : compares[prop];
                    if (!same(a[prop], b[prop], compare, a, b, deep === false ? -1 : undefined)) {
                        return false;
                    }
                    delete bCopy[prop];
                }
                // go through bCopy props ... if there is no compare .. return false
                for (prop in bCopy) {
                    if (compares[prop] === undefined || !same(undefined, b[prop], compares[prop], a, b, deep === false ? -1 : undefined)) {
                        return false;
                    }
                }
                return true;
            }
            return false;
        };

        can.Object.subsets = function(checkSet, sets, compares) {
            var len = sets.length,
                subsets = [],
                checkPropCount = propCount(checkSet),
                setLength;

            for (var i = 0; i < len; i++) {
                //check this subset
                var set = sets[i];
                if (can.Object.subset(checkSet, set, compares)) {
                    subsets.push(set)
                }
            }
            return subsets;
        };

        can.Object.subset = function(subset, set, compares) {
            // go through set {type: 'folder'} and make sure every property
            // is in subset {type: 'folder', parentId :5}
            // then make sure that set has fewer properties
            // make sure we are only checking 'important' properties
            // in subset (ones that have to have a value)

            var setPropCount = 0,
                compares = compares || {};

            for (var prop in set) {

                if (!same(subset[prop], set[prop], compares[prop], subset, set)) {
                    return false;
                }
            }
            return true;
        }

        var compareMethods = {
            "null": function() {
                return true;
            },
            i: function(a, b) {
                return ("" + a).toLowerCase() == ("" + b).toLowerCase()
            }
        }

        return can.Object;

    })(__m2);

    // ## can/util/string/string.js
    var __m9 = (function(can) {
        // ##string.js
        // _Miscellaneous string utility functions._

        // Several of the methods in this plugin use code adapated from Prototype
        // Prototype JavaScript framework, version 1.6.0.1.
        // © 2005-2007 Sam Stephenson
        var strUndHash = /_|-/,
            strColons = /\=\=/,
            strWords = /([A-Z]+)([A-Z][a-z])/g,
            strLowUp = /([a-z\d])([A-Z])/g,
            strDash = /([a-z\d])([A-Z])/g,
            strReplacer = /\{([^\}]+)\}/g,
            strQuote = /"/g,
            strSingleQuote = /'/g,
            strHyphenMatch = /-+(.)?/g,
            strCamelMatch = /[a-z][A-Z]/g,
        // Returns the `prop` property from `obj`.
        // If `add` is true and `prop` doesn't exist in `obj`, create it as an
        // empty object.
            getNext = function(obj, prop, add) {
                var result = obj[prop];

                if (result === undefined && add === true) {
                    result = obj[prop] = {}
                }
                return result
            },

        // Returns `true` if the object can have properties (no `null`s).
            isContainer = function(current) {
                return (/^f|^o/).test(typeof current);
            },
            convertBadValues = function(content) {
                // Convert bad values into empty strings
                var isInvalid = content === null || content === undefined || (isNaN(content) && ("" + content === 'NaN'));
                return ("" + (isInvalid ? '' : content))
            };

        can.extend(can, {
            // Escapes strings for HTML.
            esc: function(content) {
                return convertBadValues(content)
                    .replace(/&/g, '&amp;')
                    .replace(/</g, '&lt;')
                    .replace(/>/g, '&gt;')
                    .replace(strQuote, '&#34;')
                    .replace(strSingleQuote, "&#39;");
            },

            getObject: function(name, roots, add) {

                // The parts of the name we are looking up
                // `['App','Models','Recipe']`
                var parts = name ? name.split('.') : [],
                    length = parts.length,
                    current,
                    r = 0,
                    i, container, rootsLength;

                // Make sure roots is an `array`.
                roots = can.isArray(roots) ? roots : [roots || window];

                rootsLength = roots.length

                if (!length) {
                    return roots[0];
                }

                // For each root, mark it as current.
                for (r; r < rootsLength; r++) {
                    current = roots[r];
                    container = undefined;

                    // Walk current to the 2nd to last object or until there
                    // is not a container.
                    for (i = 0; i < length && isContainer(current); i++) {
                        container = current;
                        current = getNext(container, parts[i]);
                    }

                    // If we found property break cycle
                    if (container !== undefined && current !== undefined) {
                        break
                    }
                }

                // Remove property from found container
                if (add === false && current !== undefined) {
                    delete container[parts[i - 1]]
                }

                // When adding property add it to the first root
                if (add === true && current === undefined) {
                    current = roots[0]

                    for (i = 0; i < length && isContainer(current); i++) {
                        current = getNext(current, parts[i], true);
                    }
                }

                return current;
            },
            // Capitalizes a string.

            capitalize: function(s, cache) {
                // Used to make newId.
                return s.charAt(0).toUpperCase() + s.slice(1);
            },


            camelize: function(str) {
                return convertBadValues(str).replace(strHyphenMatch, function(match, chr) {
                    return chr ? chr.toUpperCase() : ''
                })
            },


            hyphenate: function(str) {
                return convertBadValues(str).replace(strCamelMatch, function(str, offset) {
                    return str.charAt(0) + '-' + str.charAt(1).toLowerCase();
                });
            },

            // Underscores a string.
            underscore: function(s) {
                return s
                    .replace(strColons, '/')
                    .replace(strWords, '$1_$2')
                    .replace(strLowUp, '$1_$2')
                    .replace(strDash, '_')
                    .toLowerCase();
            },
            // Micro-templating.

            sub: function(str, data, remove) {
                var obs = [];

                str = str || '';

                obs.push(str.replace(strReplacer, function(whole, inside) {

                    // Convert inside to type.
                    var ob = can.getObject(inside, data, remove === true ? false : undefined);

                    if (ob === undefined || ob === null) {
                        obs = null;
                        return "";
                    }

                    // If a container, push into objs (which will return objects found).
                    if (isContainer(ob) && obs) {
                        obs.push(ob);
                        return "";
                    }

                    return "" + ob;
                }));

                return obs === null ? obs : (obs.length <= 1 ? obs[0] : obs);
            },

            // These regex's are used throughout the rest of can, so let's make
            // them available.
            replacer: strReplacer,
            undHash: strUndHash
        });
        return can;
    })(__m2);

    // ## can/util/fixture/fixture.js
    var __m8 = (function(can) {

        // Get the URL from old Steal root, new Steal config or can.fixture.rootUrl
        var getUrl = function(url) {
            if (typeof steal !== 'undefined') {
                if (can.isFunction(steal.config)) {
                    return steal.config().root.mapJoin(url).toString();
                }
                return steal.root.join(url).toString();
            }
            return (can.fixture.rootUrl || '') + url;
        }

        var updateSettings = function(settings, originalOptions) {
                if (!can.fixture.on) {
                    return;
                }

                //simple wrapper for logging
                var _logger = function(type, arr) {
                        if (console.log.apply) {
                            Function.prototype.call.apply(console[type], [console].concat(arr));
                            // console[type].apply(console, arr)
                        } else {
                            console[type](arr)
                        }
                    },
                    log = function() {
                        if (typeof steal !== 'undefined' && steal.dev) {
                            steal.dev.log('fixture INFO: ' + Array.prototype.slice.call(arguments).join(' '));
                        }
                    }

                // We always need the type which can also be called method, default to GET
                settings.type = settings.type || settings.method || 'GET';

                // add the fixture option if programmed in
                var data = overwrite(settings);

                // if we don't have a fixture, do nothing
                if (!settings.fixture) {
                    if (window.location.protocol === "file:") {
                        log("ajax request to " + settings.url + ", no fixture found");
                    }
                    return;
                }

                //if referencing something else, update the fixture option
                if (typeof settings.fixture === "string" && can.fixture[settings.fixture]) {
                    settings.fixture = can.fixture[settings.fixture];
                }

                // if a string, we just point to the right url
                if (typeof settings.fixture == "string") {
                    var url = settings.fixture;

                    if (/^\/\//.test(url)) {
                        // this lets us use rootUrl w/o having steal...
                        url = getUrl(settings.fixture.substr(2));
                    }

                    if (data) {
                        // Template static fixture URLs
                        url = can.sub(url, data);
                    }

                    delete settings.fixture;



                    settings.url = url;
                    settings.data = null;
                    settings.type = "GET";
                    if (!settings.error) {
                        settings.error = function(xhr, error, message) {
                            throw "fixtures.js Error " + error + " " + message;
                        };
                    }
                } else {


                    //it's a function ... add the fixture datatype so our fixture transport handles it
                    // TODO: make everything go here for timing and other fun stuff
                    // add to settings data from fixture ...
                    settings.dataTypes && settings.dataTypes.splice(0, 0, "fixture");

                    if (data && originalOptions) {
                        can.extend(originalOptions.data, data)
                    }
                }
            },
        // A helper function that takes what's called with response
        // and moves some common args around to make it easier to call
            extractResponse = function(status, statusText, responses, headers) {
                // if we get response(RESPONSES, HEADERS)
                if (typeof status != "number") {
                    headers = statusText;
                    responses = status;
                    statusText = "success"
                    status = 200;
                }
                // if we get response(200, RESPONSES, HEADERS)
                if (typeof statusText != "string") {
                    headers = responses;
                    responses = statusText;
                    statusText = "success";
                }
                if (status >= 400 && status <= 599) {
                    this.dataType = "text"
                }
                return [status, statusText, extractResponses(this, responses), headers];
            },
        // If we get data instead of responses,
        // make sure we provide a response type that matches the first datatype (typically json)
            extractResponses = function(settings, responses) {
                var next = settings.dataTypes ? settings.dataTypes[0] : (settings.dataType || 'json');
                if (!responses || !responses[next]) {
                    var tmp = {}
                    tmp[next] = responses;
                    responses = tmp;
                }
                return responses;
            };

        //used to check urls
        // check if jQuery
        if (can.ajaxPrefilter && can.ajaxTransport) {

            // the pre-filter needs to re-route the url
            can.ajaxPrefilter(updateSettings);

            can.ajaxTransport("fixture", function(s, original) {
                // remove the fixture from the datatype
                s.dataTypes.shift();

                //we'll return the result of the next data type
                var timeout, stopped = false;

                return {
                    send: function(headers, callback) {
                        // we'll immediately wait the delay time for all fixtures
                        timeout = setTimeout(function() {
                            // if the user wants to call success on their own, we allow it ...
                            var success = function() {
                                    if (stopped === false) {
                                        callback.apply(null, extractResponse.apply(s, arguments));
                                    }
                                },
                            // get the result form the fixture
                                result = s.fixture(original, success, headers, s);
                            if (result !== undefined) {
                                // make sure the result has the right dataType
                                callback(200, "success", extractResponses(s, result), {});
                            }
                        }, can.fixture.delay);
                    },
                    abort: function() {
                        stopped = true;
                        clearTimeout(timeout)
                    }
                };
            });
        } else {
            var AJAX = can.ajax;
            can.ajax = function(settings) {
                updateSettings(settings, settings);
                if (settings.fixture) {
                    var timeout, d = new can.Deferred(),
                        stopped = false;

                    //TODO this should work with response
                    d.getResponseHeader = function() {}

                    // call success and fail
                    d.then(settings.success, settings.fail);

                    // abort should stop the timeout and calling success
                    d.abort = function() {
                        clearTimeout(timeout);
                        stopped = true;
                        d.reject(d)
                    }
                    // set a timeout that simulates making a request ....
                    timeout = setTimeout(function() {
                        // if the user wants to call success on their own, we allow it ...
                        var success = function() {
                                var response = extractResponse.apply(settings, arguments),
                                    status = response[0];

                                if ((status >= 200 && status < 300 || status === 304) && stopped === false) {
                                    d.resolve(response[2][settings.dataType])
                                } else {
                                    // TODO probably resolve better
                                    d.reject(d, 'error', response[1]);
                                }
                            },
                        // get the result form the fixture
                            result = settings.fixture(settings, success, settings.headers, settings);
                        if (result !== undefined) {
                            d.resolve(result)
                        }
                    }, can.fixture.delay);

                    return d;
                } else {
                    return AJAX(settings);
                }
            }
        }

        var typeTest = /^(script|json|text|jsonp)$/,
        // a list of 'overwrite' settings object
            overwrites = [],
        // returns the index of an overwrite function
            find = function(settings, exact) {
                for (var i = 0; i < overwrites.length; i++) {
                    if ($fixture._similar(settings, overwrites[i], exact)) {
                        return i;
                    }
                }
                return -1;
            },
        // overwrites the settings fixture if an overwrite matches
            overwrite = function(settings) {
                var index = find(settings);
                if (index > -1) {
                    settings.fixture = overwrites[index].fixture;
                    return $fixture._getData(overwrites[index].url, settings.url)
                }

            },
        // Makes an attempt to guess where the id is at in the url and returns it.
            getId = function(settings) {
                var id = settings.data.id;

                if (id === undefined && typeof settings.data === "number") {
                    id = settings.data;
                }



                if (id === undefined) {
                    settings.url.replace(/\/(\d+)(\/|$|\.)/g, function(all, num) {
                        id = num;
                    });
                }

                if (id === undefined) {
                    id = settings.url.replace(/\/(\w+)(\/|$|\.)/g, function(all, num) {
                        if (num != 'update') {
                            id = num;
                        }
                    })
                }

                if (id === undefined) { // if still not set, guess a random number
                    id = Math.round(Math.random() * 1000)
                }

                return id;
            };

        var $fixture = can.fixture = function(settings, fixture) {
            // if we provide a fixture ...
            if (fixture !== undefined) {
                if (typeof settings == 'string') {
                    // handle url strings
                    var matches = settings.match(/(GET|POST|PUT|DELETE) (.+)/i);
                    if (!matches) {
                        settings = {
                            url: settings
                        };
                    } else {
                        settings = {
                            url: matches[2],
                            type: matches[1]
                        };
                    }

                }

                //handle removing.  An exact match if fixture was provided, otherwise, anything similar
                var index = find(settings, !! fixture);
                if (index > -1) {
                    overwrites.splice(index, 1)
                }
                if (fixture == null) {
                    return
                }
                settings.fixture = fixture;
                overwrites.push(settings)
            } else {
                can.each(settings, function(fixture, url) {
                    $fixture(url, fixture);
                })
            }
        };
        var replacer = can.replacer;

        can.extend(can.fixture, {
            // given ajax settings, find an overwrite
            _similar: function(settings, overwrite, exact) {
                if (exact) {
                    return can.Object.same(settings, overwrite, {
                        fixture: null
                    })
                } else {
                    return can.Object.subset(settings, overwrite, can.fixture._compare)
                }
            },
            _compare: {
                url: function(a, b) {
                    return !!$fixture._getData(b, a)
                },
                fixture: null,
                type: "i"
            },
            // gets data from a url like "/todo/{id}" given "todo/5"
            _getData: function(fixtureUrl, url) {
                var order = [],
                    fixtureUrlAdjusted = fixtureUrl.replace('.', '\\.').replace('?', '\\?'),
                    res = new RegExp(fixtureUrlAdjusted.replace(replacer, function(whole, part) {
                        order.push(part)
                        return "([^\/]+)"
                    }) + "$").exec(url),
                    data = {};

                if (!res) {
                    return null;
                }
                res.shift();
                can.each(order, function(name) {
                    data[name] = res.shift()
                })
                return data;
            },

            store: function(types, count, make, filter) {

                var items = [], // TODO: change this to a hash
                    currentId = 0,
                    findOne = function(id) {
                        for (var i = 0; i < items.length; i++) {
                            if (id == items[i].id) {
                                return items[i];
                            }
                        }
                    },
                    methods = {};

                if (typeof types === "string") {
                    types = [types + "s", types]
                } else if (!can.isArray(types)) {
                    filter = make;
                    make = count;
                    count = types;
                }

                // make all items
                can.extend(methods, {

                    findAll: function(request) {
                        request = request || {}
                        //copy array of items
                        var retArr = items.slice(0);
                        request.data = request.data || {};
                        //sort using order
                        //order looks like ["age ASC","gender DESC"]
                        can.each((request.data.order || []).slice(0).reverse(), function(name) {
                            var split = name.split(" ");
                            retArr = retArr.sort(function(a, b) {
                                if (split[1].toUpperCase() !== "ASC") {
                                    if (a[split[0]] < b[split[0]]) {
                                        return 1;
                                    } else if (a[split[0]] == b[split[0]]) {
                                        return 0
                                    } else {
                                        return -1;
                                    }
                                } else {
                                    if (a[split[0]] < b[split[0]]) {
                                        return -1;
                                    } else if (a[split[0]] == b[split[0]]) {
                                        return 0
                                    } else {
                                        return 1;
                                    }
                                }
                            });
                        });

                        //group is just like a sort
                        can.each((request.data.group || []).slice(0).reverse(), function(name) {
                            var split = name.split(" ");
                            retArr = retArr.sort(function(a, b) {
                                return a[split[0]] > b[split[0]];
                            });
                        });

                        var offset = parseInt(request.data.offset, 10) || 0,
                            limit = parseInt(request.data.limit, 10) || (items.length - offset),
                            i = 0;

                        //filter results if someone added an attr like parentId
                        for (var param in request.data) {
                            i = 0;
                            if (request.data[param] !== undefined && // don't do this if the value of the param is null (ignore it)
                                (param.indexOf("Id") != -1 || param.indexOf("_id") != -1)) {
                                while (i < retArr.length) {
                                    if (request.data[param] != retArr[i][param]) {
                                        retArr.splice(i, 1);
                                    } else {
                                        i++;
                                    }
                                }
                            }
                        }

                        if (filter) {
                            i = 0;
                            while (i < retArr.length) {
                                if (!filter(retArr[i], request)) {
                                    retArr.splice(i, 1);
                                } else {
                                    i++;
                                }
                            }
                        }

                        //return data spliced with limit and offset
                        return {
                            "count": retArr.length,
                            "limit": request.data.limit,
                            "offset": request.data.offset,
                            "data": retArr.slice(offset, offset + limit)
                        };
                    },

                    findOne: function(request, response) {
                        var item = findOne(getId(request));
                        response(item ? item : undefined);
                    },

                    update: function(request, response) {
                        var id = getId(request);

                        // TODO: make it work with non-linear ids ..
                        can.extend(findOne(id), request.data);
                        response({
                            id: getId(request)
                        }, {
                            location: request.url || "/" + getId(request)
                        });
                    },

                    destroy: function(request) {
                        var id = getId(request);
                        for (var i = 0; i < items.length; i++) {
                            if (items[i].id == id) {
                                items.splice(i, 1);
                                break;
                            }
                        }

                        // TODO: make it work with non-linear ids ..
                        can.extend(findOne(id) || {}, request.data);
                        return {};
                    },

                    create: function(settings, response) {
                        var item = make(items.length, items);

                        can.extend(item, settings.data);

                        if (!item.id) {
                            item.id = currentId++;
                        }

                        items.push(item);
                        response({
                            id: item.id
                        }, {
                            location: settings.url + "/" + item.id
                        })
                    }
                });

                var reset = function() {
                    items = [];
                    for (var i = 0; i < (count); i++) {
                        //call back provided make
                        var item = make(i, items);

                        if (!item.id) {
                            item.id = i;
                        }
                        currentId = Math.max(item.id + 1, currentId + 1) || items.length;
                        items.push(item);
                    }
                    if (can.isArray(types)) {
                        can.fixture["~" + types[0]] = items;
                        can.fixture["-" + types[0]] = methods.findAll;
                        can.fixture["-" + types[1]] = methods.findOne;
                        can.fixture["-" + types[1] + "Update"] = methods.update;
                        can.fixture["-" + types[1] + "Destroy"] = methods.destroy;
                        can.fixture["-" + types[1] + "Create"] = methods.create;
                    }

                }
                reset()
                // if we have types given add them to can.fixture


                return can.extend({
                    getId: getId,

                    find: function(settings) {
                        return findOne(getId(settings));
                    },

                    reset: reset
                }, methods);
            },

            rand: function(arr, min, max) {
                if (typeof arr == 'number') {
                    if (typeof min == 'number') {
                        return arr + Math.floor(Math.random() * (min - arr));
                    } else {
                        return Math.floor(Math.random() * arr);
                    }

                }
                var rand = arguments.callee;
                // get a random set
                if (min === undefined) {
                    return rand(arr, rand(arr.length + 1))
                }
                // get a random selection of arr
                var res = [];
                arr = arr.slice(0);
                // set max
                if (!max) {
                    max = min;
                }
                //random max
                max = min + Math.round(rand(max - min))
                for (var i = 0; i < max; i++) {
                    res.push(arr.splice(rand(arr.length), 1)[0])
                }
                return res;
            },

            xhr: function(xhr) {
                return can.extend({}, {
                    abort: can.noop,
                    getAllResponseHeaders: function() {
                        return "";
                    },
                    getResponseHeader: function() {
                        return "";
                    },
                    open: can.noop,
                    overrideMimeType: can.noop,
                    readyState: 4,
                    responseText: "",
                    responseXML: null,
                    send: can.noop,
                    setRequestHeader: can.noop,
                    status: 200,
                    statusText: "OK"
                }, xhr);
            },

            on: true
        });

        can.fixture.delay = 200;


        can.fixture.rootUrl = getUrl('');

        can.fixture["-handleFunction"] = function(settings) {
            if (typeof settings.fixture === "string" && can.fixture[settings.fixture]) {
                settings.fixture = can.fixture[settings.fixture];
            }
            if (typeof settings.fixture == "function") {
                setTimeout(function() {
                    if (settings.success) {
                        settings.success.apply(null, settings.fixture(settings, "success"));
                    }
                    if (settings.complete) {
                        settings.complete.apply(null, settings.fixture(settings, "complete"));
                    }
                }, can.fixture.delay);
                return true;
            }
            return false;
        };

        //Expose this for fixture debugging
        can.fixture.overwrites = overwrites;
        can.fixture.make = can.fixture.store;
        return can.fixture;
    })(__m2, __m9, __m1);

    window['can'] = __m4;
})();