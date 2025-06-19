$programPath = "C:\Users\arekw\Desktop\FolderyTestowe\Wycenny\Cheron"
$startPath = "C:\Users\arekw\Desktop\PowerShell"
$txtFile = "C:\Users\arekw\Desktop\FolderyTestowe\Wycenny\Wyceny.txt"
$tmp = "C:\Users\arekw\Desktop\FolderyTestowe\Wycenny\Cheron\1006785"
$tmp2 = "C:\Users\arekw\Desktop\FolderyTestowe\Wycenny\Cheron\1179823"

$list = New-Object Collections.Generic.List[Int]
$list2 = New-Object Collections.Generic.List[Int]

$Pdf_files = New-Object Collections.Generic.List[string]
$Dwg_Dxf_files = New-Object Collections.Generic.List[string]
#Functin opens file of giwen path
function OpenFolder {
    param (
        $newProgramPath
    )
    Start-Process $newProgramPath
}
function OpenDWG_DXF {
    param (
        $currentDirectory
    )

    Set-Location $currentDirectory
    $pdfs = Get-ChildItem -Path $currentDirectory -Include *.dwg -Force -Name
    $Pdf_files= $pdfs

    foreach($item in $Pdf_files){
        
        $newProgramPath = "{0}\{1}" -f $currentDirectory, $item
        #Write-Host "[", "Nazwa:", $newProgramPath, "]" -ForegroundColor Yellow
        Invoke-Item $newProgramPath
    }
    #Invoke-Item $programPath
}

function OpenPDF {
    param (
        $currentDirectory
    )
    Set-Location $currentDirectory
    $pdfs = Get-ChildItem -Path $currentDirectory -Include *.pdf -Force -Name
    $Pdf_files= $pdfs

    foreach($item in $Pdf_files){
        
        $newProgramPath = "{0}\{1}" -f $currentDirectory, $item
        #Write-Host "[", "Nazwa:", $newProgramPath, "]" -ForegroundColor Yellow
        Start-Process $newProgramPath
    }

    #Start-Process $programPath
}
function GetDataFromTXT {
    param (
        $txtFilePath
    )

    $txt = Get-Content $txtFilePath

    if([String]::IsNullOrWhiteSpace((Get-Content $txtFilePath))){
        Write-host "Plik jest pusty" -f red
    }
    else{
        #$txt -is [list]
        $list2 = $txt
        $count = 0
        foreach ($item in $list2){
            $count++
            Write-host "[" , $count, "]",  "Nazwa elemetu:" $item
            $list.Add($item)
        } 
    }

    
}
#Function is looping through element of the list and sets a path to open them
function GetItemNames {
    param (
        $programPath
    )
    Set-Location $programPath
    #$currentDirectory = Get-Location 
    #Write-host $currentDirectory

    $count = 0

    foreach ($item in $list){
        $count++
        $newProgramPath = $programPath + "\" + [string]$item
        
        if(Test-Path -Path $newProgramPath){
            
            Set-Location $newProgramPath
            $currentDirectory = Get-Location 

            $numberOfSubFiles = [int] (Get-ChildItem $currentDirectory -Recurse -File | Measure-Object | %{$_.Count})
            
            Write-host "[" , $count, "] "-f blue -nonewline;
            Write-host  "[","Nazwa pliku:", $item, "] " -ForegroundColor Yellow -nonewline;

            if($numberOfSubFiles -eq 0){
                Write-host "Folder pusty" -f red
            }
            else {
                Write-host "Folder zawiera pliki " -f Green

                #OpenPDF $currentDirectory
            }
            #Write-host "D == " -f red -nonewline;
            #Write-host $currentDirectory -f blue

            #OpenFolder $currentDirectory

            Get-ChildItem -Path $newProgramPath -Name
        }else {

            Write-host "[" , $count, "] " -f blue -nonewline; 
            Write-host "Nazwa pliku:" $item -f green -nonewline; 
            Write-host " Plik nie istnieje" -f red
        }
        
       
    } 

    Set-Location $startPath
}
function Start-Program{
    Write-host "--------------------"
    Write-host ""
    Write-host "--------------------"
    GetDataFromTXT $txtFile
    Write-host "--------------------"
    GetItemNames $programPath

    #OpenPDF $tmp
    OpenDWG_DXF $tmp2
    Set-Location $startPath
}

Start-Program



function Start-Explorer {
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateScript({Test-Path $_})]
        [System.IO.FileInfo]$Path
    )
    if ($Path.Attributes -eq 'Directory') {
        $Path = Get-ChildItem -Path $Path.FullName -File | Select-Object -First 1
    }
    Write-Verbose "Opening Explorer to $($Path.FullName)"
    Start-Process -FilePath explorer.exe -ArgumentList "/select,$($Path.FullName)"
}





