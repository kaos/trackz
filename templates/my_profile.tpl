{% extends "base.tpl" %}

{% block title %}My Profile{% endblock %}
{% block content %}

{% with m.acl.user as id %}
  <h1>My Profile</h1>
  
  <h2>{{ id.title }}</h2>
  <p class="summary">
    {{ id.summary }}
  </p>
  
  {{ id.body|show_media }}

  <p>
    {% if id.is_me %}
      {% button text=_"Create a new Project" 
         action={dialog_new_rsc
                        cat="project"
                        nocatselect=1
                        redirect=0
                        action={with_args
                                action={link
                                        predicate="project_member"
                                        object_id=id
                                        element_id="projects"
                                        edge_template="_project_list_entry.tpl"
                                }
                                arg={subject_id id}
                        }
         }
      %}
    {% endif %}
    <br />
  </p>  

  <p>
    <h2>Your Projects</h2>
    <ul id="projects">
      {% for p in id.s.project_member %}
        {% include "_project_list_entry.tpl" id=p %}
        {% empty %}
        You are not a member of any projects.
      {% endfor %}
    </ul>
  </p>   
{% endwith %}
{% endblock %}