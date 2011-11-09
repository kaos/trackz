<span id="{{ id }}" class="{{ class }} trackz-icon ui-corner-all" title="{{ title }}">
      <a class="ui-icon ui-icon-{{ icon }}" href="{{ href|default:"#" }}"></a>
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
