<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>{% block title %}{{ m.rsc[id].seo_title | default: m.rsc[id].title }}{% endblock %} &mdash; Trackz</title>

	<link rel="icon" href="/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
	
	<meta name="author" content="Andreas Stenius <git@astekk.se>" />

	{% all include "_html_head.tpl" %}

	{% lib
           "bootstrap/css/bootstrap.css"
           "css/zp-project.css"
           "css/jquery.loadmask.css" 
	%}

	{% include "_trackz_js_include.tpl" %}

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

	{% block html_head_extra %}{% endblock %}
</head>

<body class="{% block page_class %}{% endblock %}">

    
      {% block menu %}
      <section>
         <nav class="navbar navbar-fixed-top">
              <div class="navbar-inner">
                   <div class="container">
                   {% menu id=id class="nav" %}
                   </div>
              </div>
         </nav>
      </section>
      {% endblock %}
    
    <section class="container">

        {% block content_area %}
	   {% block main %}{% endblock %}
	   {% block sidebar %}{% endblock %}
	{% endblock %}

        {% block subnavbar %}{% endblock %}

        <footer>
            {% include "_footer.tpl" %}
        </footer>

    </section>

    {% stream %}
    {% script %}

</body>
</html>
