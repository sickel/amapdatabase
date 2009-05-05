{include file='header.tpl'}
<div id="content">
<form action="{$smarty.server.SCRIPT_NAME}" method="post">
<h1>{$tablename}</h1>
<p>
<!-- displaydata.tpl-->
{section name=mysec loop=$p}
{strip}
	<input type="hidden" id="table" name="table" value="{$table}" />
	<input type="hidden" id="username" name="username" value="{$name}" />
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
	<input type="submit" name="submitdata" value="{$submittext}" />
</p>
</form>
<p>{$browse}</p>
{if $subtable}
	{include file='subtable.tpl'}
{/if}	
<hr/>
<ul class="horizmenu">
<li><a href="{$smarty.server.SCRIPT_NAME}">table list</a></li>
<li><a href="index.php">Main menu</a></li>
</ul>
</div>
</body>
</html>
