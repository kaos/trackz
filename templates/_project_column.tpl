<div class="ui-widget column left {{ column_class }}">
    <div class="ui-widget-header {{ column_header_class }} {% if first_col %}ui-corner-tl{% endif %} {% if last_col %}ui-corner-tr{% endif %}">
         {{ id.title }} 
         <small id="{{ #column_card_count.id }}">
                {% include "_project_column_card_count.tpl" id=id %}
         </small>
         <span class="right ui-state-default ui-corner-all" title="{{ "Add card to: "|append:id.title }}" >
           <a id="{{ #add_card }}" class="ui-icon ui-icon-plus" href=#></a>
         </span>
         <a id="{{ #column_collapse_all.id }}" class="right ui-icon ui-icon-triangle-1-n" href=# title="Collapse all cards in this column"></a>
         <a id="{{ #column_expand_all.id }}" class="right ui-icon ui-icon-triangle-1-s" href=# title="Expand all cards in this column"></a>
    </div>

    <div id="{{ #column.id }}" class="column-sorter ui-widget-content {{ column_content_class }} {% if first_col %}ui-corner-bl{% endif %} {% if last_col %}ui-corner-br{% endif %}">
         {% for card in id.o.column_card %}
            {% include "_card.tpl" id=card %}
         {% endfor %}
    </div>
</div>

{% wire id=#add_card
   action={dialog_open title="Add card to: "|append:id.title
                       template="_dialog_add_card.tpl" 
                       target=#column.id
                       project=project
                       column=id
   }
%}

{% sorter id=#column.id
          handle=".card-icon"
          group="columns"
          opacity="0.6"
          delegate="trackz"
          tag={card_sorter id=id project=project}
          placeholder="ui-state-highlight"
%}

{# expand/collapse actions #}
{% wire id=#column_collapse_all.id 
        action={script script=["$('#", #column.id, " .collapse').click()"]|join}
%}
{% wire id=#column_expand_all.id 
        action={script script=["$('#", #column.id, " .expand').click()"]|join}
%}

{% wire action={connect signal={card_changed column=id} action={update target=#column_card_count.id template="_project_column_card_count.tpl" id=id}} %}
