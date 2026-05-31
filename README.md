# Monitor de Sistema
 
Script interativo em BASH para monitoramento do sistema operacional Linux, desenvolvido como Avaliação Contínua da disciplina de Sistemas Operacionais do IBMEC.
 
**Disciplina:** Sistemas Operacionais — IBM8940 | Turma 8001  
**Professor:** Luiz Fernando T. de Farias  
**Autores:** Arthur Riess Cunha e Bernardo Cicchelli
 
---
 
## Funcionalidades
 
O script apresenta um menu interativo com as seguintes opções:
 
**1. Informações Gerais do Sistema**
Exibe nome da máquina, usuário logado, sistema operacional, versão do kernel, arquitetura, uptime, IP local e data/hora atual.
 
**2. Monitorar CPU**
- Ver modelo do processador
- Ver número de núcleos
- Ver uso atual da CPU em tempo real

**3. Monitorar Memória**
- Ver uso de memória RAM (total, usada e livre)
- Ver uso de Swap

**4. Verificar Espaço em Disco**
- Listar todas as partições do sistema
- Ver tamanho de um diretório específico
- Verificar partições com uso acima de um percentual definido pelo usuário

**5. Gerenciar Processos**
- Listar os N processos com maior consumo de CPU
- Buscar processo por nome
- Encerrar processo por PID

**6. Finalizar** — única forma de encerrar o script.
 
---
 
## Requisitos
 
- Sistema operacional Linux (testado no Ubuntu/Lubuntu 22.04)
- BASH 4.0 ou superior
- Apenas comandos nativos do sistema — sem dependências externas
---
 
## Como usar
 
```bash
# 1. Dar permissão de execução
chmod +x MonitorProcessos.sh
 
# 2. Executar
./MonitorProcessos.sh
```
 
---
 
## Comandos utilizados
 
| Comando | Propósito |
|---|---|
| `hostname` | Nome da máquina |
| `whoami` | Usuário logado |
| `uname` | Informações do sistema e kernel |
| `uptime` | Tempo de atividade do sistema |
| `ip route` | Endereço IP local |
| `date` | Data e hora do sistema |
| `top -bn1` | Uso atual da CPU em modo batch |
| `cat /proc/cpuinfo` | Informações do processador |
| `free` | Uso de memória RAM e Swap |
| `df` | Uso de disco por partição |
| `du` | Tamanho de diretório específico |
| `ps` | Lista de processos em execução |
| `kill` | Encerra processo por PID |
| `grep` | Filtragem de texto |
| `awk` | Processamento e formatação de saídas |
| `sed` | Manipulação de strings |
| `cut` | Extração de campos de texto |
| `read` | Leitura de input do usuário |
 
---
 
## Estrutura do script
 
```
MonitorProcessos.sh
│
├── exibir_cabecalho()       — cabeçalho padronizado com dados do sistema
├── exibir_menu()            — menu principal
├── pausar()                 — aguarda Enter antes de voltar ao menu
├── opcao_1_info_sistema()   — informações gerais da máquina
├── submenu_cpu()            — monitoramento do processador
├── submenu_memoria()        — monitoramento de memória RAM e Swap
├── submenu_disco()          — verificação de espaço em disco
├── submenu_processos()      — gerenciamento de processos
└── loop principal           — while + case, finaliza apenas pela opção 6
```
