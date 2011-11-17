<h1>Edit {{ m.rsc["my_profile"].title }}</h1>

<h2>{{ id.title }}{% if id.short_title %} ({{ id.short_title }}){% endif %}</h2>

{% if target %}
   {% include "_icon.tpl" id=#view.id caption="View profile" icon="person" action=[{hide target=target}, {update target=target appear template="_my_profile_content.tpl" id=id}] %}
{% endif %}

<div class="ui-widget">
     <div class="ui-widget-header ui-corner-top">
          Profile Details
     </div>
     <div class="ui-widget-content">
     
<p>
  Edit {{ id.title }}'s profile here...<br />
  Target: {{ target }}<br />
  Id: {{ id }}
</p>

     </div>
</div>



