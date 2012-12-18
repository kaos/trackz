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
                        action={postback
                            delegate="trackz"
                            postback={setup_project id}
                            inject_args
                        }
                        action={insert_top
                            target="projects"
                            template="_project_list_entry.tpl"
                        }
                        action={hide target="no-projects-notice"}
                    }
                %}

            </h3>

            <div>
                <ul id="projects">
                    {% for p in id.o.rbac_role_member %}
                        {% include "_project_list_entry.tpl"
                            role=p
                            id=p.s.rbac_domain_role|first
                        %}
                    {% empty %}
                        <div id="no-projects-notice" class="alert alert-info">
                            You are not a member of any projects.
                        </div>
                    {% endfor %}
                </ul>
            </div>
        </p>

    {% endwith %}

{% endblock %}
