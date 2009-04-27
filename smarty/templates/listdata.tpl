{include file='header.tpl' title='Timeregistrering'}

<div id="content">
<h1>{$table}</h1>
<p>
{$browse}
</p>
<!-- listdata.tpl-->
{section name=mysec loop=$p}
{strip}
	<a href="data.php?table={$table}&id={$p[mysec].id}"> {$p[mysec].name}({$p[mysec].id})</a><br />
{/strip}
{/section}
</p>
<p>{$browse}</p>
<p>| <a href="data.php?table={$table}&id=0">Add</a> 
| <a href="data.php?table={$table}&mode=search">Search</a> |</p><hr />
| <a href="data.php">table list</a>
| <a href="index.php">Main menu</a>
|</div>
</body>
</html>
