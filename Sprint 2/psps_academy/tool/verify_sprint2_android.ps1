param(
  [Parameter(Mandatory = $true)][string]$DeviceId,
  [string]$EvidenceDirectory
)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
if (-not $EvidenceDirectory) {
  $EvidenceDirectory = Join-Path $projectRoot 'build/design_evidence'
}
$EvidenceDirectory = [IO.Path]::GetFullPath($EvidenceDirectory)
New-Item -ItemType Directory -Force -Path $EvidenceDirectory | Out-Null
$testRoot = Join-Path $env:TEMP ('psps-s2-android-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $testRoot | Out-Null
& robocopy $projectRoot $testRoot /E /A-:R /DCOPY:T /XD build .dart_tool .gradle ephemeral Pods .git .symlinks .plugin_symlinks node_modules coverage /XF local.properties /NFL /NDL /NJH /NJS /NP | Out-Null
if ($LASTEXITCODE -ge 8) { throw 'No se pudo preparar la copia de pruebas.' }
# Set the literal application ID in the disposable project, so Flutter itself
# detects the test package correctly during installation AND cleanup.
$gradleFile = Join-Path $testRoot 'android/app/build.gradle.kts'
$gradle = [IO.File]::ReadAllText($gradleFile)
if (-not $gradle.Contains('applicationId = "mx.edu.uaz.psps"')) {
  throw 'No se reconoce el ID de la aplicación. No se ejecutaron las pruebas.'
}
$gradle = $gradle.Replace('applicationId = "mx.edu.uaz.psps"', 'applicationId = "mx.edu.uaz.psps.integration"')
[IO.File]::WriteAllText($gradleFile, $gradle)
$oldOptions = $env:GRADLE_OPTS
$oldEvidence = $env:PSPS_EVIDENCE_DIR
Push-Location $testRoot
try {
  $env:GRADLE_OPTS = "$oldOptions -Djavax.net.ssl.trustStoreType=Windows-ROOT -Djavax.net.ssl.trustStore=NONE"
  $env:PSPS_EVIDENCE_DIR = $EvidenceDirectory
  flutter drive --driver=test_driver/design_driver.dart --target=integration_test/sprint2_design_test.dart -d $DeviceId
  if ($LASTEXITCODE -ne 0) { throw 'Falló la prueba Android; revisa el registro.' }
  Write-Output "Evidencias: $EvidenceDirectory"
  Write-Output "Copia de pruebas: $testRoot"
} finally {
  $env:GRADLE_OPTS = $oldOptions
  $env:PSPS_EVIDENCE_DIR = $oldEvidence
  Pop-Location
}
