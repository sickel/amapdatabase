{include file='header.tpl' title='Timeregistrering'}
<!-- report00.tpl-->
<ul class="horizmenu">
<li><a href="{$smarty.server.SCRIPT_NAME}">New report</a></li>
<li><a href="index.php">Main menu</a></li>
</ul>

<h2>{$table}</h2>
<form action="" method="get">
<p><span class="label">Nuclides : </span>
{html_options name=nuclideid[] id="nuclideid" options=$nucs multiple="multiple"}
<span class="label">Sources :</span>
{html_options name=sourceid[] id="sourceid" options=$srcs multiple="multiple"}<br />
<span class="label">Unit :</span>
{html_options name="unitid" id="unitid" options=$units}
<br />
Mode:
Crosstab <input type="radio" name="mode" value="crosstab" /> |
download <input type="radio" name="mode" value="download" /> |
report <input type="radio" name="mode" value="normal" /> |
graph <input type="radio" name="mode" value="graph" /> |
<br />
<input type="submit" name="report" value="Report" /> <input type="reset" />
</p></form>
</body>
</html>
