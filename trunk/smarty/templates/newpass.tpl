{include file='header.tpl' title='Prosjekter'}
<div id="content">
{$passworderr}

<form action="index.php" method="post">
<p><label for="name">Gammelt passord: </label>
<input type="password" name="oldpassword" class="textfield" id="oldpassword" /><br />
<p><label for="name">Nytt passord: </label>
<input type="password" name="password1" class="textfield" id="password1" /><br />
<p><label for="name">Gjenta nytt passord: </label>
<input type="password" name="password2" class="textfield" id="password2" /><br />

<br />

<input type="submit" value="Nytt passord" name="SavePass" id="SavePass" class="submit" />
</p>
</form>
</div>
</body>
</html>
