#!/usr/bin/env bash

# ==============================================================================
# Script de Instalação do Tema ZorinDesert (Dark & Light)
# Suporta Zorin OS, GNOME, Libadwaita / GTK4, XFCE, Cinnamon e GTK.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_DARK="ZorinDesert-Dark"
THEME_LIGHT="ZorinDesert-Light"

USER_THEME_DIR="$HOME/.themes"
USER_LOCAL_THEME_DIR="$HOME/.local/share/themes"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config/.zorindesert-backup"
SYSTEM_THEME_DIR="/usr/share/themes"

# Cores para o terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

print_banner() {
    echo -e "${BOLD}${BLUE}"
    echo "=========================================="
    echo "    Instalador do Tema ZorinDesert       "
    echo "=========================================="
    echo -e "${NC}"
}

usage() {
    echo -e "${BOLD}Uso:${NC} $0 [OPÇÕES]"
    echo ""
    echo "Opções:"
    echo "  -u, --user                     Instala os temas no diretório do usuário (~/.themes e ~/.local/share/themes) [Padrão]"
    echo "  -l, --libadwaita [dark|light]  Instala/copia os arquivos do tema para $HOME/.config/gtk-4.0 para suporte a Libadwaita / GTK4 (com backup automático)"
    echo "  -s, --system                   Instala os temas no sistema todo (/usr/share/themes - requer sudo)"
    echo "  --apply-dark                   Instala e aplica o tema ZorinDesert-Dark"
    echo "  --apply-light                  Instala e aplica o tema ZorinDesert-Light"
    echo "  -r, --remove                   Desinstala APENAS o ZorinDesert e restaura o backup prévio de ~/.config/gtk-4.0"
    echo "  -h, --help                     Exibe esta mensagem de ajuda"
    echo ""
}

check_sources() {
    if [[ ! -d "$SCRIPT_DIR/$THEME_DARK" ]] || [[ ! -d "$SCRIPT_DIR/$THEME_LIGHT" ]]; then
        print_error "Pastas de temas não encontradas em $SCRIPT_DIR."
        print_error "Certifique-se de que '$THEME_DARK' e '$THEME_LIGHT' estejam na mesma pasta que o script."
        exit 1
    fi
}

install_user() {
    print_info "Instalando temas para o usuário atual ($USER)..."
    
    mkdir -p "$USER_THEME_DIR"
    mkdir -p "$USER_LOCAL_THEME_DIR"

    # Copia apenas as pastas do tema ZorinDesert para ~/.themes
    cp -rf "$SCRIPT_DIR/$THEME_DARK" "$USER_THEME_DIR/"
    cp -rf "$SCRIPT_DIR/$THEME_LIGHT" "$USER_THEME_DIR/"
    
    # Copia apenas as pastas do tema ZorinDesert para ~/.local/share/themes
    cp -rf "$SCRIPT_DIR/$THEME_DARK" "$USER_LOCAL_THEME_DIR/"
    cp -rf "$SCRIPT_DIR/$THEME_LIGHT" "$USER_LOCAL_THEME_DIR/"

    print_success "Temas ZorinDesert instalados com sucesso em:"
    echo "  -> $USER_THEME_DIR"
    echo "  -> $USER_LOCAL_THEME_DIR"
}

