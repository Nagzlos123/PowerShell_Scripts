$startPath = "C:\Users\arekw\Desktop\PowerShell"
$cheron = "C:\Users\arekw\Desktop\FolderyTestowe\Wycenny\Cheron"
$homag = "C:\Users\arekw\Desktop\FolderyTestowe\Wycenny\Homag"
$wajman = "C:\Users\arekw\Desktop\FolderyTestowe\Wycenny\Wajman"
Write-Host "----------------------------------"
Write-Host "Wybiesz firme wpisujac liczbe jej przypisana "
Write-Host "1. Cheron"
Write-Host "2. Homag"
Write-Host "3. Wajman"

$firmaId = Read-Host "Podaj numer firmy:"

function OpenFolder {
    param (
        $newProgramPath
    )
    Start-Process $newProgramPath
}

function SetCurrentDirectory {
    param (
        $directoryPath
    )
    $firmNamePath = $directoryPath
    Write-Host $firmNamePath
    Set-Location $firmNamePath
    $currentDirectory = Get-Location
    OpenFolder $currentDirectory
    Set-Location $startPath
}
switch ($firmaId) {
    1 { 
        SetCurrentDirectory $cheron
        ;  break
    }
    2 { 
        SetCurrentDirectory $homag
        ;  break
      }
    3 { 
        SetCurrentDirectory $wajman
        ;  break
     }
    4 { "It's four."  }

    default { "Wpisany numer nie pasuje" }
}