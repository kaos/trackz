{% extends "base.tpl" %}

{% block content %}
  
  <h1>{{ id.title }}</h1>
  
  <p class="summary">
    {{ id.summary }}
  </p>
  
  {{ id.body|show_media }}
  
  <p>
    Is me: {{ id.is_me }}<br />
    
    {% if id.is_me %}
      {% button text=_"Create a new Project" action={dialog_open title=_"Project Title" template="_dialog_create_project.tpl"} %}
    {% endif %}
    <br />
  </p>  

  <p>
    <h2>Your Projects</h2>
    <p>
      {% for p in id.s.project_member %}
        <a href="{% url page id=p %}">{{ p.title }}</a><br />
        {% empty %}
        You are not a member of any projects.
      {% endfor %}
    </p>
  </p>   
{% endblock %}
