var Lighthouse = {
    init: function() {
        if(this.userId) {
            var showBinMenu = false, shownBins = 0, match;
            var bb = $('bin-block'), bs = $('bin-sorter');
      
            $$('li.bin').each(function(bin) {
                match = bin.id.match(/^(\d+)_/)
                if(match && Lighthouse.userId == match[1]) {
                    bin.show()
                    showBinMenu = true;
                }
                if(bin.visible()) shownBins += 1;
            });

            if(showBinMenu && bb)
                bb.show()
            if(Lighthouse.projectMember && bs && shownBins > 1)
                bs.show()
        }
    },
  
    toggleLogin: function(evt) {
        Event.stop(evt)
        if($('openid_region').visible()) {
            $('openid_region').hide()
            $('login_region').show()
        } else {
            $('openid_region').show()
            $('login_region').hide()
        }
        return false;
    }
};

Abstract.SmartEventObserver = Class.create(Abstract.EventObserver, {
    onElementEvent: function(event) {
        var value = this.getValue();
        if (this.lastValue != value) {
            this.callback(Event.element(event), value, event);
            this.lastValue = value;
        }
    }
});

var SmartForm = {};
SmartForm.EventObserver = Class.create(Abstract.SmartEventObserver, {
    getValue: function() {
        return Form.serialize(this.element);
    }
});


var DomUtil = {
    addImage: function(el, src, klass) {
        var img = $(document.createElement('img'));
        img.src = src;
        img.addClassName(klass);
        el.appendChild(img);
    }
};

var Ticket = {
    goTo: function(url) {
        window.location = url;
    },
    showSpam: function(anchor) {
        var parent = anchor.up('div')
        parent.hide();
        parent.next('div').show();
    }
}

var Announcement = {
    toggle: function(chk, token) {
        if(chk.checked) {
            $$('#announcements input.visible').each(function(e) { e.checked = false; })
            new Ajax.Request("/admin/announcements/" + chk.up("form").id.match(/-(\d+)$/)[1] + ";show", {parameters: 'authenticity_token=' + token});
        } else {
            new Ajax.Request("/admin/announcements;hide", {parameters: 'authenticity_token=' + token});
        }
    },

    remember: function(id, domain) {
        with(expiration = new Date()) {
            setFullYear(getFullYear() + 5);
        }

        Cookie.write({
            name: 'ann-' + id, value: '1', 
            expires: expiration,
            path: '/', 'domain': '.' + domain});
        new Effect.BlindUp('announcement');
    },
  
    reveal: function() {
        var ann = $('announcement');
        if(!ann) return;
        var id = ann.className.match(/^ann-(\d+)$/)[1];
        if(Cookie.read('ann-' + id) == null) {
            ann.show();
        }
    }
}

Effect.DefaultOptions.duration = 0.25;

var User = {
    toggleResetPasswordForm: function() {
        Effect.toggle('reset-password', 'blind', {duration: 0.2});
    }
}

/*-------------------- Flash ------------------------------*/
// Flash is used to manage error messages and notices from 
// Ajax calls.
//
var Flash = {
    Timeout: null,
    // When given an flash message, wrap it in a list 
    // and show it on the screen.  This message will auto-hide 
    // after a specified amount of milliseconds
    show: function(flashType, message, hangAround) {
        new Effect.ScrollTo('flash-' + flashType);
        $('flash-' + flashType).update();
        if(message.toString().match(/<li/)) message = "<ul>" + message + '</ul>'
        $('flash-' + flashType).update(message);
        new Effect.Appear('flash-' + flashType, {duration: 0.3});
        if(!hangAround)
            Flash.Timeout = setTimeout(this['fade' + flashType.capitalize()].bind(this), 5000);
    },
  
    errors: function(message, hangAround) {
        this.show('errors', message, hangAround);
    },

    // Notice-level messages.  See Messenger.error for full details.
    notice: function(message, hangAround) {
        this.show('notice', message, hangAround);
    },
  
    // Responsible for fading notices level messages in the dom    
    fadeNotice: function() {
        new Effect.Fade('flash-notice', {duration: 0.5});
        clearTimeout(Flash.Timeout);
    },
  
    // Responsible for fading error messages in the DOM
    fadeErrors: function() {
        new Effect.Fade('flash-errors', {duration: 0.5});
        clearTimeout(Flash.Timeout);
    }
}

var Attachment = {
    addField: function(copyFrom) {
        var currentField = $(copyFrom);
        var newNode = currentField.cloneNode(true);
        currentField.parentNode.appendChild(newNode);
    }
};

var Token = {
    hideForm: function(div, form) {
        $('new_token').hide();
        $('token_account_id').selectedIndex = 0;
    },
  
    showForm: function(account) {
        var token      = Lighthouse.authenticityToken;
        var account_id = $F(account);
        if(account_id != '') token = token + '&account_id=' + account_id;
        $('new_token_spinner').show()
        new Ajax.Request('/tokens/new?authenticity_token=' + token, {method: 'get'})
    }
}

