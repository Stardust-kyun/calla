/**
 * This is used to access our classes from within jQuery callbacks.
 */
var _self = null;
var _util = null;

class greeter {

    constructor() {
        if (_self !== null) {
            return _self;
        }
        _self = this;

        this.auth_pending = false;

        this.$error_message = $('#error-message');
        this.$login_button = $('form button');
        this.$password = $('#password');
        this.$session = $('#sessions .select-value');
        this.$sessions_list = $('#sessions .select-menu');
        this.$user = $('#users .select-value');
        this.$users_list = $('#users .select-menu');

        this.initialize();

        return _self;
    }

    /**
     * Called when the user attempts to authenticate (submits password).
     * We check to see if the user successfully authenticated and if so tell the LDM
     * Greeter to log them in with the session they selected.
     */
    authentication_complete() {
        var selected_session = _self.$session.attr('id');

        _self.auth_pending = false;
        _util.cache_set(lightdm.authentication_user, selected_session);
        _util.cache_set('last_authenticated_user', lightdm.authentication_user);

        if (lightdm.is_authenticated) {
            lightdm.login(lightdm.authentication_user, selected_session);
        } else {
            _self.$error_message.text("Authentication failed, try again.");
            _self.$password.val('');
            _self.start_authentication();
        }
    }

    /**
     * Cancel the pending authentication.
     *
     * @param {object} event - jQuery.Event object from 'click' event.
     */
    cancel_authentication(event) {
        lightdm.cancel_authentication();

        _self.auth_pending = false;
    }

    /**
     * Initialize the theme.
     */
    initialize() {
        this.prepare_session_list();
        this.prepare_users_list();
        this.register_callbacks();
    }

    /**
     * Initialize the user list.
     */
    prepare_users_list() {
        // Loop through the array of LightDMUser objects to create our user list.
        for (var user of lightdm.users) {
            $(`<li id="${user.name}">${user.name}</li>`).appendTo(this.$users_list);
        }

        var first = this.$users_list.children().first();
        first.addClass('selected');
        this.$user.text(first.text());
        this.$user.attr('id', first.attr('id'));

        var last_authenticated_user = _util.cache_get('last_authenticated_user');
        this.update_users_select(first, user=last_authenticated_user);
    }

    /**
     * Initialize the session selection dropdown.
     */
    prepare_session_list() {
        // Loop through the array of LightDMSession objects to create our session list.
        for (var session of lightdm.sessions) {
            $(`<li id="${session.key}">${session.name}</li>`).appendTo(this.$sessions_list);
        }

        var first = this.$sessions_list.children().first();
        first.addClass('selected');
        this.$session.text(first.text());
        this.$session.attr('id', first.attr('id'));
    }

    /**
     * Register callbacks for the LDM Greeter as well as any others that haven't
     * been registered elsewhere.
     */
    register_callbacks() {
        $('form').submit(function(event) {
            event.preventDefault();
            if (_self.auth_pending) {
                _self.$login_button.prop('disabled', true);
                _self.submit_password(event);
            }
        });

        $(".select").focusout(function() {
            $('.select-input').prop("checked", false);
        });

        $('#sessions li').click(this.update_sessions_select);
        $('#users li').click(this.update_users_select);

        window.authentication_complete = this.authentication_complete;
        window.cancel_authentication = this.cancel_authentication;
        window.start_authentication = this.start_authentication;
    }

    /**
     * Start the authentication process for the selected user.
     *
     * @param {object} event - jQuery.Event object from 'click' event.
     */
    start_authentication(event) {
        var username = _self.$user.attr('id');

        _self.$login_button.prop('disabled', false);

        if (_self.auth_pending) {
            lightdm.cancel_authentication();
        }

        _self.auth_pending = true;
        lightdm.authenticate(username);
    }

    submit_password(event) {
        lightdm.respond(_self.$password.val());
    }

    update_sessions_select(event) {
        var target = 'target' in event ? $(event.target) : event;
        var session = target.text();

        _self.$sessions_list.children().removeClass('selected');
        target.addClass('selected');

        _self.$session.text(session);
        _self.$session.attr('id', target.attr('id'));
    }

    update_users_select(event, user=null) {
        var target = 'target' in event ? $(event.target) : event;
        var user = user ? user : target.text();
        var session = _util.cache_get(user);

        if (!session) {
            session = _self.$sessions_list.children().first().attr('id');
        }

        var session_li = _self.$sessions_list.children('#' + session);
        if (session_li.length) {
            _self.update_sessions_select(session_li);
        }

        _self.$users_list.children().removeClass('selected');
        target.addClass('selected');

        _self.$user.text(user);
        _self.$user.attr('id', target.attr('id'));

        _self.start_authentication();
    }

}

class greeterUtils {

    constructor() {
        if (_util !== null) {
            return _util;
        }
        _util = this;

        return _util;
    }

    /**
     * Get a key's value from localStorage.
     *
     * @param {string} key - The key to retrieve.
     */
    cache_get(key) {
        if (typeof(Storage) !== 'undefined') {
           return localStorage.getItem(key)
        } else {
          // Sorry! No Web Storage support..
        }
    }

    /**
     * Set a key's value in localStorage.
     *
     * @param {string} value - The value to set.
     */
    cache_set(key, value) {
        if (typeof(Storage) !== 'undefined') {
           localStorage.setItem(key, value)
        } else {
          // Sorry! No Web Storage support..
        }
    }

}



/**
 * Initialize the theme once the window has loaded.
 */
$(window).on('load', () => {
    new greeterUtils();
    new greeter();
} );
