{% if m.acl.is_admin %}
<small><a href="{% url admin_edit_rsc id=id %}">Edit in admin</a></small>
<small>{% include "_edit_link.tpl" id=id %}</small>
{% endif %}

{% wire id="rscform" type="submit" postback="rscform" delegate="resource_admin_edit" %}
<form id="rscform" method="post" action="postback">
<input type="hidden" name="id" value="{{ id }}" />
   <div class="ui-widget">
      <div class="ui-widget-header ui-corner-top">
         Project Info
      </div>

      <div class="ui-widget-content">
         <div>
                <label for="{{ #title.id }}">Project name</label>
                <input type="text" id="{{ #title.id }}" name="title" value="{{ id.title }}" />
                {% validate id=#title.id name="title" type={presence} %}
         </div>

         <div>
                <label for="summary">Summary</label>
                <input type="text" id="summary" name="summary" value="{{ id.summary }}" />
         </div>

         <div>
                <label for="body">Description</label>
                <textarea rows="10" cols="70" id="body" name="body" class="body">{{ id.body|escape }}</textarea>
         </div>

         <div class="ui-helper-clearfix">
                {% button text="Save" %}
         </div>
      </div>
   </div>
</form>


<div class="ui-widget" style="margin-top: .5em">
   <div class="ui-widget-header">
      Columns
   </div>

   <div class="ui-widget-content ui-corner-bottom">

      <div id="links-{{ id }}-project_column">
        {% for col in id.o.project_column %}
           {% include "_col_list.tpl" object_id=col %}
        {% endfor %}
      </div>

      <div class="ui-helper-clearfix">
         {% button text="Add column" 
            action={dialog_new_rsc
                        cat="column"
                        nocatselect=1
                        redirect=0
                        subject_id=id
                        predicate="project_column"
                        edge_template="_col_list.tpl"
                        }
         %}
      </div>
   </div>
</div>


{% if not noscript %}
   {% script %}
{% endif %}
