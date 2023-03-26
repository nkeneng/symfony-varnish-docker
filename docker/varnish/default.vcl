vcl 4.1;

import std;

include "fos/fos_user_context.vcl";
include "fos/fos_user_context_url.vcl";
include "fos/fos_custom_ttl.vcl";
include "fos/fos_debug.vcl";
include "fos/fos_refresh.vcl";
include "fos/fos_purge.vcl";
include "fos/fos_tags_xkey.vcl";
include "fos/fos_ban.vcl";

backend default {
    .host = "caddy";
    .port = "80";
}

acl invalidators {
    "localhost";
    "php";
    # Add any other IP addresses that your application runs on and that you
    # want to allow invalidation requests from. For instance:
    # "192.168.1.0"/24;
}

sub vcl_recv {
    call fos_ban_recv;
    call fos_purge_recv;
    call fos_refresh_recv;
    call fos_tags_xkey_recv;
    call fos_user_context_recv;
}

sub vcl_backend_response {
    call fos_user_context_backend_response;
    call fos_ban_backend_response;
    call fos_custom_ttl_backend_response;
}

sub vcl_deliver {
    call fos_user_context_deliver;
    call fos_debug_deliver;
    call fos_ban_deliver;
    call fos_tags_xkey_deliver;
}

sub vcl_deliver {
    call fos_tags_xkey_deliver;
}

sub vcl_backend_response {
    call fos_custom_ttl_backend_response;
}
