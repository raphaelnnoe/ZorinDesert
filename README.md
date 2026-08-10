# ZorinDesert Desktop Theme / Tema de Área de Trabalho ZorinDesert

[English](#english) | [Português](#português)

---

<a name="english"></a>
## 🇬🇧 English

**ZorinDesert** is a clean, modern desktop theme available in both **Dark** (`ZorinDesert-Dark`) and **Light** (`ZorinDesert-Light`) variants. It is crafted for **Zorin OS**, **GNOME**, **XFCE**, **Cinnamon**, and other GTK-based Linux desktop environments.

### 🎨 Theme Features

- **GTK 2.0 / 3.0 / 4.0** support.
- **GNOME Shell** & **XFWM4** window manager themes.
- **Libadwaita / GTK4** compatibility support for modern GNOME applications.
- **Safe & Non-Destructive Uninstallation**: Deletes ONLY the `ZorinDesert` theme folders (`ZorinDesert-Dark` and `ZorinDesert-Light`). Any other themes installed in `~/.themes` or `~/.local/share/themes` are **100% preserved**.
- **Automatic Backup & Restore**: Installing for Libadwaita (`-l`) automatically creates a backup of your existing `~/.config/gtk-4.0` files (`gtk.css`, `gtk-dark.css`, `assets`), allowing clean restoration upon uninstallation (`-r`).

---

### 🚀 Quick Start & Installation

Open your terminal in the theme directory and make sure the installation script is executable:

```bash
cd ZorinDesert
chmod +x install.sh
```

#### 1. Interactive Menu (Recommended)

Run the installer without arguments to launch the interactive terminal menu:

```bash
./install.sh
```

Menu options:
1. **User Installation (`~/.themes`)**: Installs ZorinDesert themes for the current user.
2. **Libadwaita / GTK4 (`~/.config/gtk-4.0`) - Dark**: Backs up existing GTK4 configs and copies `ZorinDesert-Dark` GTK4 assets.
3. **Libadwaita / GTK4 (`~/.config/gtk-4.0`) - Light**: Backs up existing GTK4 configs and copies `ZorinDesert-Light` GTK4 assets.
4. **System-wide Installation (`/usr/share/themes`)**: Installs themes for all system users (requires `sudo`).
5. **Install & Apply Dark Theme**: Installs themes and sets `ZorinDesert-Dark` as active.
6. **Install & Apply Light Theme**: Installs themes and sets `ZorinDesert-Light` as active.
7. **Uninstall**: Removes ONLY ZorinDesert themes and **restores original `~/.config/gtk-4.0` backup** (other themes are kept).
8. **Exit**.

#### 2. Command Line Flags

| Flag | Description |
| :--- | :--- |
| `-u`, `--user` | Install ZorinDesert themes to user directories (`~/.themes` & `~/.local/share/themes`) |
| `-l`, `--libadwaita [dark\|light]` | Install Libadwaita/GTK4 assets to `~/.config/gtk-4.0` (with auto-backup to `~/.config/.zorindesert-backup`) |
| `-s`, `--system` | Install themes system-wide to `/usr/share/themes` (requires `sudo`) |
| `--apply-dark` | Install user themes and set `ZorinDesert-Dark` as active |
| `--apply-light` | Install user themes and set `ZorinDesert-Light` as active |
| `-r`, `--remove` | Uninstall ONLY ZorinDesert themes and restore backed up `~/.config/gtk-4.0` settings |
| `-h`, `--help` | Display script usage help |

#### Examples

- **Install for current user:**
  ```bash
  ./install.sh -u
  ```

- **Enable Libadwaita / GTK4 support (Dark Mode):**
  ```bash
  ./install.sh -l dark
  ```

- **Enable Libadwaita / GTK4 support (Light Mode):**
  ```bash
  ./install.sh -l light
  ```

- **Uninstall ZorinDesert & Restore original settings:**
  ```bash
  ./install.sh -r
  ```

---

<a name="português"></a>
## 🇧🇷 Português

**ZorinDesert** é um tema de área de trabalho moderno disponível nas variantes **Dark** (`ZorinDesert-Dark`) e **Light** (`ZorinDesert-Light`). Foi desenvolvido para **Zorin OS**, **GNOME**, **XFCE**, **Cinnamon** e outros ambientes Linux baseados em GTK.

### 🎨 Recursos do Tema

- Suporte a **GTK 2.0 / 3.0 / 4.0**.
- Temas para **GNOME Shell** e gerenciador de janelas **XFWM4**.
- Suporte a aplicações **Libadwaita / GTK4**.
- **Desinstalação Segura**: Remove APENAS os temas `ZorinDesert` (`ZorinDesert-Dark` e `ZorinDesert-Light`). Qualquer outro tema instalado em `~/.themes` ou `~/.local/share/themes` permanece **100% intacto**.
- **Backup e Restauração Automática**: A instalação para Libadwaita (`-l`) cria um backup automático dos arquivos em `~/.config/gtk-4.0` (`gtk.css`, `gtk-dark.css`, `assets`), permitindo restaurá-los ao desinstalar (`-r`).

---

### 🚀 Instalação Rápida

Abra o terminal na pasta do tema e garanta a permissão de execução:

```bash
cd ZorinDesert
chmod +x install.sh
```

#### 1. Menu Interativo (Recomendado)

Execute o script sem argumentos para abrir o menu no terminal:

```bash
./install.sh
```

Opções do menu:
1. **Instalar para o Usuário (`~/.themes`)**: Instala os temas ZorinDesert para o usuário atual.
2. **Libadwaita / GTK4 (`~/.config/gtk-4.0`) - Dark**: Cria backup e instala os arquivos do `ZorinDesert-Dark`.
3. **Libadwaita / GTK4 (`~/.config/gtk-4.0`) - Light**: Cria backup e instala os arquivos do `ZorinDesert-Light`.
4. **Instalar no Sistema (`/usr/share/themes`)**: Instala os temas para todos os usuários (requer `sudo`).
5. **Instalar e Aplicar Tema Escuro**: Instala os temas e define o `ZorinDesert-Dark` como ativo.
6. **Instalar e Aplicar Tema Claro**: Instala os temas e define o `ZorinDesert-Light` como ativo.
7. **Desinstalar**: Remove APENAS os temas ZorinDesert e **restaura o backup de `~/.config/gtk-4.0`** (outros temas são mantidos).
8. **Sair**.

#### 2. Linha de Comando (Flags)

| Opção | Descrição |
| :--- | :--- |
| `-u`, `--user` | Instala os temas ZorinDesert no diretório do usuário (`~/.themes` e `~/.local/share/themes`) |
| `-l`, `--libadwaita [dark\|light]` | Instala arquivos Libadwaita/GTK4 em `~/.config/gtk-4.0` (com backup em `~/.config/.zorindesert-backup`) |
| `-s`, `--system` | Instala os temas no sistema todo em `/usr/share/themes` (requer `sudo`) |
| `--apply-dark` | Instala e aplica o tema `ZorinDesert-Dark` |
| `--apply-light` | Instala e aplica o tema `ZorinDesert-Light` |
| `-r`, `--remove` | Desinstala APENAS o ZorinDesert e restaura os arquivos originais de `~/.config/gtk-4.0` |
| `-h`, `--help` | Exibe a ajuda do script |

#### Exemplos

- **Instalar para o usuário atual:**
  ```bash
  ./install.sh -u
  ```

- **Ativar suporte Libadwaita / GTK4 (Modo Escuro):**
  ```bash
  ./install.sh -l dark
  ```

- **Ativar suporte Libadwaita / GTK4 (Modo Claro):**
  ```bash
  ./install.sh -l light
  ```

- **Desinstalar o ZorinDesert e restaurar configurações originais:**
  ```bash
  ./install.sh -r
  ```
