{% for r in id.o.rbac_domain_role %}
    <div class="ui-widget">
        <div class="ui-widget-header">{{ id.title }} {{ r.short_title }}s</div>
        <div class="ui-widget-content">
            <ul>
                {% for member in r.s.rbac_role_member %}
                    <li>{{ member.title }}</li>
                {% endfor %}
            </ul>
        </div>
    </div>
    <br />
{% endfor %}
