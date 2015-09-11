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
$fresult = $flist.Replace('.txt', '_result.txt');


##############################################
# start copying.
echo "start copy" $date.ToString() > $fresult
Get-Content $flist | ForEach-Object {
    if ($_.ToString().Length -gt 0) {
        Robocopy.exe /r:2 $SrcPath $DstPath $_.ToString().Replace(' ', '') >> $fresult
    }
}