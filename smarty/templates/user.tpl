{include file='header.tpl' title='Brukerregistrering'}
<div id="content">
<form action="user.php" method="post"><p>
<input type="hidden" value="{$id}" id="id" name="id" />
<label for="name">Brukernavn : </label>
<input type="text" name="username" class="textfield" id="username" value="{$username}" /><br />

<label for="name">Navn : </label>
<input type="text" name="name" class="textfield" id="name" value="{$name}" /><br />
<label for="pass1">Passord : </label>
<input type="password" name="pass1" id="pass1" class="textfield" /><br />
<label for="pass2">Gjenta passord : </label>
<input type="password" name="pass2" id="pass2" class="textfield" /><br />
<label for="email">Epost : </label>
<input type="text" name="email" class="textfield" id="email" value="{$email}" /><br />
<label for="email">Ukeverk (År): </label> 
<input type="text" name="weeks" class="textfield" id="weeks" value="{$weeks}" size="4" />
<input type="text" name="year" class="textfield" id="year" value="{$year}" size="4" /><br />
<input type="submit" value="<-" name="prev" id="prev" class="submit" />
<input type="submit" value="Lagre" name="Save" id="Save" class="submit" />
<input type="submit" value="->" name="next" id="next" class="submit" />
</p>
</form>
</div>
</body>
</html>
