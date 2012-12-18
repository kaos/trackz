{% if id %}
    <span class="share-button">
        <a id="{{ #share }}" href="#" title="{_ Share this page _}">
            <i class="icon-share"></i> {_ Share _}
        </a>
    </span>
    {% wire
        id=#share
        action={dialog_open
            title=_"Share this page"
            template="_dialog_share_page.tpl"
            id=id
        }
    %}
{% endif %}
