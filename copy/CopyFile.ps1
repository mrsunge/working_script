param([string]$ConfFileName, [datetime]$date)


. C:\dba\script\copy\ParseConfFile.ps1
. C:\dba\script\copy\MakeFileList.ps1


$conf = ParseConfFile $ConfFileName

$SrcPath = $conf['SrcPath']
$DstPath = $conf['DstPath']

$flist = MaekFileListFile $SrcPath $date


echo "================================================" >> $flist
echo "copy result" >> $flist
echo "================================================" >> $flist
echo "" >> $flist;

Get-Content $flist | ForEach-Object {
    if ($_.ToString().Length -gt 0) {
        $result = Robocopy.exe /r:2 $SrcPath $DstPath $_.ToString().Replace(' ', '')
    }
}

$result >> $flist;