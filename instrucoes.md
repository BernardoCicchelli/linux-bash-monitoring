# 💻 Monitor de Sistema em BASH

Uma ferramenta interativa em shell script para o monitoramento do seu sistema.

## 📋 Menu Principal

1. **Visão Geral do Sistema**
2. **Monitorar CPU**
3. **Monitorar Memória**
4. **Verificar Espaço em Disco**
5. **Gerenciar Processos**
6. **Finalizar**

---

## 🛠️ Detalhes das Funcionalidades

### 1. 🌐 Visão Geral
Mostra todas as informações cruciais simultaneamente, funcionando como um *dashboard* rápido.
- **Informações exibidas:** Nome do host, *uptime*, usuário logado, IP da máquina e versão do *kernel*.
- **Comandos utilizados:** `uname`, `uptime`, `hostname`, `whoami`.

### 2. ⚡ Monitorar CPU
Apresenta opções interativas para análise do processamento.
- **Funcionalidades:**
  - Visualizar o uso atual.
  - Visualizar o histórico dos últimos minutos.
  - Monitorar em tempo real por *N* segundos (duração definida pelo usuário).
- **Comandos utilizados:** `top`, `mpstat`, `vmstat`.

### 3. 🧠 Monitorar Memória
Exibe o consumo de memória de forma clara e estruturada.
- **Funcionalidades:**
  - Exibição de RAM total, usada, livre e *swap* formatadas em uma tabela legível.
  - Opção de alerta caso o uso ultrapasse um percentual definido pelo usuário.
- **Comandos utilizados:** `free`.

### 4. 💾 Verificar Espaço em Disco
Monitora as partições e o tamanho dos diretórios.
- **Funcionalidades:**
  - Listagem de todas as partições com o respectivo uso percentual.
  - Consulta do tamanho de um diretório específico (definido pelo usuário).
- **Comandos utilizados:** `df`, `du`.

### 5. ⚙️ Gerenciar Processos
Apresenta um sub-menu focado na administração de tarefas em execução.
- **Sub-menu:**
  - Listar os *N* processos que mais consomem CPU (quantidade definida pelo usuário).
  - Buscar um processo pelo seu nome.
  - Encerrar um processo especificando seu nome ou **PID**.
- **Comandos utilizados:** `ps`, `kill`, `pkill`, `grep`.