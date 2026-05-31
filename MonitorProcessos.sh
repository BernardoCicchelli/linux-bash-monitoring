#!/bin/bash

# ==============================================================
# IBMEC - Sistemas Operacionais
# Script: Monitor de Sistema
# Alunos: Arthur Riess Cunha e Bernardo Cicchelli
# ==============================================================

# -----------------------------------------------
# FUNÇÃO: exibir_cabecalho
# Exibe o cabeçalho padronizado com dados do sistema
# -----------------------------------------------
exibir_cabecalho() {
    clear
    SEMESTRE=$(date +"%m")
    if [ "$SEMESTRE" -le 6 ]; then
        SEM="1"
    else
        SEM="2"
    fi
    ANO=$(date +"%Y")
    DIA=$(date +"%d")
    MES=$(date +"%B")
    HORA=$(date +"%H")
    MIN=$(date +"%M")

    echo "###############################################################"
    echo "# IBMEC                                                       #"
    printf "# Sistemas Operacionais              Semestre %s de %s       #\n" "$SEM" "$ANO"
    echo "# Código: IBM8940                    Turma: 8001              #"
    echo "# Professor: Luiz Fernando T. de Farias                       #"
    echo "#-------------------------------------------------------------#"
    echo "# Equipe Desenvolvedora:                                      #"
    echo "# Aluno: Arthur Riess Cunha                                   #"
    echo "# Aluno: Bernardo Cicchelli                                   #"
    echo "#-------------------------------------------------------------#"
    printf "# Rio de Janeiro, %s de %s de %s                           #\n" "$DIA" "$MES" "$ANO"
    printf "# Hora do Sistema: %s Horas e %s Minutos                      #\n" "$HORA" "$MIN"
    echo "###############################################################"
    echo ""
}

# -----------------------------------------------
# FUNÇÃO: exibir_menu
# Exibe o menu principal de escolhas
# -----------------------------------------------
exibir_menu() {
    exibir_cabecalho
    echo "Menu de Escolhas:"
    echo "  1) Informações Gerais do Sistema"
    echo "  2) Monitorar CPU"
    echo "  3) Monitorar Memória"
    echo "  4) Verificar Espaço em Disco"
    echo "  5) Gerenciar Processos"
    echo "  6) Finalizar o programa."
    echo ""
    echo -n "Selecione uma opção: "
}

# -----------------------------------------------
# FUNÇÃO: pausar
# Aguarda o usuário pressionar Enter para continuar
# -----------------------------------------------
pausar() {
    echo ""
    echo -n "Pressione Enter para voltar ao menu..."
    read
}

# -----------------------------------------------
# FUNÇÃO: opcao_1_info_sistema
# Exibe informações gerais do sistema operacional
# Comandos: hostname, uptime, whoami, ip, uname
# -----------------------------------------------
opcao_1_info_sistema() {
    exibir_cabecalho
    echo "=== INFORMAÇÕES GERAIS DO SISTEMA ==="
    echo ""
    echo "Nome da Máquina    : $(hostname)"
    echo "Usuário Logado     : $(whoami)"
    echo "Sistema Operacional: $(uname -o)"
    echo "Versão do Kernel   : $(uname -r)"
    echo "Arquitetura        : $(uname -m)"
    echo "Uptime             : $(uptime -p)"
    echo "IP Local           : $(ip route get 1.1.1.1 2>/dev/null | awk '{print $7; exit}' || echo 'Não disponível')"
    echo "Data e Hora Atual  : $(date '+%d/%m/%Y %H:%M:%S')"
    echo ""
    pausar
}

