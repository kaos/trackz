<div class="history-entry-desc">
  <small>{{ event }}{% if prop %} <b>{{ prop }}</b>{% endif %}{% if value %} to <b{% if value|length > 50 %} title="{{ value }}"{% endif %}>{{ value|truncate:50 }}</b>{% endif %}.</small>
</div>
