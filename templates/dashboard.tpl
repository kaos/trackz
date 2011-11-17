{% extends "base.tpl" %}

{% block content %}

<h1>{{ m.rsc[id].title }}</h1>
  
<p class="summary">
  {{ m.rsc[id].summary }}
</p>
  
{{ m.rsc[id].body|show_media }}

{% with m.acl.user as id %}
  <p>
    <h2>
        Your Projects
    </h2>

    <div class="ui-helper-clearfix">
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
    </div>
    <div>
       <ul id="projects">
           {% for p in id.s.project_member %}
              {% include "_project_list_entry.tpl" id=p %}
           {% empty %}
              You are not a member of any projects.
           {% endfor %}
       </ul>
    </div>
  </p>   
{% endwith %}

{% endblock %}