# -----------------------------------------------
# FUNÇÃO: submenu_cpu
# Sub-menu com opções de monitoramento de CPU
# -----------------------------------------------
submenu_cpu() {
    while true; do
        exibir_cabecalho
        echo "=== MONITORAR CPU ==="
        echo ""
        echo "  1) Ver modelo do processador"
        echo "  2) Ver número de núcleos"
        echo "  3) Ver uso atual da CPU"
        echo "  4) Voltar ao menu principal"
        echo ""
        echo -n "Selecione uma opção: "
        read opcao_cpu

        case $opcao_cpu in
            1)
                echo ""
                echo "--- Modelo do Processador ---"
                grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //'
                pausar
                ;;
            2)
                echo ""
                echo "--- Núcleos do Processador ---"
                NUCLEOS=$(grep -c "processor" /proc/cpuinfo)
                echo "Total de núcleos: $NUCLEOS"
                pausar
                ;;
            3)
                echo ""
                echo "--- Uso Atual da CPU ---"
                USO=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
                echo "Uso atual da CPU: ${USO}%"
                pausar
                ;;
            4)
                break
                ;;
            *)
                echo "Opção inválida!"
                pausar
                ;;
        esac
    done
}

# -----------------------------------------------
# FUNÇÃO: submenu_memoria
# Sub-menu com opções de monitoramento de memória
# Comandos: free, awk
# -----------------------------------------------
submenu_memoria() {
    while true; do
        exibir_cabecalho
        echo "=== MONITORAR MEMÓRIA ==="
        echo ""
        echo "  1) Ver uso de RAM"
        echo "  2) Ver uso de Swap"
        echo "  3) Voltar ao menu principal"
        echo ""
        echo -n "Selecione uma opção: "
        read opcao_mem

        case $opcao_mem in
            1)
                echo ""
                echo "--- Uso de Memória RAM ---"
                free -h | awk 'NR==1 || NR==2 {printf "%-12s %8s %8s %8s\n", $1, $2, $3, $4}'
                pausar
                ;;
            2)
                echo ""
                echo "--- Uso de Swap ---"
                free -h | awk 'NR==1 || NR==3 {printf "%-12s %8s %8s %8s\n", $1, $2, $3, $4}'
                pausar
                ;;
            3)
                break
                ;;
            *)
                echo "Opção inválida!"
                pausar
                ;;
        esac
    done
}

# -----------------------------------------------
# FUNÇÃO: submenu_disco
# Sub-menu com opções de verificação de disco
# Comandos: df, du, awk
# -----------------------------------------------
submenu_disco() {
    while true; do
        exibir_cabecalho
        echo "=== VERIFICAR ESPAÇO EM DISCO ==="
        echo ""
        echo "  1) Listar todas as partições"
        echo "  2) Ver tamanho de um diretório específico"
        echo "  3) Verificar partições com uso acima de X%"
        echo "  4) Voltar ao menu principal"
        echo ""
        echo -n "Selecione uma opção: "
        read opcao_disco

        case $opcao_disco in
            1)
                echo ""
                echo "--- Partições do Sistema ---"
                df -h --output=source,size,used,avail,pcent,target | grep -v "tmpfs\|udev\|Filesystem" | awk 'NR==1{print "DISPOSITIVO      TOTAL    USADO   LIVRE   USO%  PONTO DE MONTAGEM"} NR>0{print}'
                df -h | grep -v "tmpfs\|udev"
                pausar
                ;;
            2)
                echo ""
                echo -n "Digite o caminho do diretório (ex: /home): "
                read DIRETORIO
                if [ -d "$DIRETORIO" ]; then
                    echo ""
                    echo "--- Tamanho de $DIRETORIO ---"
                    du -sh "$DIRETORIO" 2>/dev/null
                else
                    echo "Diretório não encontrado: $DIRETORIO"
                fi
                pausar
                ;;
            3)
                echo ""
                echo -n "Digite o percentual limite (ex: 70): "
                read LIMITE_DISCO
                if ! echo "$LIMITE_DISCO" | grep -qE '^[0-9]+$'; then
                    echo "Valor inválido! Digite apenas números."
                    pausar
                    continue
                fi
                echo ""
                echo "--- Partições com uso acima de ${LIMITE_DISCO}% ---"
                RESULTADO_DISCO=$(df -h | awk -v limite="$LIMITE_DISCO" 'NR>1 {
                    gsub(/%/, "", $5)
                    if ($5+0 >= limite+0) print $0
                }')
                if [ -z "$RESULTADO_DISCO" ]; then
                    echo "Nenhuma partição com uso acima de ${LIMITE_DISCO}%."
                else
                    echo "$RESULTADO_DISCO"
                fi
                pausar
                ;;
            4)
                break
                ;;
            *)
                echo "Opção inválida!"
                pausar
                ;;
        esac
    done
}

