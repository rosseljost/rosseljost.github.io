---
title: Blog
---

{{ global.index.navbar }}

{% do global.update({'flat_posts':[]}) %}

{% for k, v in global.posts.items() %}
    {% do global['flat_posts'].append(dict(filename=k, **v)) %}
{% endfor %}

{% for year_group in global.flat_posts|groupby('category')|sort(True) %}

:::blogsection-year
# {{ year_group.grouper }}
:::

{% for post in year_group.list|sort(attribute='date',reverse=True) %}
{% if post.externalLink %}
<a class="blogpost" target="_blank" href="{{post.externalLink}}">
{% else %}
<a class="blogpost" href="/posts/{{post.filename}}.html">
{% endif %}
<p class="blogpost-title">{% if post.externalLink %}<span class="blogpost-metadata"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="1em" height="1em"><!--! Font Awesome Pro 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M320 0c-17.7 0-32 14.3-32 32s14.3 32 32 32h82.7L201.4 265.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L448 109.3V192c0 17.7 14.3 32 32 32s32-14.3 32-32V32c0-17.7-14.3-32-32-32H320zM80 32C35.8 32 0 67.8 0 112V432c0 44.2 35.8 80 80 80H400c44.2 0 80-35.8 80-80V320c0-17.7-14.3-32-32-32s-32 14.3-32 32V432c0 8.8-7.2 16-16 16H80c-8.8 0-16-7.2-16-16V112c0-8.8 7.2-16 16-16H192c17.7 0 32-14.3 32-32s-14.3-32-32-32H80z" fill="black"/></svg>&nbsp;&nbsp;</span>{% endif %}{{post.title}}</p>
{% if post.subtitle %}<p class="blogpost-subtitle">{{post.subtitle}}</p>{% endif %}
<p class="blogpost-metadata">{{post.date}}</p>
</a>
{% endfor %}
{% endfor %}
