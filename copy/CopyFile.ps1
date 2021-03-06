﻿# This script is run on destination computer.

param([string]$ConfFileName, [datetime]$date)

##############################################
#import module file.
. C:\dba\script\conf\ParseConfFile.ps1
. C:\dba\script\copy\MakeFileList.ps1



##############################################
# load information
$conf = ParseConfFile $ConfFileName

$SrcPath = $conf['SrcPath']
$DstPath = $conf['DstPath']
$DstPathDate = $DstPath + '/' + $(get-date).ToString('yyyyMMdd')


##############################################
# make destination folder
if (-not (Test-Path $DstPathDate)) {
    mkdir $DstPathDate
}

$flist = MaekFileListFile $SrcPath $date
$fresult = $flist.Replace('.txt', '_result.txt');


##############################################
# login by net use
$Hst = $conf['Host']
$Id = $conf['ID']
$Pwd = $Conf['PW']

$NetUse = 'net use ' + $Hst + ' /user:' + $Id + ' ' + $Pwd

iex "$NetUse";

##############################################
# start copying.
echo "start copy" $date.ToString() > $fresult
Get-Content $flist | ForEach-Object {
    if ($_.ToString().Length -gt 0) {
        Robocopy.exe /r:2 $SrcPath $DstPathDate $_.ToString().Replace(' ', '') >> $DstPathDate/$fresult
    }
}

##############################################
# logout

$NetDelete = 'net use /delete ' + $Hst
iex "$NetDelete"
