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
      <p>
        {{ event }} <b>{{ prop }}</b> to <b>{{ value|truncate:50 }}</b>.
      </p>
    {% endif %}
  {% endfor %}
</li>
