{include file='header.tpl' title='Timeregistrering'}
<div id="content">
<ul class="nodot">
{foreach from=$m key=k item=v}
<li>
<a href="{$k}">{$v}</a>
</li>
{/foreach}
</ul>
<hr />
<ul class="horizmenu">
<li><a href="?newpass=1">New password</a></li>
</li><a href="?logout=1">Log out</a></li>
</ul></div>
</body>
</html>
