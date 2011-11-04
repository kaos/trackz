<div class="ui-widget column left">
    <div class="ui-widget-header">
         {{ id.title }}
         <a id="{{ #add_card }}" class="right ui-icon ui-icon-plus" href=#></a>
         {% wire id=#add_card
            action={dialog_open title="Add card to: "|append:id.title
                           template="_dialog_add_card.tpl" 
                           target=#column.cards
                           project=project
                           column=id
            }
         %}
    </div>
    <div id="{{ #column.id }}" class="ui-widget-content">
         {% for card in id.s.card_column %}
            {% include "_card.tpl" id=card %}
         {% endfor %}
    </div>
</div>
