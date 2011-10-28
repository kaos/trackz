{% extends "base.tpl" %}

{% block content %}

<h1>{{ id.title }}</h1>

<p class="summary">
    {{ id.summary }}
</p>

{{ id.body|show_media }}

<p>
<div class="columns">
{% for col in id.o.project_column %}
    <div class="column zp-25">
        <span class="title">{{ col.title }}</span>
    </div>
{% endfor %}
</div>

{% endblock %}
