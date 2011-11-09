{% sortable id=#card.id tag=id %}
<div id="{{ #card.id }}" class="card ui-widget">
     <div class="ui-widget-content ui-corner-all">  
          {# Header #}
          <span class="card-icon ui-icon ui-icon-arrow-4" title="Sort this card within this column, or move it to another column"></span>
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
               
               Some really nice details about this card goes here...
          </div>
     </div>
</div>

{# collapse cards by default #}
{% wire
        action={slide_up target=#card_details.id} 
        action={hide target=#card_collapse.id}
%}
