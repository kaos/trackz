{% extends "base.tpl" %}

{% block content %}

{% if m.acl.view[id] %}
<h1>{{ id.title }}</h1>

<p class="summary">
    {{ id.summary }}
</p>

{% tabs id="tabs" %}
<div id="tabs">
     <ul>
        <li><a href="#cards">Cards</a></li>
        <li><a href="#info">Info</a></li>
        <li><a href="{% url edit_bare id=id %}">Edit</a></li>
     </ul>

     <div id="cards">
     <table class="columns">
            <tr>
                {% for col in id.o.project_column %}
                  {% if m.acl.view[col] %}
                   <td>
                   {% include "_project_column.tpl" 
                      project=id 
                      id=col 
                      first_col=forloop.first
                      last_col=forloop.last
                   %}
                   </td>
                  {% endif %}
                {% endfor %}
            </tr>
     </table>
     </div>

     <div id="info">
       {% include "_project_info.tpl" id=id %}
     </div>

</div>

{% else %}

<h1>You may not view this project... ({{ id.title }})</h1>

{% endif %}

{% endblock %}
