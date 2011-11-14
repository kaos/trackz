{% if m.req.path|match:"/admin" %}
{% lib
	"js/apps/jquery-1.6.2.min.js"
	"js/apps/jquery-ui-1.8.11.min.js"

        "js/modules/z.jquery.dialog.js"
%}

{% else %}

{% lib
	"js/jquery-1.6.2.min.js"
	"js/jquery-ui-1.8.16.custom.min.js"

        "js/modules/z.jquery.dialog.js"
%}
{% endif %}