var DropMenu = Class.create({
    initialize: function(element, optionsCallback) {
        this.menu = $(element);
        if(!this.menu) return;
        this.trigger = this.menu.down('.trigger');
        this.options = $('optgroup');
        this.focused = false;

        if(!Object.isUndefined(optionsCallback)) {
            optionsCallback.call(this, this.options.down(0).childElements());
        }
    
        this.trigger.observe('click', this.onTriggerClick.bind(this));
        this.menu.observe('mouseover', this.onMenuFocus.bind(this));
        this.menu.observe('mouseout', this.onMenuBlur.bind(this));
    },

    onTriggerClick: function(event) {
        event.stop();
        clearTimeout(this.timeout);
        this.options.setOpacity(1);
        Element.toggle(this.options);

        if(this.options.visible())
            this.trigger.addClassName('down');
        else
            this.trigger.removeClassName('down');
    },

    onMenuFocus: function() {
        this.focused = true;
    },

    onMenuBlur: function() {
        this.focused = false;
        this.timeout = setTimeout(this.fadeMenu.bind(this), 400);
    },

    fadeMenu: function() {
        if(!this.focused) {
            this.trigger.removeClassName('down');
            new Effect.Fade(this.options, {duration: 0.2});
            this.trigger.blur();
            clearTimeout(this.timeout);
        }
    }
});


/**
 * Creates a delicious style tagging UI
 */
