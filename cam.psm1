<#
.DESCRIPTION
Cambia al directorio anterior (-) o posterior (+)  
.EXAMPLE
PS C:\users\home\documents> SD -  
PS C:\users\home> SD +
.NOTES
Author: CSolisP
Date:   Ene 2022 
#>

$global:d = new-object system.collections.arraylist
$global:l = new-object system.collections.arraylist
$global:n = 0

# obteniendo unidades del sistema 
for ($i = 65; $i -le 90; $i++)
{
    $global:l.Add([char]$i + ":\")
}

# SD [-] (+) 
function SD 
{
    [CmdletBinding()]
    param(
        $p = "-" 
    )
           
    switch ($p) 
    {
        "-" 
        {
            # directorio anterior 
            if ($p -eq "-") 
            {
                $aux = 1
                $ubicacion = (Get-Location).Path
                # si 
                $global:l | %{ if ($_ -eq $ubicacion) { $aux = "0"; break }}
                
                if ($aux)  
                {
                    $global:d.Add($ubicacion)     
                    Set-Location -Path .. #-PassThru
                }
            }
        }

        "+" 
        {
            # directorio siguiente 
            $n = $global:d.Count 
            if ($p -eq "+" -and $n -gt 0) 
            {
                Set-Location -Path $global:d[$n - 1] 
                $global:d.RemoveAt($n - 1)
            }
        }
        
        Default 
        {
            write-host 'use: ( SD - ) or ( SD + ) '
        }
    }
}
