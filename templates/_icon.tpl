<span id="{{ id }}" class="{{ class }} trackz-icon ui-corner-all" title="{{ title }}">
{% if caption %}
   {% if href or action %}
      <a class="ui-icon ui-icon-{{ icon }}" href="{{ href|default:"#" }}"></a>
      <a class="trackz-icon-caption" href="{{ href|default:"#" }}">{{ caption }}</a>
   {% else %}
      <span class="ui-icon ui-icon-{{ icon }}"></span>
      <span class="trackz-icon-caption">{{ caption }}</span>
   {% endif %}
{% else %}
   {% if href or action %}
      <a class="ui-icon ui-icon-{{ icon }}" href="{{ href|default:"#" }}"></a>
   {% else %}
      <span class="ui-icon ui-icon-{{ icon }}"></span>
   {% endif %}
{% endif %}
</span>

{% if action %}
   {% wire id=id
        type="click"
        action=action
   %}
{% endif %}

{% wire id=id
        type="mouseenter"
        action={add_class target=id class="ui-state-hover"}
%}

{% wire id=id
        type="mouseleave"
        action={remove_class target=id class="ui-state-hover"}
%}
