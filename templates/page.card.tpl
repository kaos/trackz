{% extends "base.tpl" %}

{% block content %}
  
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
        <li><a href="{% url edit_bare id=id %}">Edit</a></li>
     </ul>

     <div id="info">
          {{ id.body|show_media }}
     </div>

</div>

{% endblock %}
