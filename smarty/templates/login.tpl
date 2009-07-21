{include file='header.tpl' title='Prosjekter'}
<!--
$Id$
-->
<div id="content">
{$logonerror}
<form action="{$action}" method="post">
<p><label for="name">Brukernavn: </label>
<input type="text" name="name" class="textfield" id="name" value="{$name}" /><br />
<p><label for="name">Passord: </label>
<input type="password" name="password" class="textfield" id="password" /><br />

<br />

<input type="submit" value="Logg inn" name="SaveProject" id="SaveProject" class="submit" />
</p>
</form>
</div>
</body>
</html>
