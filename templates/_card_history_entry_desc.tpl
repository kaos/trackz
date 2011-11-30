<div>
  {{ event }} <b>{{ prop }}</b> to <b{% if value|length > 50 %} title="{{ value }}"{% endif %}>{{ value|truncate:50 }}</b>.
</div>
