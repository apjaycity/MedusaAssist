$headPath = $MyInvocation.MyCommand.Path
$headDir = Split-Path -Parent $headPath
$ManifestPath = Join-Path $headDir "medusa.manifest"
$RequestPath = Join-Path $headDir "medusa.request"#rpc request from scripts. Scripts should write to this file to request medusa to run code
#in this way medusa runs code only when requested as a call back
#that callback can by python, powershell, bash,or even c#,C++,java, etc as long as it gets wrapped and the output written to a stream
#the powershell will run medusa but other languages will be used to execute code on data sets through powers shell
$med = Get-Item $ManifestPath  
if(echo $med.Name -eq "medusa.manifest") {
    echo "Medusa:Manifest file found"
} else {
    echo "Medusa:Manifest file not found"
}
if(echo $med.OpenText().ReadToEnd() -eq "runMed") {
    echo "Medusa:running step"
} else {
    echo "Medusa:step warning:check manifest settings!"
}

echo "Medusa is running"

$req = Get-Item $RequestPath
if(echo $req.Name -eq "medusa.request") {
    echo "Medusa:Request file found"
    $reqToProc =  $req.OpenText().ReadToEnd() -split ','
    powershell.exe $reqToProc[0] $reqToProc[1]
    
    
} else {
    echo "Medusa:Request file not found"
}
