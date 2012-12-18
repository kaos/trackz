{% with id|default:subject_id as id %}
    <li>
        <a href="{{ id.page_url }}">{{ id.title }}</a>
        {% if id.summary %} - {{ id.summary }}{% endif %}
        {% if role %}({{ role.short_title|default:role.title }}){% endif %}
    </li>
{% endwith %}
