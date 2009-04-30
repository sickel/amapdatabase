{include file='header.tpl' title='Timeregistrering'}
<p>
<!-- report00.tpl-->
<h2>{$table}</h2>
<table border="single">
{section name=mysec loop=$p}
{strip}
	<tr><td><a href="data.php?table={$table}&amp;id={$p[mysec].id}"> {$p[mysec].id}</a></td>
	{foreach from=$p[mysec] key=k item=value}
		{if ($k!='id') and ($k!=$tableid)}
		<td>{$value}</td>
		{/if}
	{/foreach}
	</tr>
{/strip}
{/section}
</table>
<a href="{$smarty.server.SCRIPT_NAME}?table={$ptable}&amp;id=0&amp;val_{$table}id={$p[0].Value}">Add</a>
</p>

