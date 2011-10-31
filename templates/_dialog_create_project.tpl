{% wire 
   id=#form 
   type="submit" 
   postback={create_project 
      action={growl text="Created new project" } 
      action={insert_bottom target=target template="_project_list_entry.tpl" id=id }
   } 
   delegate="trackz" 
   action={dialog_close} 
%}
<form id="{{ #form }}" method="post" action="postback"> 
  <div class="form-item">
    <label for="title">{_ Project Title _}</label>
    <input id="title" type="text" name="title" />
    {% validate id="title" type={presence} %}
  </div>
  <div class="right">
    {% button text=_"Create Project" %}
    {% button text=_"Cancel" action={dialog_close} %}
  </div>
</form>
