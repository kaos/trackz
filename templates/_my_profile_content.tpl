<h2>{{ id.title }}{% if id.short_title %} ({{ id.short_title }}){% endif %}</h2>

{% if target %}
  {% wire id="edit-link" type="click" action={update target=target template="_edit_my_profile.tpl" id=id} %}
  <a id="edit-link" href=# title="Edit profile">Edit</a>
{% endif %}

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


