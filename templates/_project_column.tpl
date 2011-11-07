<div class="ui-widget column left {{ column_class }}">
    <div class="ui-widget-header {{ column_header_class }} {% if first_col %}ui-corner-tl{% endif %} {% if last_col %}ui-corner-tr{% endif %}">
         {{ id.title }}
         <span class="right ui-state-default ui-corner-all" title="{{ "Add card to: "|append:id.title }}" >
           <a id="{{ #add_card }}" class="ui-icon ui-icon-plus" href=#></a>
         </span>
         {% wire id=#add_card
            action={dialog_open title="Add card to: "|append:id.title
                           template="_dialog_add_card.tpl" 
                           target=#column.cards
                           project=project
                           column=id
            }
         %}
    </div>
    {% sorter id=#column.id handle=".card-icon" group="columns" opacity="0.6" delegate="trackz" tag={card_sorter id=id} %}
    <div id="{{ #column.id }}" class="ui-widget-content {{ column_content_class }} {% if first_col %}ui-corner-bl{% endif %} {% if last_col %}ui-corner-br{% endif %}">
         {% for card in id.o.column_card %}
            {% include "_card.tpl" id=card %}
         {% endfor %}
    </div>
</div>
