
# First-test run below commands in powershell

PS E:\cloud_devops_local\github-devops-repo> Import-Module Pester -Passthru
PS E:\cloud_devops_local\github-devops-repo> cd pester        
PS E:\cloud_devops_local\github-devops-repo\pester> Invoke-Pester -Output Detailed .\Get-Planet.Tests.ps1

# To run TF fmt
PS E:\cloud_devops_local\github-devops-repo\pester\tf-fmt-test> .\tf-fmt-pester.Tests.ps1


Invoke-Pester -OutputFile Test.xml -OutputFormat JUnitXml


# pester install on mcr.microsoft.com/powershell docker
https://bzzzt.io/post/2019-10/2019-10-07-running-pester-tests-on-linux-build-agent/


https://automatingops.co.uk/2022/08/20/using-gitlab-ci-cd-to-test-and-release-public-powershell-code/

#

pwsh -Command Install-Module pester -Force

test:
  stage: test
  script:  
  # run PowerShell script
  - pwsh -File build.ps1

  # run PowerShell Command
  - pwsh -Command "Get-Date"  
  - |
  	pwsh command1
  	pwsh command 2

## pester pass parameters
$container = New-PesterContainer -Path . -Data @{ param1='hello'; ServiceName='world' }


$MyOptions = @{
   Run = @{
        Exit = $true
        Container = $container
    }
    Output = @{
        Verbosity = 'Detailed'
    }
    TestResult = @{
        Enabled      = $true
        OutputFormat = "JUnitXml"
        OutputPath   = "./testresults.xml"
    }
}


$config = New-PesterConfiguration -Hashtable $MyOptions

Invoke-Pester -Configuration $config