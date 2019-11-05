param([String[]] $Scripts)

Add-Content c:\puppetscript.log "Installing puppet"

Start-Process msiexec.exe -Wait -ArgumentList '/qn /norestart /i https://downloads.puppetlabs.com/windows/puppet5/puppet-agent-x64-latest.msi PUPPET_MASTER_SERVER=puppet'
if (Test-Path "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat") {
    & "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" module install puppetlabs/windows
    & "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" module install puppet/windows_env
    & "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" module install puppetlabs/docker
    & "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" module install puppet/download_file
    & "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" module install puppet/windowsfeature
    & "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" module install puppet-archive --version 3.2.1

    $ErrorActionPreference = "Continue"

    Write-Host "Script dir: $PSScriptRoot"
    cd $PSScriptRoot

    Add-Content c:\puppetscript.log "Running puppet"

    foreach($script in $scripts) {
        # Chocolatey installs are brittle, so we add a retry
        for ($retry = 0; $retry -lt 2; ++$retry) {
            $result = Start-Process "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" `
                -ArgumentList @("apply", "puppet\$script", "--disable_warnings=deprecations", "--logdest", "C:\puppet.log", "--detailed-exitcodes") `
                -Wait `
                -PassThru
            Write-Host "Got return code $($result.ExitCode) for script $script"
            Add-Content c:\puppetscript.log "Got return code $($result.ExitCode) for script $script"
            if ($result.ExitCode -eq 0 -or $result.ExitCode -eq 2) {
                break
            }
        }

        if ($result.ExitCode -ne 0 -and $result.ExitCode -ne 2) {
            Write-Error "Failed to run Puppet script $script"
            exit 100
        }
    }

    exit 0
} else {
    Write-Error "Could not find the Puppet agent executable. Make sure the script was run from an administrative Powershell session."
    exit 101
}