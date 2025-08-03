# AGI ShellScript para Asterisk

📞 Controle de fluxo de ligações com AGI (Asterisk Gateway Interface) utilizando apenas **ShellScript** — sem dependências externas como Node.js, Python, Java ou bibliotecas adicionais.

---

## Descrição 📖

Este projeto apresenta uma forma simples, leve e poderosa de criar AGIs utilizando Bash.
A proposta é demonstrar como o Asterisk pode interagir com scripts em Shell, lendo variáveis de contexto, executando comandos de voz e lógica básica — tudo sem frameworks, APIs ou drivers.
### Por que Shell Script para AGI?
1. Zero dependências: Não requer a instalação de conectores, drivers ou bibliotecas externas. Tudo o que você precisa é o próprio Shell.
2. Leve e rápido: A execução é nativa e extremamente performática.
3. Controle total: Você tem controle direto sobre os comandos e o fluxo de interação com o Asterisk.

**Ideal para quem** já tem familiaridade com ShellScript e procura uma solução rápida e direta ou uma abordagem minimalista e independente.

---

## Demonstração

Veja o vídeo tutorial explicando passo a passo a implementação e execução:  
*(link do vídeo aqui)*

---

## Pré-requisitos

- Asterisk configurado com acesso a AGI.
- Ambiente Linux com Bash (ex: CentOS, Debian, Ubuntu).
- Permissões adequadas para execução de scripts e acesso ao sistema de arquivos.
- **Atenção:** este exemplo faz conexão direta com MySQL usando um comando fixo. **Não é recomendado em ambientes de produção**, especialmente com credenciais expostas no script.

---

## Como usar

1. Clone este repositório
2. Configure a extensão no extensions.conf do Asterisk para invocar seu AGI:
   ```bash
   exten => 1234,1,AGI(seu-script.sh)
3. Garanta permissões de execução:
4. ```bash
   chmod +x seu-script.sh

O script inicia lendo variáveis enviadas pelo Asterisk (via STDIN) e mapeando para variáveis de ambiente.

A função checkresults() analisa as respostas do Asterisk (200, 510, 520...) e exibe logs pelo STDERR. Atenção, ela deve ser executado a cada interação.

Executa comandos como:

STREAM FILE beep "" – reprodução de áudio.

SAY NUMBER, say phonetic – conversão de texto em áudio.

set variable CHANNEL(language) – ajusta variáveis de canal.

Consulta ao banco de dados MySQL para obter senha do usuário (pass), ilustrando como integrar lógica com dados externos.

Cada passo é acompanhado por saída para depuração (>&2).

