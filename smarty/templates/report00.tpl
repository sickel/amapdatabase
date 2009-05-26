{include file='header.tpl' title='Timeregistrering'}
<!-- report00.tpl-->
<h2>{$header}</h2>
<div id="content">
<ul class="horizmenu">
	<li><a href="{$smarty.server.SCRIPT_NAME}">New report</a></li>
	{if $graphquery}
		<li><a href="{$smarty.server.SCRIPT_NAME}?{$graphquery}">Graph</a></li>
	{/if}
</ul>
<table border="single">
<tr>
{section name=mysec loop=$tablehead}
{strip}
	<th>{$tablehead[mysec]}</th>
{/strip}
{/section}
</tr>
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
</div></body>
</html>
