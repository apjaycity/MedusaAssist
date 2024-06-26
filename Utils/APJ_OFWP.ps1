$params = $args -split ","
$cmd = $params[0]
$arg = $params[1]
if( $null -eq $params[2]) {
    $sub = ""
} else {
    $arg = $arg + $params[2]
}

Write-Output "Command: $cmd"
Write-Output "Argument: $arg"

try {
    $ps = New-Object System.Diagnostics.Process
    $ps.StartInfo.FileName = $cmd
    $ps.StartInfo.Arguments = $arg+" "+$sub
    $ps.StartInfo.RedirectStandardOutput = $true
    $ps.StartInfo.RedirectStandardError = $true
    $ps.StartInfo.UseShellExecute = $false
    $ps.StartInfo.CreateNoWindow = $true
    $ps.start()
    
    $ps.WaitForExit()
    $stdout = $ps.StandardOutput.ReadToEnd()
    $stderr = $ps.StandardError.ReadToEnd()
    
    Write-Output "Output: $stdout"
    Write-Output "Errors: $stderr"
} catch {
    Write-Output "An error occurred: $_"
}