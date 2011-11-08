{% with id.o.column_card|length as count %}
({{ count }} card{% if count /= 1 %}s{% endif %})
{% endwith %}
