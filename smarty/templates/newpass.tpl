{include file='header.tpl' title='Prosjekter'}

<!-- 
$Id$
-->

<div id="content">
{$passworderr}

<form action="index.php" method="post">
<p><label for="name">Old password : </label>
<input type="password" name="oldpassword" class="textfield" id="oldpassword" /><br />
<p><label for="name">New password: </label>
<input type="password" name="password1" class="textfield" id="password1" /><br />
<p><label for="name">Repeat new password: </label>
<input type="password" name="password2" class="textfield" id="password2" /><br />
<br />

<input type="submit" value="Set new password" name="SavePass" id="SavePass" class="submit" />
</p>
</form>
<hr />
<ul class="horizmenu">
<li><a href="index.php">Main menu</a></li>
</ul>

</div>
</body>
</html>
