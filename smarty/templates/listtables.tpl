{include file='header.tpl' title='Timeregistrering'}
<div id="content">
<h1>Tables</h1>
<ul class="vertmenu">
{foreach from=$tables key=k item=v}
<li>
<a href="data.php?table={$k}&mode=list">{$v}</a>
</li>
{/foreach}
</ul>
<hr />
<ul class="horizmenu">
<li><a href="data.php">table list</a></li>
<li><a href="index.php">Main menu</a></li>
</ul></div>
</body>
</html>
