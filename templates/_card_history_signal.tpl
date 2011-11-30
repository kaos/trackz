{% with m.signal[signal] as sig %}
  {% include "_card_history_entry.tpl" event=sig.event|element:1 props=sig.event|element:2 %}
{% endwith %}
