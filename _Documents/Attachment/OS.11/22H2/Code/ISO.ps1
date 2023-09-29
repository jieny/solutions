$ISO = "D:\OS11"
$Volume = "OS11"
$FileName = "D:\OS11.iso"

$Arguments = @(
    "-m",
    "-o",
    "-u2",
    "-udfver102",
    "-l""$($Volume)""",
    "-bootdata:2#p0,e,b""$($ISO)\boot\etfsboot.com""#pEF,e,b""$($ISO)\efi\microsoft\boot\efisys.bin""",
    $ISO,
    $FileName
)

Start-Process -FilePath "OSCdimg.exe" -ArgumentList $Arguments -wait -nonewwindow
