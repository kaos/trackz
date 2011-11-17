{% extends "base.tpl" %}

{% block content %}

  <h1>{{ m.rsc[id].title }}</h1>

  <div id="content">
    {% include "_my_profile_content.tpl" id=m.acl.user target="content" %}
  </div>

{% endblock %}
