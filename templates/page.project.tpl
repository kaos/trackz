{% extends "base.tpl" %}

{% block content %}

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
                   <td>
                   {% include "_project_column.tpl" 
                      project=id 
                      id=col 
                      first_col=forloop.first
                      last_col=forloop.last
                   %}
                   </td>
                {% endfor %}
            </tr>
     </table>
     </div>

     <div id="info">
       {% include "_project_info.tpl" id=id %}
     </div>

</div>

{% endblock %}
