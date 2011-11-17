{% extends "base.tpl" %}

{% block content %}
  <div id="content" class="left">
    {% include "_my_profile_content.tpl" id=m.acl.user target="content" %}
  </div>
{% endblock %}
