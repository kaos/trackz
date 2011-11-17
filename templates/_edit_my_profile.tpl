<p>
  Edit {{ id.title }}'s profile here...<br />
  Target: {{ target }}<br />
  Id: {{ id }}
</p>

{% if target %}
  {% wire id="view-link" type="click" action={update target=target template="_my_profile_content.tpl" id=id} %}
  <a id="view-link" href=# title="View profile">View</a>
{% endif %}

