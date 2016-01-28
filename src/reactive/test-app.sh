#!/bin/bash

source $CHARM_DIR/bin/charms.reactive.sh
PATH=$CHARM_DIR/app:$PATH

@when 'elnode.available'
function elnodeAvailable() {
    serve.el ":port 8080"
    status-set active "Ready."
    # Start elnode
    # Switch context into elisp and call (serve-site :port ?)
}

# For when relating the website to things (HA proxy, etc.)
@when 'website.available'
function foo() {
    # Launch server
    # Pass in env. vars for server
    # Introspect launched port and send to relation.
    relation-set '{port: 80}'
}

@when 'config-changed'
function elnodeReadyC() {
    if [ -z is_state 'elnode.available' ]
    then
        status-set active "Sorry"
        return
    fi

    status-set maintenance "Serving http?"
}

reactive_handler_main
