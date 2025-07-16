---
title: Publications
---

{{ global.index.navbar }}

{% for pub in static.publications.publications|sort(attribute='date',reverse=True) %}
<div class="blogpost">
<p class="blogpost-title">{{pub.title}}</p>
<p class="blogpost-subtitle">
{%- for author in pub.author -%}
<span {% if author.given == 'Jost' and author.family == 'Rossel' %}{% else %}class="author-other"{% endif %}>{{author.given}} {{author.family}}{% if not loop.last %}, {% endif %}</span>
{%- endfor -%}
</p>
<p class="blogpost-metadata">{{pub.type}}{% if pub.event %} @ {{pub.event}}{% endif %}</p>
{% if pub.links %}
<p class="blogpost-metadata">
    {%- for title, link in pub.links.items() -%}
    <a class="publink" href="{{link}}" target="_blank">{{title}}</a>
    {%- endfor -%}
</p>
{% endif %}
{% if pub.abstract %}
<details class="abstract">
    <summary>Abstract</summary>
    <p>{{ pub.abstract }}</p>
</details>
{% endif %}
</div>
{% endfor %}