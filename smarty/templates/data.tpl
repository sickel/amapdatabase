{include file='header.tpl' title='Timeregistrering'}
<div id="content">
<ul>
{foreach from=$tables key=k item=v}
<li>
<a href="data.php?table={$k}">{$v}</a>
</li>
{/foreach}
</ul>
|<a href="data.php">table list</a>
|<a href="index.php">Main menu</a>
|</div>
</body>
</html>
