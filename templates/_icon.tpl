<span id="{{ id }}" class="{{ class }} trackz-icon ui-corner-all" title="{{ title }}">
{% if href or action %}
      <a class="ui-icon ui-icon-{{ icon }}" href="{{ href|default:"#" }}"></a>
{% else %}
      <span class="ui-icon ui-icon-{{ icon }}"></span>
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
