{% sortable id=#card.id tag=id %}
<div id="{{ #card.id }}" class="card ui-widget">
     <div class="ui-widget-content ui-corner-all">  
          <span class="card-icon ui-icon ui-icon-arrow-4" title="Sort this card within this column, or move it to another column"></span>
          <a id="{{ #card_title.id }}" class="card-title ui-priority-primary" href=# title="{{ id.short_title }}"><small class="ui-priority-secondary">#{{ id }}</small> {{ id.title }}</a>
          <a class="right ui-icon ui-icon-newwin" href="{% url page id=id %}" title="Go to card page"></a>
          <hr />
          <small class="ui-priority-secondary" title="Created {{ id.created|timesince }}">Created by {{ id.creator_id.title }}</small>
          <p>{{ id.summary }}</p>
     </div>
</div>

<div id="{{ #card_details.id }}" class="ui-helper-hidden">
     Some really nice details about this card goes here...
</div>