{include file='header.tpl' title='Timeregistrering'}
<div id="content">
<ul>
{foreach from=$m key=k item=v}
<li>
<a href="{$k}">{$v}</a>
</li>
{/foreach}
</ul>
|<a href="?newpass=1">New password</a>
|<a href="?logout=1">Log out</a>
|</div>
</body>
</html>
