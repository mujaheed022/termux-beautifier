#!/bin/bash

# Termux Beautifier - Customize your Termux interface
# Created by Phantom Tech

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
banner() {
    clear
    echo -e "${GREEN}"
    echo " ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗"
    echo " ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║╚██╗ ██╔╝██║ ██╔╝"
    echo "    ██║   █████╗  ██████╔╝██╔████╔██║ ╚████╔╝ █████╔╝ "
    echo "    ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║  ╚██╔╝  ██╔═██╗ "
    echo "    ██║   ███████╗██║  ██║██║ ╚═╝ ██║   ██║   ██║  ██╗"
    echo "    ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝"
    echo -e "${NC}"
    echo "                     Termux Beautifier"
    echo "                     Created by Phantom Tech"
    echo
}

# Install dependencies
install_dependencies() {
    echo -e "${YELLOW}[*] Installing dependencies...${NC}"
    pkg update -y
    pkg install -y git curl zsh neofetch figlet lolcat
}

# Install Oh-My-Zsh
install_ohmyzsh() {
    echo -e "${BLUE}[*] Installing Oh-My-Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Install Powerlevel10k
install_powerlevel10k() {
    echo -e "${YELLOW}[*] Installing Powerlevel10k theme...${NC}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
}

# Install Dracula theme
install_dracula() {
    echo -e "${YELLOW}[*] Installing Dracula theme...${NC}"
    git clone https://github.com/dracula/zsh.git ~/.oh-my-zsh/custom/themes/dracula
}

# Apply themes
apply_theme() {
    echo -e "${GREEN}[*] Available Themes:${NC}"
    echo "1. Robbyrussell (Default)"
    echo "2. Agnoster"
    echo "3. Dracula"
    echo "4. Powerlevel10k"
    echo -n -e "\n${BLUE}[*] Choose a theme (1-4): ${NC}"
    read theme_choice

    case $theme_choice in
        1) theme="robbyrussell" ;;
        2) theme="agnoster" ;;
        3) 
            theme="dracula"
            if [ ! -d "$HOME/.oh-my-zsh/custom/themes/dracula" ]; then
                install_dracula
            fi
        ;;
        4) 
            theme="powerlevel10k/powerlevel10k"
            if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
                install_powerlevel10k
            fi
        ;;
        *) 
            echo -e "${RED}[!] Invalid choice! Using default theme.${NC}"
            theme="robbyrussell" 
        ;;
    esac

    sed -i "s/ZSH_THEME=.*/ZSH_THEME=\"$theme\"/" ~/.zshrc
    echo -e "${GREEN}[+] Theme applied successfully! Restart Termux or run 'source ~/.zshrc' to see changes.${NC}"
}

# Customize prompt
customize_prompt() {
    echo -e "${BLUE}[*] Customizing your prompt...${NC}"
    echo -e "${GREEN}[*] Enter your custom prompt (e.g., '➜ '): ${NC}"
    read custom_prompt
    echo "export PROMPT='$custom_prompt'" >> ~/.zshrc
    echo -e "${GREEN}[+] Prompt customized successfully!${NC}"
}

# Apply fonts
apply_fonts() {
    echo -e "${BLUE}[*] Applying custom fonts...${NC}"
    mkdir -p ~/.termux
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -o ~/.termux/font.ttf
    termux-reload-settings
    echo -e "${GREEN}[+] Font applied successfully!${NC}"
}

# Main menu
main_menu() {
    while true; do
        echo -e "\n${GREEN}[ Main Menu ]${NC}"
        echo "1. Install Dependencies"
        echo "2. Install Oh-My-Zsh"
        echo "3. Apply Theme"
        echo "4. Customize Prompt"
        echo "5. Apply Custom Fonts"
        echo "6. Exit"
        
        echo -n -e "\n${BLUE}[*] Choose an option: ${NC}"
        read choice
        
        case $choice in
            1) install_dependencies ;;
            2) install_ohmyzsh ;;
            3) apply_theme ;;
            4) customize_prompt ;;
            5) apply_fonts ;;
            6) echo -e "${RED}[+] Exiting...${NC}"; exit 0 ;;
            *) echo -e "${RED}[!] Invalid option!${NC}" ;;
        esac
    done
}

# Initial setup
banner
main_menu
