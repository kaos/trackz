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
		"css/zp-project.css"
		"css/jquery.loadmask.css" 
	%}

		<!-- "css/zp-menu.css" -->

	<!--[if IE]>
	{% lib	"css/zp-ie.css" %}
	<![endif]-->
	
	<!-- Make ie understand html5 -->
	{ % lib "js/apps/modernizr.js" % }

	{% block html_head_extra %}{% endblock %}
</head>

<body class="{% block page_class %}{% endblock %}">

	<section class="skip">
		<a href="#content-area" title="Go directly to page content">Go to page content</a>
	</section>

	<section class="zp-wrapper">
		<header class="clearfix">
			{#
			<figure id="logo" class="left">
				<a href="/" title="Home"><img src="/lib/images/logo.jpg" alt="Zotonic &mdash; Simple stuff that works" /></a>
			</figure>
			#}
			
			<nav class="right">
                          {% block menu %}
				{% menu id=id class="list" %}
                          {% endblock %}
			</nav>
		</header>

		{% block banner %}{% endblock %}
		
		<section id="content-area" class="clear clearfix">
		{% block content_area %}
			{% block content %}{% endblock %}
			{% block sidebar %}{% endblock %}
		{% endblock %}
		</section>

		<div class="push"><!-- push down --></div>
	</section>
	
	<footer>
		{% include "_footer.tpl" %}
	</footer>

	{% include "_trackz_js_include.tpl" %}

	{% script %}

</body>
</html>
