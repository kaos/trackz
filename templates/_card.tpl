{% with object_id as id %}
{% sortable id=#card.id tag=id %}
<div id="{{ #card.id }}" class="card ui-widget">
     <div class="ui-widget-content ui-corner-all">  
          {# Header #}
          {% include "_icon.tpl" id=#drag_icon.id class="card-icon" icon="arrow-4" title="Drag and drop this card to sort it within this column, or move it to another column" %}
           <a id="{{ #card_title.id }}" class="card-title ui-priority-primary" href=# title="{{ id.short_title }}">
               <small class="ui-priority-secondary" title="version {{ id.version }}">#{{ id }}</small>
               {{ id.title }}
           </a>

          {% include "_icon.tpl"
             id=#goto_card.id
             class="right"
             icon="newwin"
             title="Go to card #"|append:id
             href=id.page_url
          %}

          {% include "_icon.tpl"
             id=#card_collapse.id
             class="right collapse"
             title="Collapse this card"
             icon="triangle-1-n"
             action=[
                 {slide_up target=#card_details.id},
                 {hide target=#card_collapse.id},
                 {show target=#card_expand.id}]
          %}

          {% include "_icon.tpl"
             id=#card_expand.id
             class="right expand"
             title="Expand this card"
             icon="triangle-1-s"
             action=[
                 {slide_down target=#card_details.id},
                 {hide target=#card_expand.id},
                 {show target=#card_collapse.id}]
          %}

          {# Body #}
          <div id="{{ #card_details.id }}">
               <hr />
               <small class="ui-priority-secondary" title="Created {{ id.created|timesince }}">
                      Created by {{ id.creator_id.title }}
               </small>
               <p>
                      {{ id.summary }}
               </p>

               <div class="ui-widget-header ui-priority-secondary ui-corner-top">
                 History
               </div>
               <div class="ui-widget-content ui-corner-bottom">
                 <ul id="{{ #card_history.id }}">
                    {% for entry in m.tkvstore.card_history[id] %}
                      {% include "_card_history_entry.tpl" event=entry|element:1 props=entry|element:2 %}
                    {% empty %}
                       No history
                    {% endfor %}
                 </ul>
               </div>
          </div>
     </div>
</div>

{% wire action={connect signal={card_history card=id} action={insert_top target=#card_history.id template="_card_history_signal.tpl"}} %}

{% endwith %}
