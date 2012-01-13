{% extends "base.tpl" %}

{% block content %}
{% if m.acl.view[id] %}  

  <h1>{{ id.title }}</h1>
  
  <p class="summary">
    {{ id.summary }}
  </p>

  {% with id.s.column_card[1].s.project_column[1] as project %}
  <p>
        Project: <a href="{{ project.page_url }}" title="{{ project.summary }}">{{ project.title }}</a>
  </p>
  {% endwith %}

{% tabs id="tabs" %}
<div id="tabs">
     <ul>
        <li><a href="#info">Info</a></li>
        {% if m.acl.update[id] %}
          <li><a href="{% url edit_bare id=id %}">Edit</a></li>
        {% endif %}
     </ul>

     <div id="info">
          {{ id.body|show_media }}
     </div>

</div>

{% else %}
  <h1>You are not authorized to view this card</h1>
{% endif %}
{% endblock %}
