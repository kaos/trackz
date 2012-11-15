<h1>{{ m.rsc["profile"].title }}</h1>

<h2>{{ id.title }}{% if id.short_title %} ({{ id.short_title }}){% endif %}</h2>

{% if target %}
   {% include "_icon.tpl" id=#edit.id caption="Edit profile" icon="pencil" action=[{hide target=target}, {update target=target appear template="_edit_profile.tpl" id=id}] %}
{% endif %}

<div class="ui-helper-clearfix">
     <p class="summary">{{ id.summary }}</p>

{% if id.body %}
  <h3>Presentation</h3>
  {{ id.body|show_media }}
{% endif %}

<h3>Your Projects</h3>
  <ul id="projects">
    {% for p in id.s.project_member %}
      {% include "_project_list_entry.tpl" id=p %}
    {% empty %}
       You are not a member of any projects.
    {% endfor %}
  </ul>

</div>

