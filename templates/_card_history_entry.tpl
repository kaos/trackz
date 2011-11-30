<li>
  <span title="{{ props.timestamp }}">
    {{ props.timestamp|timesince }}
  </span> 
  by 
  <a href="{{ props.by.page_url }}" title="{{ props.by.title }}">
    {{ props.by.short_title|default:props.by.title }}
  </a>

  {% if event == `insert` %}
    <p>created.</p>
  {% endif %}

  {% for prop, value in props %}
    {% if not prop|member:[`version`, `by`, `timestamp`] %}
      {% if event == `move` %}
        {% include "_card_history_entry_desc.tpl" event="moved" prop="" value=value.title %}
      {% else %}
        {% include "_card_history_entry_desc.tpl" event="updated" prop=prop value=value %}
      {% endif %}
    {% endif %}
  {% endfor %}
</li>
