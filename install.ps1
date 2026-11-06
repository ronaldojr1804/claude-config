# Instala/atualiza a configuração de modelos do Claude Code neste PC.
# Uso:  powershell -ExecutionPolicy Bypass -File install.ps1
# - Faz "git pull" para pegar a versão mais nova (se for um clone git).
# - Copia os agentes para ~/.claude/agents (sobrescreve só os deste repositório).
# - No ~/.claude/CLAUDE.md, troca apenas o bloco entre os marcadores abaixo;
#   o resto do arquivo (regras próprias deste PC) é preservado.

param([string]$ClaudeDir = (Join-Path $HOME '.claude'))

$ErrorActionPreference = 'Stop'
$repo   = $PSScriptRoot
$claude = $ClaudeDir
$begin  = '<!-- claude-config:inicio (gerenciado pelo repositório claude-config; edite lá) -->'
$end    = '<!-- claude-config:fim -->'

if (Test-Path (Join-Path $repo '.git')) {
    try { git -C $repo pull --ff-only } catch { Write-Warning "git pull falhou; instalando a versão local." }
}

# Agentes
$agentsDir = Join-Path $claude 'agents'
New-Item -ItemType Directory -Force $agentsDir | Out-Null
Get-ChildItem (Join-Path $repo 'agents') -Filter *.md | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $agentsDir $_.Name) -Force
    Write-Host "agente: $($_.Name)"
}

# CLAUDE.md (bloco gerenciado)
$utf8  = New-Object System.Text.UTF8Encoding($false)
$body  = [IO.File]::ReadAllText((Join-Path $repo 'CLAUDE.md'), $utf8).Trim()
$block = $begin + "`n" + $body + "`n" + $end
$target = Join-Path $claude 'CLAUDE.md'

if (Test-Path $target) {
    $current = [IO.File]::ReadAllText($target, $utf8)
    $i = $current.IndexOf($begin); $j = $current.IndexOf($end)
    if ($i -ge 0 -and $j -gt $i) {
        $new = $current.Substring(0, $i) + $block + $current.Substring($j + $end.Length)
    } elseif ($current.Trim() -eq $body) {
        $new = $block + "`n"   # mesma regra instalada à mão antes: só adiciona os marcadores
    } else {
        $backup = "$target.bak-" + (Get-Date -Format 'yyyyMMdd-HHmmss')
        Copy-Item $target $backup
        Write-Host "CLAUDE.md existente preservado (backup em $backup); bloco adicionado ao final."
        $new = $current.TrimEnd() + "`n`n" + $block + "`n"
    }
} else {
    $new = $block + "`n"
}
[IO.File]::WriteAllText($target, $new, $utf8)
Write-Host "CLAUDE.md atualizado em $target"
Write-Host "Pronto. Vale a partir da próxima sessão do Claude Code."
