BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

Describe 'Demonstrating Code Coverage' {
    It 'Calls FunctionOne with no switch parameter set' {
        FunctionOne | Should -Be 'SwitchParam was not set'
    }

    It 'Calls FunctionTwo' {
        FunctionTwo | Should -Be 'I get executed'
    }
}