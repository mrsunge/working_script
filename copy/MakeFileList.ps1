function MaekFileListFile([datetime]$date) {
    $flist = 'flist_' + $date.ToString('yyyyMMdd') + '.txt'
    gci *.bak* | where {$_.name -like '*'+$date.ToString('yyyyMMdd')+'*'} | select Name | ft -HideTableHeaders > $flist;
    return $flist;
}
