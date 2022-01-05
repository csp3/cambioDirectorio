$global:d = new-object system.collections.arraylist
$global:l = new-object system.collections.arraylist
$global:n = 0

# obteniendo unidades del sistema 
for ($i = 65; $i -le 90; $i++)
{
    $global:l.Add([char]$i + ":\")
}

# SD 
function SD 
{
    <# 
        .DESCRIPTION
        Cambia al directorio anterior (-) ó posterior (+) ó path  
        .EXAMPLE
        PS C:\users\home\documents> SD [-] [..] 
        PS C:\users\home> SD +
        PS C:\users\home> SD path 
        .NOTES
        FunctionName: SD (sd) 
        Created by  : CSolisP
        Date Coded  : Ene 2022 
    #>
    [CmdletBinding()]
    param(
        $p = "-" 
    )
           
    if ($p -eq "-" -or $p -eq "..") 
    {
        # directorio anterior 
        ubicar $p 
    }
    elseif ($p -eq "+") 
    {
        # directorio siguiente 
        $n = $global:d.Count 
        if ($p -eq "+" -and $n -gt 0) 
        {
            Set-Location -Path $global:d[$n - 1] 
            $global:d.RemoveAt($n - 1)
        }
    }
    else 
    {
        ubicar $p 
    }
}

# ubicar ruta 
function ubicar 
{
    param (
        $param = ""
    )
    # "-" = ".."
    if($param -eq "-")
    {
        $param = ".."
    }

    $aux = 1
    $ubicacion = (Get-Location).Path
    # si es igual a unidad de disco 
    $global:l | %{ if ($_ -eq $ubicacion) { $aux = "0"; break }}
        
    if ($aux)  
    {
        $global:d.Add($ubicacion) 
        Set-Location -Path $param #-PassThru 
    }               
}
