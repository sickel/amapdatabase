{include file='header.tpl' title='Timeregistrering'}
<!-- report00.tpl-->
<p><a href="{$smarty.server.SCRIPT_NAME}">New report</a> <a href="index.php">Main menu</a></p>
<h2>{$table}</h2>
<form action="" method="get">
<p>Nuclides : 
{html_options name=nuclideid[] id="nuclideid" options=$nucs multiple="multiple"}
Sources :
{html_options name=sourceid[] id="sourceid" options=$srcs multiple="multiple"}
<br />
Mode:
Crosstab <input type="radio" name="mode" value="crosstab" /> |
download <input type="radio" name="mode" value="download" /> |
report <input type="radio" name="mode" value="normal" /> |
graph <input type="radio" name="mode" value="graph" /> |
<br />
<input type="submit" name="report" value="Report" />
</p></form>
</body>
</html>
