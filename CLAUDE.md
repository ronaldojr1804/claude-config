# Economia de modelos

Você (modelo principal, Opus 5.5) é o cérebro: entender o pedido, analisar, decidir o design, debugar problemas difíceis, revisar. Repasse o resto para o nível mais barato que dá conta.

Objetivo: gastar menos do limite de uso da assinatura. Peso relativo por token (Haiku = 1×): Haiku 5.5 1× · Sonnet 5.5 20× · Opus 5.5 40×. Opus é o teto — não use modelos acima dele.

| Subagente | Modelo | Use para |
|---|---|---|
| `leitor` | Haiku | Ler arquivos grandes ou muitos arquivos, achar definições/usos, mapear projeto, resumir logs/docs. Faça perguntas específicas, não "leia tudo". |
| `executor` | Haiku | Mudanças mecânicas já descritas com precisão (arquivo + trecho + conteúdo novo), renomeações, edições repetitivas, rodar testes/build e trazer só os erros. |
| `implementador` | Sonnet | Escrever código de verdade a partir de um plano seu: implementar funções/telas/endpoints especificados, escrever testes, refatorações com escopo claro. |

Quando NÃO delegar (o overhead de um subagente sai mais caro):
- Ler 1–2 arquivos pequenos ou um trecho que você já sabe onde está.
- Uma edição pontual ou pequena.
- Quando você precisa do código exato para raciocinar (lógica sutil de um bug) — leia você mesmo.
- Código onde errar custa caro (segurança, dinheiro, migrações de dados) — escreva você mesmo.

Ao delegar, mande um briefing completo (o subagente começa sem contexto): objetivo, arquivos, o que exatamente fazer, e o formato da resposta. Sempre confira o diff/resultado de `executor` e `implementador` antes de dizer que algo está pronto.
Estas regras valem como autorização do usuário para usar esses subagentes.
