<p>
{{ id.body|show_media }}
</p>

<div class="ui-widget">
     <div class="ui-widget-header">Project Members</div>
     <div class="ui-widget-content">
       <ul>
         {% for member in id.o.project_member %}
           <li>{{ member.title }}</li>
         {% endfor %}
       </ul>
     </div>
</div>
