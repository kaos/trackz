{% if m.acl.is_admin %}
<small><a href="{% url admin_edit_rsc id=id %}">Edit in admin</a></small>
{% endif %}
<form id="rscform" method="post" action="postback">
   <input type="hidden" name="id" value="{{ id }}" />
   <fieldset>
        <div>
                <label for="title">Card title</label>
                <input type="text" id="title" name="title" value="{{ id.title }}" />
                {% validate id="title" type={presence} %}
        </div>

        <div>
                <label for="summary">Summary</label>
                <input type="text" id="summary" name="summary" value="{{ id.summary }}" />
        </div>

        <div>
                <label for="body">Description</label>
                <textarea rows="10" cols="70" id="body" name="body" class="body tinymce-init">{{ id.body|escape }}</textarea>
        </div>

        <div>
                {% button text="Save" %}
        </div>
   </fieldset>
</form>

{% wire id="rscform" type="submit" postback="rscform" delegate="resource_admin_edit" %}
{% script %}
