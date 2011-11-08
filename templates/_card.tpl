{% sortable id=#card.id tag=id %}
<div id="{{ #card.id }}" class="card ui-widget">
     <div class="ui-widget-content ui-corner-all">  
          {# Header #}
          <span class="card-icon ui-icon ui-icon-arrow-4" title="Sort this card within this column, or move it to another column"></span>
          <a id="{{ #card_title.id }}" class="card-title ui-priority-primary" href=# title="{{ id.short_title }}">
             <small class="ui-priority-secondary" title="version {{ id.version }}">#{{ id }}</small>
             {{ id.title }}
          </a>
          <a class="right ui-icon ui-icon-newwin" href="{% url page id=id %}" title="Go to card page"></a>
          <a id="{{ #card_collapse.id }}" class="right ui-icon ui-icon-triangle-1-n collapse" href=# title="Collapse this card"></a>
          <a id="{{ #card_expand.id }}" class="right ui-icon ui-icon-triangle-1-s expand" href=# title="Expand this card"></a>

          {# Body #}
          <div id="{{ #card_details.id }}">
               <hr />
               <small class="ui-priority-secondary" title="Created {{ id.created|timesince }}">
                      Created by {{ id.creator_id.title }}
               </small>
               <p>
                      {{ id.summary }}
               </p>
               
               Some really nice details about this card goes here...
          </div>
     </div>
</div>

{# expand/collapse actions #}
{% wire id=#card_collapse.id 
        action={slide_up target=#card_details.id} 
        action={hide target=#card_collapse.id}
        action={show target=#card_expand.id}
%}
{% wire id=#card_expand.id 
        action={slide_down target=#card_details.id} 
        action={hide target=#card_expand.id}
        action={show target=#card_collapse.id}
%}

{# collapse cards by default #}
{% wire
        action={slide_up target=#card_details.id} 
        action={hide target=#card_collapse.id}
%}
