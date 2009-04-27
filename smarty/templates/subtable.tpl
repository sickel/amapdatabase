<p>
<!-- subtable.tpl-->
<h2>{$subtable}</h2>
<table border="single">
{section name=mysec loop=$sub}
{strip}
	<tr><td><a href="data.php?table={$subtable}&id={$sub[mysec].id}"> {$sub[mysec].id}</a></td>
	{foreach from=$sub[mysec] key=k item=value}
		{if ($k!='id') and ($k!=$tableid)}
		<td>{$value}</td>
		{/if}
	{/foreach}
	</tr>
{/strip}
{/section}
</table>
</p>

