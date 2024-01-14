Import-Module Activedirectory
Import-Csv input.txt -Delimiter "`t" -Encoding Unicode |
%{
	write-host "Parse data..."
	$ht =@{
		GivenName				= $_.Firstname
		Surname					= $_.Lastname
		Name					= $_.FullName 
		DisplayName				= "$($_.Lastname) $($_.Firstname)"
		EmployeeID 				= $_.employeeID
		SamAccountName				= $_.UserLogonName 
		UserPrincipalName			= "$($_.UserLogonName)@domain.forest.com" 
		EmailAddress				= "$($_.UserLogonName)@domain.forest.com"
		City					= $_.City
		Country					= $_.Country
		Path					= $_.Path
		Enabled					= $true
		ChangePasswordAtLogon			= $true
		AccountPassword				= (ConvertTo-SecureString -String "Qwerty123" -AsPlainText -Force)
		Server					= "domain.forest.com"
	}

	$ht
	
	write-host "`nCreating user..."

	$user = New-ADUser @ht -PassThru
	
	$user
}