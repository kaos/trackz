{% extends "base.tpl" %}

{% block content %}

<h1>{{ id.title }}</h1>

<p class="summary">
    {{ id.summary }}
</p>

{{ id.body|show_media }}

<p>
Is me: {{ id.is_me }}

<p>
Your Projects:

<p>
{% for p in id.s.project_member %}
    {{ p.title }}<br />
{% empty %}
    You are not a member of any projects.
{% endfor %}

{% endblock %}
