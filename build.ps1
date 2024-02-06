[CmdletBinding(SupportsShouldProcess)]
param ()

. "$PSScriptRoot/functions/Switch-Environment.ps1"

try {
    Switch-Environment
}
finally {
    Switch-Environment
}
