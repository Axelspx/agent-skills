$ErrorActionPreference = "Stop"

$repoRoot  = $PSScriptRoot
$skillsDir = Join-Path $repoRoot "skills"

$targets = @(
    (Join-Path $HOME ".agents\skills"),   # Codex
    (Join-Path $HOME ".claude\skills")    # Claude Code
)

if (-not (Test-Path $skillsDir)) {
    throw "Skills directory not found: $skillsDir"
}

$skills = Get-ChildItem $skillsDir -Directory |
        Where-Object {
            Test-Path (Join-Path $_.FullName "SKILL.md")
        }

if (-not $skills) {
    Write-Host "No skills containing SKILL.md found in:"
    Write-Host "  $skillsDir"
    exit 0
}

Write-Host ""
Write-Host "Agent Skills Setup"
Write-Host "=================="
Write-Host "Skills bank: $skillsDir"
Write-Host ""

foreach ($target in $targets) {

    if (-not (Test-Path $target)) {
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        Write-Host "[created] $target"
    }

    foreach ($skill in $skills) {
        $destination = Join-Path $target $skill.Name

        if (Test-Path $destination) {
            Write-Host "[exists]  $destination"
            continue
        }

        New-Item `
            -ItemType Junction `
            -Path $destination `
            -Target $skill.FullName | Out-Null

        Write-Host "[linked]  $destination"
    }
}

Write-Host ""
Write-Host "Done. Installed $($skills.Count) skill(s) for Codex and Claude."