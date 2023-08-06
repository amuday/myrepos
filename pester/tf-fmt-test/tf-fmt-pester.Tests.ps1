# import module before creating the object
Import-Module Pester -Passthru

# get default from static property
#$PesterConfig = [PesterConfiguration]::Default
# $PesterConfig = New-PesterConfiguration

# # assing properties & discover via intellisense
# $PesterConfig.Output.Verbosity = "Detailed"
# $PesterConfig.TestResult.OutputFormat = "JUnitXml"
# $PesterConfig.TestResult.OutputPath = "Test-TFfmt.xml"
# $PesterConfig.TestResult.Enabled = $True
# $PesterConfig.TestResult.TestSuiteName = "TFfmt"
# $PesterConfig.Run.Throw = $false
# $PesterConfig.Run.Exit = $false
# $PesterConfig.Should.ErrorAction = 'Continue'


$configuration = [PesterConfiguration]@{
      PassThru = $true
      Output = @{
         Verbosity = 'Detailed'
      }
      TestResult = @{
         Enabled = $true
         OutputFormat = "NUnitXml"
         OutputPath   = $tr
         }
      }       

$TFFiles = $null
$TFFiles = $(Get-ChildItem -Recurse ./ -Filter '*.tf').FullName
foreach ($File in $TFFiles){
    Describe "$(Resolve-Path -relative $File)" {
        Context "Terraform format" {
            It "Be Well formatted" -TestCases @{LinterResults = $(terraform fmt -list=true -write=false $File) -join " "}{
                param($LinterResults)
                $LinterResults | Should -BeNullOrEmpty -ErrorAction Ignore
            }

        }
    }
}
