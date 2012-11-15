{% extends "page.tpl" %}

{% block below_body %}

{% with m.acl.user as id %}
  <p>
    <h3>
      Your Projects

      {% button text=_"Create a new Project" 
         class="btn btn-mini pull-right"
         action={dialog_new_rsc
                        cat="project"
                        nocatselect=1
                        redirect=0
                        action={with_args
                                action={link
                                        predicate="rbac_role_member"
                                        object_id=id
                                        element_id="projects"
                                        edge_template="_project_list_entry.tpl"
                                }
                                arg={subject_id id}
                        }
         }
      %}
    </h3>

    <div>
       <ul id="projects">
           {% for p in id.s.project_member %}
              {% include "_project_list_entry.tpl" id=p %}
           {% empty %}
              <div class="alert alert-info">
                   You are not a member of any projects.
              </div>
           {% endfor %}
       </ul>
    </div>
  </p>   
{% endwith %}

{% endblock %}
