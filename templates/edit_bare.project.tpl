<form id="rscform" method="post" action="postback">
   <input type="hidden" name="id" value="{{ id }}" />
   <fieldset>
        <div>
                <label for="title">Project name</label>
                <input type="text" id="title" name="title" value="{{ id.title }}" />
        </div>

        <div>
                {% button text="Save" %}
        </div>
   </fieldset>
</form>

{% wire id="rscform" type="submit" postback="rscform" delegate="resource_admin_edit" %}
{% script %}