install_libadwaita() {
    local theme_name="${1:-$THEME_DARK}"

    print_info "Instalando suporte Libadwaita / GTK4 em $CONFIG_DIR/gtk-4.0 ($theme_name)..."
    
    # Criar backup apenas dos arquivos que serão sobrescritos em ~/.config/gtk-4.0
    if [ ! -d "$BACKUP_DIR" ]; then
        print_info "Criando backup dos arquivos atuais de ~/.config/gtk-4.0 em $BACKUP_DIR..."
        mkdir -p "$BACKUP_DIR/gtk-4.0"
        
        for item in gtk.css gtk-dark.css assets .libadwaita; do
            if [ -e "$CONFIG_DIR/gtk-4.0/$item" ]; then
                cp -rf "$CONFIG_DIR/gtk-4.0/$item" "$BACKUP_DIR/gtk-4.0/"
            fi
        done
        print_success "Backup dos arquivos originais criado em $BACKUP_DIR"
    else
        print_info "Backup prévio encontrado em $BACKUP_DIR (preservado)."
    fi

    mkdir -p "$CONFIG_DIR/gtk-4.0"

    # Copia o conteúdo de gtk-4.0 do tema selecionado para ~/.config/gtk-4.0/
    if [ -d "$SCRIPT_DIR/$theme_name/gtk-4.0" ]; then
        cp -rf "$SCRIPT_DIR/$theme_name/gtk-4.0/"* "$CONFIG_DIR/gtk-4.0/"
    fi

    print_success "Arquivos para Libadwaita/GTK4 ($theme_name) copiados com sucesso para $CONFIG_DIR/gtk-4.0!"
}

install_system() {
    print_info "Instalando temas para todos os usuários do sistema ($SYSTEM_THEME_DIR)..."
    
    if [ "$EUID" -ne 0 ]; then
        print_info "Solicitando privilégios administrativos (sudo)..."
        SUDO="sudo"
    else
        SUDO=""
    fi

    $SUDO mkdir -p "$SYSTEM_THEME_DIR"
    $SUDO cp -rf "$SCRIPT_DIR/$THEME_DARK" "$SYSTEM_THEME_DIR/"
    $SUDO cp -rf "$SCRIPT_DIR/$THEME_LIGHT" "$SYSTEM_THEME_DIR/"

    print_success "Temas instalados com sucesso em $SYSTEM_THEME_DIR!"
}

apply_theme() {
    local theme_name="$1"
    local color_scheme="$2" # "prefer-dark" ou "default"

    print_info "Aplicando o tema '$theme_name'..."
    
    # Suporte para GNOME / Zorin Desktop via gsettings
    if command -v gsettings &>/dev/null; then
        gsettings set org.gnome.desktop.interface gtk-theme "$theme_name" 2>/dev/null || true
        
        if [ -n "$color_scheme" ]; then
            gsettings set org.gnome.desktop.interface color-scheme "$color_scheme" 2>/dev/null || true
        fi

        # Define o tema do Shell se a extensão user-theme estiver disponível
        gsettings set org.gnome.shell.extensions.user-theme name "$theme_name" 2>/dev/null || true
    fi

    # Suporte para XFCE (Zorin OS Lite)
    if command -v xfconf-query &>/dev/null; then
        xfconf-query -c xsettings -p /Net/ThemeName -s "$theme_name" 2>/dev/null || true
        xfconf-query -c xfwm4 -p /general/theme -s "$theme_name" 2>/dev/null || true
    fi

    print_success "Tema '$theme_name' aplicado com sucesso!"
}

uninstall_theme() {
    print_info "Removendo APENAS o tema ZorinDesert..."
    
    # Removendo APENAS as pastas ZorinDesert-Dark e ZorinDesert-Light das pastas de temas do usuário
    rm -rf "$USER_THEME_DIR/$THEME_DARK" "$USER_THEME_DIR/$THEME_LIGHT" 2>/dev/null || true
    rm -rf "$USER_LOCAL_THEME_DIR/$THEME_DARK" "$USER_LOCAL_THEME_DIR/$THEME_LIGHT" 2>/dev/null || true

    # Removendo os arquivos específicos do ZorinDesert em ~/.config/gtk-4.0
    rm -rf "$CONFIG_DIR/gtk-4.0/gtk.css" \
           "$CONFIG_DIR/gtk-4.0/gtk-dark.css" \
           "$CONFIG_DIR/gtk-4.0/assets" \
           "$CONFIG_DIR/gtk-4.0/.libadwaita" 2>/dev/null || true

    # Restaurar backup de ~/.config/gtk-4.0 se existir
    if [ -d "$BACKUP_DIR" ]; then
        print_info "Restaurando arquivos originais de ~/.config/gtk-4.0 a partir do backup..."
        if [ -d "$BACKUP_DIR/gtk-4.0" ]; then
            cp -rf "$BACKUP_DIR/gtk-4.0/"* "$CONFIG_DIR/gtk-4.0/" 2>/dev/null || true
        fi
        rm -rf "$BACKUP_DIR"
        print_success "Arquivos originais de ~/.config/gtk-4.0 restaurados com sucesso!"
    fi

    # Removendo APENAS as pastas ZorinDesert instaladas no sistema todo
    if [ -d "$SYSTEM_THEME_DIR/$THEME_DARK" ] || [ -d "$SYSTEM_THEME_DIR/$THEME_LIGHT" ]; then
        if [ "$EUID" -eq 0 ]; then
            rm -rf "$SYSTEM_THEME_DIR/$THEME_DARK" "$SYSTEM_THEME_DIR/$THEME_LIGHT" 2>/dev/null || true
        elif sudo -n true 2>/dev/null; then
            sudo rm -rf "$SYSTEM_THEME_DIR/$THEME_DARK" "$SYSTEM_THEME_DIR/$THEME_LIGHT" 2>/dev/null || true
        else
            print_warning "Para remover os temas de $SYSTEM_THEME_DIR, execute: sudo ./install.sh -r"
        fi
    fi

    print_success "Tema ZorinDesert desinstalado com sucesso! Outros temas permanecem intocados."
}

