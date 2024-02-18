$Oscdimg = "D:\data\program\Oscdimg.exe"

$ISO = "D:\OS_11"
$Volume = "Windows11"
$FileName = "D:\Windows11.iso"

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

Start-Process -FilePath $Oscdimg -ArgumentList $Arguments -wait -nonewwindow
