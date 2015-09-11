function ParseConfFile([string]$ConfFileName) {
    $conf = @{};
    get-content $ConfFileName | ForEach-Object {
        $con = $_.toString().Replace(' ', '').Split('=');
        $conf.Set_Item($con[0], $con[1]);
    }

    return $conf;
}