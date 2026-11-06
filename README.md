# claude-config

Minha configuração global do Claude Code, para economizar o limite da assinatura:
o Opus 5.5 pensa e decide, e o trabalho mais simples vai para modelos mais baratos.

| Subagente | Modelo | Para quê |
|---|---|---|
| `leitor` | Haiku 5.5 | Ler arquivos e buscar no código |
| `executor` | Haiku 5.5 | Edições mecânicas, rodar testes/build |
| `implementador` | Sonnet 5.5 | Escrever código a partir do plano do Opus |

As regras de quando delegar estão em [CLAUDE.md](CLAUDE.md).

## Instalar em um PC novo

```powershell
git clone https://github.com/<seu-usuario>/claude-config.git $HOME\claude-config
powershell -ExecutionPolicy Bypass -File $HOME\claude-config\install.ps1
```

## Atualizar

1. Edite os arquivos **neste repositório** (não em `~/.claude`), faça commit e push.
2. Em cada PC, rode de novo o `install.ps1` — ele faz `git pull` sozinho.

O script só mexe nos agentes deste repositório e no bloco marcado do `~/.claude/CLAUDE.md`.
Regras próprias de cada PC fora desse bloco são preservadas.