# -----------------------------------------------
# FUNÇÃO: submenu_processos
# Sub-menu para gerenciamento de processos
# Comandos: ps, grep, kill, awk
# -----------------------------------------------
submenu_processos() {
    while true; do
        exibir_cabecalho
        echo "=== GERENCIAR PROCESSOS ==="
        echo ""
        echo "  1) Listar top N processos por uso de CPU"
        echo "  2) Buscar processo por nome"
        echo "  3) Encerrar processo por PID"
        echo "  4) Voltar ao menu principal"
        echo ""
        echo -n "Selecione uma opção: "
        read opcao_proc

        case $opcao_proc in
            1)
                echo ""
                echo -n "Quantos processos deseja listar? "
                read N
                if ! echo "$N" | grep -qE '^[0-9]+$'; then
                    echo "Valor inválido! Digite apenas números."
                    pausar
                    continue
                fi
                echo ""
                echo "--- Top $N Processos por CPU ---"
                ps aux --sort=-%cpu | awk 'NR==1 || NR<='"$N+1"'' | awk '{printf "%-10s %-8s %-6s %-6s %s\n", $1, $2, $3, $4, $11}'
                echo ""
                echo "(Colunas: USUÁRIO | PID | %CPU | %MEM | COMANDO)"
                pausar
                ;;
            2)
                echo ""
                echo -n "Digite o nome do processo: "
                read NOME_PROC
                echo ""
                echo "--- Processos com nome '$NOME_PROC' ---"
                RESULTADO=$(ps aux | awk -v proc="$NOME_PROC" '$11 ~ proc {printf "PID: %-8s CPU: %-6s MEM: %-6s CMD: %s\n", $2, $3, $4, $11}')
                if [ -z "$RESULTADO" ]; then
                    echo "Nenhum processo encontrado com esse nome."
                else
                    echo "$RESULTADO"
                fi
                pausar
                ;;
            3)
                echo ""
                echo -n "Digite o PID do processo a encerrar: "
                read PID_PROC
                if ! echo "$PID_PROC" | grep -qE '^[0-9]+$'; then
                    echo "PID inválido! Digite apenas números."
                    pausar
                    continue
                fi
                if ps -p "$PID_PROC" > /dev/null 2>&1; then
                    kill "$PID_PROC"
                    echo "Processo $PID_PROC encerrado com sucesso."
                else
                    echo "Processo com PID $PID_PROC não encontrado."
                fi
                pausar
                ;;
            4)
                break
                ;;
            *)
                echo "Opção inválida!"
                pausar
                ;;
        esac
    done
}

# -----------------------------------------------
# LOOP PRINCIPAL
# Mantém o programa rodando até o usuário escolher
# a opção 6 (Finalizar) — única forma de sair
# -----------------------------------------------
while true; do
    exibir_menu
    read OPCAO

    case $OPCAO in
        1) opcao_1_info_sistema ;;
        2) submenu_cpu ;;
        3) submenu_memoria ;;
        4) submenu_disco ;;
        5) submenu_processos ;;
        6)
            exibir_cabecalho
            echo "Programa encerrado. Até logo!"
            echo ""
            exit 0
            ;;
        *)
            echo ""
            echo "Opção inválida! Tente novamente."
            pausar
            ;;
    esac
done