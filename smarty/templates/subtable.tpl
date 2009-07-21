<p>
<!-- subtable.tpl-->
<h2>{$subtable}</h2>
<table border="single">
{section name=mysec loop=$sub}
{strip}
	<tr><td><a href="data.php?table={$subtable}&amp;id={$sub[mysec].id}"> {$sub[mysec].id}</a></td>
	{foreach from=$sub[mysec] key=k item=value}
		{if ($k!='id') and ($k!=$tableid) and ($k!='addtime') and ($k!='username')}
		<td>{$value}</td>
		{/if}
	{/foreach}
	</tr>
{/strip}
{/section}
</table>
<a href="{$smarty.server.SCRIPT_NAME}?table={$subtable}&amp;id=0&amp;val_{$table}id={$p[0].Value}">Add</a>
</p>

