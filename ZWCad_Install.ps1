$FileUrl = "https://www.zwcad.pl/pobierz/zwcad-download/zwcad/wersje-archiwalne/zwcad-2020/193-zwcad-2020-64bit-pl"
$Destination = "C:\Users\arekw\Desktop\PowerShell\ZWCAD_2020_SP2_PLK_Win_64bi.exe"

$bitsJobObj = Start-BitsTransfer $FileUrl -Destination $Destination

switch ($bitsJobObj.JobState) {

    'Transferred' {
        Complete-BitsTransfer -BitsJob $bitsJobObj
        break
    }

    'Error' {
        throw 'Error downloading'
    }
}

#$exeArgs = '/verysilent /tasks=addcontextmenufiles,addcontextmenufolders,addtopath'

#Start-Process -Wait $Destination -ArgumentList $exeArgs
#Start-Process -Wait $Destination 