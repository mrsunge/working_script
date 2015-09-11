param([string]$ConfFileName, [datetime]$date)

##############################################
#import module file.
. C:\dba\script\conf\ParseConfFile.ps1
. C:\dba\script\copy\MakeFileList.ps1



##############################################
#load information
$conf = ParseConfFile $ConfFileName

$SrcPath = $conf['SrcPath']
$DstPath = $conf['DstPath']

$flist = MaekFileListFile $SrcPath $date


##############################################
# start copying.
Get-Content $flist | ForEach-Object {
    if ($_.ToString().Length -gt 0) {
        $result = Robocopy.exe /r:2 $SrcPath $DstPath $_.ToString().Replace(' ', '')
    }
}


##############################################
## save result
echo "================================================" >> $flist
echo "copy result" >> $flist
echo "================================================" >> $flist
echo "" >> $flist;

$result >> $flist;
