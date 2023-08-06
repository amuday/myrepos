param ( $param1, $ServiceName )
Write-Host "Received Param1 is [$param1]"
Write-Host "Received ServiceName is [$ServiceName]"


Describe "A suite" {
    It "my first test" {
    $Value = "Value"
    $Value | Should -Be "Value"
    }
}