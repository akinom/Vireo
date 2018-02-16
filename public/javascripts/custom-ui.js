jQuery(document).ready(function() {
    $('a[target="_blank"]').append("<span class='sr-only'>Opens in new window</span><i class='fa fa-external-link' aria-hidden='true'></i>");
    $('a[href^="mailto:"]').append("<span class='sr-only'>Opens email client</span><i class='fa fa-envelope-o' aria-hidden='true'></i>");
});