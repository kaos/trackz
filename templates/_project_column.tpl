{% with ["links-", id, "-column_card"]|join as column_id %}
<div class="ui-widget column {{ column_class }}">
    <div class="ui-widget-header {{ column_header_class }} {% if first_col %}ui-corner-tl{% endif %} {% if last_col %}ui-corner-tr{% endif %}">
         {{ id.title }} 
         <small id="{{ #column_card_count.id }}">
                {% include "_project_column_card_count.tpl" id=id %}
         </small>

         {# column header icons, from right to left #}

         {% if m.acl.insert[id] %}
         {% include "_icon.tpl"
            id=#add_card.id
            class="right"
            title="Add new card to: "|append:id.title
            icon="plus"
            action={dialog_new_rsc
                        cat="card"
                        nocatselect=1
                        redirect=0
                        subject_id=id
                        predicate="column_card"
                        edge_template="_card.tpl"
            }
         %}
         {% endif %}

         {% include "_icon.tpl"
            id=#column_collapse_all.id
            class="right"
            title="Collapse all cards in this column"
            icon="triangle-1-n"
            action={script script=["$('#", column_id, " .collapse').click()"]|join}
         %}

         {% include "_icon.tpl"
            id=#column_expand_all.id
            class="right"
            title="Expand all cards in this column"
            icon="triangle-1-s"
            action={script script=["$('#", column_id, " .expand').click()"]|join}
         %}
    </div>

    <div id="{{ column_id }}" class="column-sorter ui-widget-content {{ column_content_class }} {% if first_col %}ui-corner-bl{% endif %} {% if last_col %}ui-corner-br{% endif %}">
         {% for card in id.o.column_card %}
            {% include "_card.tpl" object_id=card %}
         {% endfor %}
    </div>
</div>

{% if m.acl.update[id] %}
{% sorter id=column_id
          handle=".card-icon"
          group="columns"
          opacity="0.6"
          delegate="trackz"
          tag={card_sorter id=id project=project}
          placeholder="ui-state-highlight"
%}
{% endif %}

{% wire action={connect signal={card_changed column=id} action={update target=#column_card_count.id template="_project_column_card_count.tpl" id=id}} %}

{# collapse all cards by default #}
{% wire action={script script=["$('#", #column_collapse_all.id, "').click()"]|join} %}
{% endwith %}
