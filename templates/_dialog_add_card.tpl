{% wire 
   id=#form 
   type="submit" 
   postback={add_card
      action={insert_top target=target template="_card.tpl" }
   }
   delegate="trackz" 
   action={dialog_close} 
%}
<form id="{{ #form }}" method="post" action="postback"> 
  <input type="hidden" name="column" value="{{ column }}" />
  <div class="form-item">
    <label for="title">{_ Card Title _}</label>
    <input id="title" type="text" name="title" />
    {% validate id="title" type={presence} %}
  </div>
  <div class="right">
    {% button text=_"Add Card" %}
    {% button text=_"Cancel" action={dialog_close} %}
  </div>
</form>
