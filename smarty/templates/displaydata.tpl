{include file='header.tpl'}
<div id="content">
<form action="{$smarty.server.SCRIPT_NAME}" method="post">
<h1>{$tablename}</h1>
<p>
<!-- displaydata.tpl-->
	<input type="hidden" id="table" name="table" value="{$table}" />
	<input type="hidden" id="username" name="username" value="{$name}" />
{section name=mysec loop=$p}
{strip}
	<label for="{$p[mysec].Field}">{$p[mysec].Label|ucfirst} :</label>
	{if $p[mysec].Type eq 'int(11)'}
		{assign var='class' value=" integer numeric"}
	{else}
		{assign var='class' value=""}
	{/if}
	{if $p[mysec].Type eq 'text'}
		<textarea id="{$p[mysec].Field}" name="{$p[mysec].Field}" cols="43">{$p[mysec].Value}</textarea>
		<br />
	{elseif $p[mysec].Type eq 'tinyint(1)'}
		{if $p[mysec].Value eq 1}
			{assign var='chk' value=' checked="checked"'}
		{/if}
		<input type="checkbox" id="{$p[mysec].Field}" name="{$p[mysec].Field}"{$chk}><br />
	{else}
		<input type="text" name="{$p[mysec].Field}" class="textfield{$class}" id="{$p[mysec].Field}" value="{$p[mysec].Value}" size="{$p[mysec].length}"/>
		{if $p[mysec].main !=''}
			<a href="{$smarty.server.SCRIPT_NAME}?table={$p[mysec].main}&id={$p[mysec].Value}">=></a>
		{/if}	
		<br />
	{/if}
{/strip}
{/section}
{if $mode}
	{assign var='submittext' value=$mode|ucfirst}
{else}
	{assign var='submittext' value="Store"}
{/if}
{if $last}
	<p>Last update {$last}</p>
{/if}
	<input type="submit" name="submitdata" value="{$submittext}" />
</p>
</form>
{if $b}
<ul class="horizmenu">
	<li> <a href="/AMAP/datasenter/data.php?table={$b.first}"><<-</a> </li>
	<li> <a href="/AMAP/datasenter/data.php?table={$b.prev}"><-</a> </li>
	<li> <a href="/AMAP/datasenter/data.php?table={$b.next}">-></a> </li>
	<li> <a href="/AMAP/datasenter/data.php?table={$b.last}">->></a> </li>
	<li> <a href="/AMAP/datasenter/data.php?table={$b.list}&mode=list">List</a> </li>
	<li> <a href="/AMAP/datasenter/data.php?table={$table}&amp;id=0">Add</a></li>
	<li> <a href="/AMAP/datasenter/data.php?table={$table}&amp;mode=search">Search</a> </li>
</ul>
{/if}
<ul class="nodot">
{foreach from=$subtablelist key=label item=subtab}
<li>
<label>{$label|ucfirst}</label><ul class="horizmenu">
	<li><a href="data.php?table={$subtab}">browse</a></li>
	<li><a href="data.php?table={$table}&amp;subtab={$subtab}&amp;id={$id}">subtable</a></li>
	</ul>
</li>
{/foreach}
</ul>
{if $subtable}
	{include file='subtable.tpl'}
{/if}	
<br /><hr/>
<ul class="horizmenu">
<li><a href="{$smarty.server.SCRIPT_NAME}">table list</a></li>
<li><a href="index.php">Main menu</a></li>
</ul>
</div>
</body>
</html>