var TagList = Class.create({      
    initialize: function(line, list) {
        this.line = $(line);      
        this.list = $(list);

        var tagNodes = this.allTagNodes();
        this.line.observe('keyup', this.onTagLineChange.bind(this));
        this.allTagNodes().invoke('observe', 'click', this.onTagClick.bind(this));
        this.updateTagLine(this.fetchCurrentTags());
    },

    onTagLineChange: function(event) {
        this.updateActiveTags();  
    },

    allTagNodes: function() {
        if(this.tagNodes == null) { this.tagNodes = $A(this.list.getElementsByTagName('a')); }
        return this.tagNodes;
    },

    onTagClick: function(event) {
        event.stop();
        this.toggleTag(event.findElement('a').innerHTML);
    },

    toggleTag: function(tag) {
        tags = this.fetchCurrentTags();
        if(tags.include(tag)) tags = tags.reject(function(elem){ return elem == tag});
        else tags.push(tag);
        this.updateTagLine(tags);
    },

    tagWords: function() {
        return this.allTagNodes().collect(function(item) { return item.innerHTML; });
    },

    fetchCurrentTags: function() {
        var tags = []
        var tagString = $F(this.line).gsub(/\"(.*?)\"\s*/, function(s) {
            tags.push(s[1]);
            return '';
        })
        return tagString.split(' ').collect(function(tag) {
            return tag;
        }).reject(function(str){
            return str == '';
        }).concat(tags);
    },
  
    tagName: function(s) {
        s = s.strip().toLowerCase().gsub(/[^a-z0-9 \-_@\!\.'\:]/, '')
        return s.indexOf(' ') != -1 ? ('"' + s + '"') : s
    },

    updateTagLine: function(tags) {
        tagList = this;
        this.line.setValue(tags.collect(function(t) { return tagList.tagName(t) }).join(" "));
        this.updateActiveTags(tags);
    },

    updateActiveTags: function(tags) {
        if(!tags) tags = this.fetchCurrentTags();
        this.allTagNodes().each(function(a) {
            if(tags.include(a.innerHTML)) {
                a.addClassName("active"); 
            }
            else  { 
                a.removeClassName("active"); 
            }
        });        
    }  
});


/*
 * Behaviors
 
Event.addBehavior({

  '#reset-password': function() { this.hide(); },
  '#reset-password-link:click,#reset-password-cancel:click': function() { User.toggleResetPasswordForm(); },
    
  
  '#announcement': function() { Announcement.reveal(); },
  '#token_account_id:change': function() {
    if(this.selectedIndex < 1) 
      Token.hideForm();
    else
      Token.showForm(this);
  },
  
  'a.prioritize': function() {
    var ts = new TicketSorter(this);
    ts.markPriority();
  }
});
 */
var AbstractSorter = Class.create({
    initialize: function(invoker, options) {
        this.options = options;
        this.invoker = $(invoker);
        if(!this.invoker) return;
        this.invokerText = this.invoker.innerHTML;
        this.list = this.invoker.up('div').down('ul');
        this.handles = this.list.select('.handle');
        this.invoker.observe('click', this.onSort.bind(this));
        if($('delete-diag'))
            this.token = $('delete-diag').down('form')['authenticity_token'].value;
    },

    onSort: function(event) {
        event.stop();
        if(this.invoker.hasClassName('sorting')) {
            this.invoker.update('Saving...');
            this.handles.invoke('hide');
            new Ajax.Request(this.requestUrl(), {
                parameters: this.requestParameters(),
                onComplete: this.requestOnComplete.bind(this)
            });
        } else {
            this.invoker.update('Done')
            this.invoker.addClassName('sorting');
            Sortable.create(this.list, {handle: 'handle', onChange: this.sortableOnChange});
            this.handles.invoke('show');
        }
    },

    requestUrl: function() {
        // pdi
    },
  
    requestParameters: function(options) {
        options = $H(options);
        options.set('authenticity_token', Lighthouse.authenticityToken);
        return Sortable.serialize(this.list, {name: 'priorities'}) + '&' + options.toQueryString();
    },
  
    requestOnComplete: function() {
        this.invoker.update(this.invokerText);
        this.invoker.removeClassName('sorting');
        Sortable.destroy(this.list);
    },
  
    sortableOnChange: function(event) {
        event.removeClassName('highp') 
    }
});

var PageSorter = Class.create(AbstractSorter, {
    initialize: function($super, invoker) {
        $super(invoker);
        var pieces = location.href.match(/projects\/(\d+)/)
        if(pieces)
            this.projectId = pieces[1];
    },

    requestUrl: function($super) {
        if(this.projectId)
            return '/projects/' + this.projectId + '/pages/reorder'
        else
            return '/pages/reorder'
    }
});

var BinSorter = Class.create(PageSorter, {
    requestUrl: function($super) {
        if(this.projectId)
            return '/projects/' + this.projectId + '/bins/reorder'
        else
            return '/bins/reorder'
    }
});

var TicketSorter = Class.create(AbstractSorter, {
    initialize: function($super, invoker) {
        $super(invoker);
        this.userId = this.list.id.split('-').last();
        var pieces = location.href.match(/projects\/(\d+)/)
        this.projectId = pieces[1];
        this.milestoneId = $F('milestoneid');
    },

    requestUrl: function($super) {
        return '/projects/' + this.projectId + '/milestones/' + this.milestoneId + '/prioritize'
    },
  
    requestParameters: function($super, options) {
        return $super({user_id: this.userId})
    },

    requestOnComplete: function($super, event) {
        this.clearPriority();
        this.markPriority();
        $super();
    },
  
    sortableOnChange: function($super, event) {
        $super(event);
        var marker = event.down('span.marker');
        if(!Object.isUndefined(marker)) {
            event.removeChild(marker);
        }
    },
  
    markPriority: function() {
        var items = $A(this.list.getElementsByTagName('li'));
        if(items.size() > 5) {
      
            (5).times(function(i) {
                if(!Object.isUndefined(items[i])) {
                    var marker = new Element('span', {className: 'marker'});
                    var item = $(items[i]);
                    item.addClassName('highp');
                    marker.update('&nbsp;');
                    item.appendChild(marker);
                }
            })
        }
    },
  
    clearPriority: function() {
        var markers = this.list.select('.marker');
        markers.each(function(marker) {
            var parent = marker.up('li');
            marker.removeClassName('highp');
            parent.removeChild(marker);
        });
    }
});

var SubMenu = Class.create({
    initialize: function(li) {
        if(!$(li)) return;
        this.trigger = $(li).down('em');
        this.menu = $(li).down('ul');
        this.trigger.observe('click', this.respondToClick.bind(this));
        document.observe('click', function(){ this.menu.hide()}.bind(this));
    },
  
    respondToClick: function(event) {
        event.stop();
        $$('ul.submenu').without(this.menu).invoke('hide');
        this.menu.toggle()
    }
});



/*
 * DOM Ready Stuff
 */
 
document.observe('dom:loaded', function() {
    var projectSelect = $('project-select'), showArchives = $('show-archives');
    var filter = $('filter');
   
    if(projectSelect) {
        new Form.Element.EventObserver(projectSelect, function(element, value) {
            if(value == 'lhnew')
                return document.location = '/projects/new'
            document.location = '/projects/' + value;
        });
    }

    if(filter) {
        new Form.Element.EventObserver(filter, function(element, value) {
            $('q').value = value;
            $('search-form').submit();
        });
    }
  
    if(document.location.toString().match(/new$/)) {
        var frms = document.getElementsByTagName('FORM');
        if(frms[1]) $(frms[1]).focusFirstElement();
    }
  

    var hash = location.hash;
    if(hash && $(hash)) new Effect.Highlight(hash.substr(1), {duration: 0.7});
  
    var cproject = $('change-project');
    if(cproject)
        cproject.observe('click', function() {
            this.hide();
            $('utility').show();
        })
  
    if(showArchives)
        showArchives.observe('click', function() {
            if(this.innerHTML.match(/^A/)) {
                $$('#projects li.aproj').invoke('show');
                this.update('Done&hellip;')
            } else {
                $$('#projects li.aproj').invoke('hide');
                this.update('Archived&hellip;')
            }
    });
    
    var duedate = $('milestone_scheduled');
    var duecalendar = $('due-calendar');
    if(Object.isElement(duedate)) {
        duedate.observe('click', function() {
            var checked = $F(this);
            if(checked)
                duecalendar.show();
            else
                duecalendar.hide();
        });
        if($F(duedate)) {
            duecalendar.show();
        } else {
            duecalendar.hide();
        }
    }

    new PageSorter("sort-pages");
    new BinSorter("bin-sorter");
    new SubMenu("t-menu");

  
    if($('search-help-trigger')) {
        new Control.Modal('search-help-trigger',{
            opacity: 0.6,
            width: 300,
            height: 400
        });
    }
});


