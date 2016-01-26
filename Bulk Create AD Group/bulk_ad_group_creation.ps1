# For Auditing your Active Directory 
# Creates a list of groups from a supplied groups.csv in same location as script
#
# Requires Quest Active Roles 
 
# Connect to Particular Domain, this is "CONTOSO.LOCAL" an internal Domain Name, but it could just as easily be 
# 'ACCOUNTING.CONTOSO.LOCAL' or 'ALASKA.FABRIKAM.COM' 
 
cls 
$myDir=(split-path $myinvocation.mycommand.path -parent) 
$filePath =  $myDir + '\groups.csv'
$CSV = Import-Csv $filePath


foreach ($obj in $CSV)
{
	$UI = get-qadgroup $obj.GroupName
	If (($UI.WhenCreated -eq $NULL) -or ($UI.count -gt 0)) 
    { 
		new-qadGroup -ParentContainer $obj.OU -name $obj.GroupName -samAccountName $obj.GroupName -Description $obj.Description
    }
	else {
		Write-Host $obj.GroupName " exists - skipping"
	}
}

#get-qadgroup $GRP | foreach { $_.member } ;