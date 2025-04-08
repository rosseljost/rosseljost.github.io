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
<p class="blogpost-metadata">
    {%- if pub.pdf %}<a href="{{pub.pdf}}" target="_blank">&nbsp;&nbsp;PDF&nbsp;&nbsp;</a>&nbsp;&nbsp;&nbsp;{% endif -%}
    {%- if pub.publisherUrl %}<a href="{{pub.publisherUrl}}" target="_blank">&nbsp;@ Publisher&nbsp;&nbsp;</a>&nbsp;&nbsp;&nbsp;{% endif -%}
    {%- if pub.doi %}<a href="https://doi.org/{{pub.doi}}" target="_blank">&nbsp;&nbsp;DOI&nbsp;&nbsp;</a>&nbsp;&nbsp;&nbsp;{% endif -%}
</p>
{% if pub.abstract %}
<details class="abstract">
    <summary>Abstract</summary>
    <p>{{ pub.abstract }}</p>
</details>
{% endif %}
</div>
{% endfor %}