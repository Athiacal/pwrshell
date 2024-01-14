import-module activedirectory

if(-not $(test-path variable:\PSCommandPath)){
	$scriptpath = Get-Location
}else{
	$scriptpath = Split-Path -Parent $PSCommandPath
}

Import-Csv -Path "$scriptpath\input.txt" -Encoding default -Delimiter: "`n" |
%{
	$users += @($_.user)
}
write-host $users

foreach ($user in $users) {
	Disable-MailUser $user -Confirm:$false
	write-host $user " was disabled"
}