interactive_menu() {
    print_banner
    echo "Escolha uma opção de instalação:"
    echo "  1) Instalar para o usuário atual (~/.themes) [Recomendado]"
    echo "  2) Instalar Libadwaita / GTK4 em ~/.config/gtk-4.0 (ZorinDesert-Dark) [Com Backup]"
    echo "  3) Instalar Libadwaita / GTK4 em ~/.config/gtk-4.0 (ZorinDesert-Light) [Com Backup]"
    echo "  4) Instalar no sistema todo (/usr/share/themes - requer sudo)"
    echo "  5) Instalar e aplicar tema escuro (ZorinDesert-Dark)"
    echo "  6) Instalar e aplicar tema claro (ZorinDesert-Light)"
    echo "  7) Desinstalar APENAS o tema ZorinDesert (Restaura o Backup de ~/.config/gtk-4.0)"
    echo "  8) Sair"
    echo ""
    read -rp "Opção [1-8]: " choice

    case "$choice" in
        1)
            check_sources
            install_user
            ;;
        2)
            check_sources
            install_libadwaita "$THEME_DARK"
            ;;
        3)
            check_sources
            install_libadwaita "$THEME_LIGHT"
            ;;
        4)
            check_sources
            install_system
            ;;
        5)
            check_sources
            install_user
            apply_theme "$THEME_DARK" "prefer-dark"
            ;;
        6)
            check_sources
            install_user
            apply_theme "$THEME_LIGHT" "default"
            ;;
        7)
            uninstall_theme
            ;;
        8)
            echo "Saindo..."
            exit 0
            ;;
        *)
            print_error "Opção inválida."
            exit 1
            ;;
    esac
}

# Processamento de Argumentos CLI
if [ $# -eq 0 ]; then
    interactive_menu
else
    check_sources
    while [ $# -gt 0 ]; do
        case "$1" in
            -u|--user)
                install_user
                shift
                ;;
            -l|--libadwaita)
                if [[ "$2" == "light" || "$2" == "Light" ]]; then
                    install_libadwaita "$THEME_LIGHT"
                    shift 2
                elif [[ "$2" == "dark" || "$2" == "Dark" ]]; then
                    install_libadwaita "$THEME_DARK"
                    shift 2
                else
                    install_libadwaita "$THEME_DARK"
                    shift
                fi
                ;;
            -s|--system)
                install_system
                shift
                ;;
            --apply-dark)
                install_user
                apply_theme "$THEME_DARK" "prefer-dark"
                shift
                ;;
            --apply-light)
                install_user
                apply_theme "$THEME_LIGHT" "default"
                shift
                ;;
            -r|--remove)
                uninstall_theme
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                print_error "Opção desconhecida: $1"
                usage
                exit 1
                ;;
        esac
    done
fi
