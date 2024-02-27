$outFile = "$PSScriptRoot\artefacts\TestResults.NUnitXml.xml";
$outCoverageFile = "$PSScriptRoot\artefacts\TestsCoverage.Jacoco.xml";

Invoke-Pester ./tests/* -CodeCoverage @('./src/*') -OutputFile $outFile -OutputFormat NUnitXml -CodeCoverageOutputFile $outCoverageFile  

$sonarOutFile = "$PSScriptRoot\artefacts\TestResults.GF.xml";

## steps to convert $outFile to Generic Execution format (https://docs.sonarqube.org/latest/analysis/generic-test/)
## and save to ./artefacts/TestsResults.GF.xml file


[xml]$doc = New-Object System.Xml.XmlDocument
$dec = $doc.CreateXmlDeclaration("1.0","UTF-8",$null);
$doc.AppendChild($dec);

$root = $doc.CreateNode("element","testExecutions",$null);

[xml]$nunitReport = Get-Content -Path $outFile
$testSuites = $nunitReport['test-results']['test-suite']['results'].SelectNodes('test-suite')

foreach ($ts in $testSuites) {

 $file = $doc.CreateNode("element","file",$null);
 $file.SetAttribute("path", $ts.name);
 
 ## more code needed here to include test runs
 ## ......
 $root.AppendChild($file);
}

$doc.AppendChild($root)

$doc.save($sonarOutFile)
return

