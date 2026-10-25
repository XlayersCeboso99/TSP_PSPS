param(
  [Parameter(Mandatory = $true)][string]$DeviceId,
  [string]$EvidenceDirectory,
  [ValidateSet('integration_test/sprint2_design_test.dart', 'integration_test/cu07_offline_test.dart')]
  [string]$Target = 'integration_test/sprint2_design_test.dart'
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
$gradle = $gradle.Replace('namespace = "mx.edu.uaz.psps"', 'namespace = "mx.edu.uaz.psps.integration"')
[IO.File]::WriteAllText($gradleFile, $gradle)
$activityFile = Join-Path $testRoot 'android/app/src/main/kotlin/mx/edu/uaz/psps/MainActivity.kt'
$activity = [IO.File]::ReadAllText($activityFile).Replace('package mx.edu.uaz.psps', 'package mx.edu.uaz.psps.integration')
[IO.File]::WriteAllText($activityFile, $activity)
$manifestFile = Join-Path $testRoot 'android/app/src/main/AndroidManifest.xml'
$manifest = [IO.File]::ReadAllText($manifestFile).Replace('android:label="PSPS Academy"', 'android:label="PSPS Academy (pruebas)"')
[IO.File]::WriteAllText($manifestFile, $manifest)
$oldOptions = $env:GRADLE_OPTS
$oldEvidence = $env:PSPS_EVIDENCE_DIR
Push-Location $testRoot
try {
  $env:GRADLE_OPTS = "$oldOptions -Djavax.net.ssl.trustStoreType=Windows-ROOT -Djavax.net.ssl.trustStore=NONE"
  $env:PSPS_EVIDENCE_DIR = $EvidenceDirectory
  # Flutter can derive cleanup metadata from the activity namespace. Keep the
  # runner installed instead of allowing drive to uninstall any app implicitly.
  flutter drive --keep-app-running --driver=test_driver/design_driver.dart --target=$Target -d $DeviceId
  if ($LASTEXITCODE -ne 0) { throw 'Falló la prueba Android; revisa el registro.' }
  Write-Output "Evidencias: $EvidenceDirectory"
  Write-Output "Copia de pruebas: $testRoot"
} finally {
  $env:GRADLE_OPTS = $oldOptions
  $env:PSPS_EVIDENCE_DIR = $oldEvidence
  Pop-Location
}
