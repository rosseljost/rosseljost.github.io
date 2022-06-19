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
<a class="blogpost" href="/posts/{{post.filename}}.html">
<p class="blogpost-title">{{post.title}}</p>
{% if post.subtitle %}<p class="blogpost-subtitle">{{post.subtitle}}</p>{% endif %}
<p class="blogpost-metadata">{{post.date}}</p>
</a> 
{% endfor %}
{% endfor %}
