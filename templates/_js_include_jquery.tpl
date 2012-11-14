{% if m.req.path|match:"/admin" %}
{% lib
	"js/apps/jquery-latest.min.js"
	"js/apps/jquery-ui-latest.min.js"
	"js/modules/z.dialog.js"
%}

{% else %}

{% lib
	"js/jquery-1.6.2.min.js"
	"js/jquery-ui-1.8.16.custom.min.js"

        "js/modules/z.jquery.dialog.js"
%}
{% endif %}
