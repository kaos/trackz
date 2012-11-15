<image src="http://www.gravatar.com/avatar/{{ id.email|gravatar_code }}?s=24&d=mm" title="{{ id.summary }}" />
{{ id.title }}{% if id.short_title %} ({{ id.short_title }}){% endif %}
