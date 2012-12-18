{% extends "page.tpl" %}

{% block below_body %}
    <div id="content">
        {% include "_profile_content.tpl" id=m.acl.user target="content" %}
    </div>
{% endblock %}
