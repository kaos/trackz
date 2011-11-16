{% if m.acl.user %}
   {% wire action={update target="navigation > li > a.my_profile" template="_my_profile_menuitem.tpl" id=m.acl.user} %}
   {% if m.acl.is_admin %}
      <li><a href="{% url admin %}" title="Administator's Dashboard">Go to Admin's dashboard</a></li>
   {% endif %}
{% else %}
   <li><a href="{{ m.rsc.login.page_url }}">{{ m.rsc.login.short_title|default:m.rsc.login.title }}</a></li>
{% endif %}
