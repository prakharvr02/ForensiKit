#!/bin/bash

# Colors for styling
GREEN="\e[32m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

# Function to install a tool from GitHub or APT
install_tool() {
    local tool_name=$1
    echo -e "${CYAN}Installing $tool_name...${RESET}"
    
    # Example: GitHub-based installation for some tools
    case $tool_name in
        "autopsy")
            sudo apt-get install -y autopsy
            ;;
        "sleuthkit")
            sudo apt-get install -y sleuthkit
            ;;
        "volatility")
            sudo apt-get install -y volatility
            ;;
        "wireshark")
            sudo apt-get install -y wireshark
            ;;
        "chkrootkit")
            sudo apt-get install -y chkrootkit
            ;;
        "foremost")
            sudo apt-get install -y foremost
            ;;
        "exiftool")
            sudo apt-get install -y libimage-exiftool-perl
            ;;
        "binwalk")
            sudo apt-get install -y binwalk
            ;;
        "testdisk")
            sudo apt-get install -y testdisk
            ;;
        "hashdeep")
            sudo apt-get install -y hashdeep
            ;;
        "dcfldd")
            sudo apt-get install -y dcfldd
            ;;
        "caine")
            sudo apt-get install -y caine
            ;;
        "ftkimager")
            sudo apt-get install -y ftkimager
            ;;
        "rkhunter")
            sudo apt-get install -y rkhunter
            ;;
        "ssh")
            sudo apt-get install -y openssh-client
            ;;
        *)
            echo -e "${RED}Unknown tool $tool_name. Skipping...${RESET}"
            ;;
    esac
}

# Function to install all tools at once
install_all_tools() {
    echo -e "${GREEN}Starting installation of all tools...${RESET}"
    install_tool "autopsy"
    install_tool "sleuthkit"
    install_tool "volatility"
    install_tool "wireshark"
    install_tool "chkrootkit"
    install_tool "foremost"
    install_tool "exiftool"
    install_tool "binwalk"
    install_tool "testdisk"
    install_tool "hashdeep"
    install_tool "dcfldd"
    install_tool "caine"
    install_tool "ftkimager"
    install_tool "rkhunter"
    install_tool "ssh"
    echo -e "${GREEN}All tools have been installed successfully!${RESET}"
}

# Welcome Banner
echo -e "${CYAN}#############################################"
echo -e "#       All-in-One Digital Forensics Tool   #"
echo -e "#############################################${RESET}"

# Ask user if they want to install all tools at once
echo -e "${GREEN}Would you like to install all the forensic tools now? (y/n)${RESET}"
read -p "Enter your choice: " install_choice

if [[ "$install_choice" == "y" || "$install_choice" == "Y" ]]; then
    install_all_tools
fi

# Function to display the menu
show_menu() {
    echo -e "\n${GREEN}Select a Tool:${RESET}"
    echo "1. Autopsy (GUI)"
    echo "2. Sleuth Kit (File Analysis)"
    echo "3. Volatility (Memory Analysis)"
    echo "4. Wireshark (Network Analysis)"
    echo "5. Chkrootkit (Rootkit Detection)"
    echo "6. Foremost (File Recovery)"
    echo "7. ExifTool (Metadata Analysis)"
    echo "8. Binwalk (Binary Analysis)"
    echo "9. TestDisk (Partition Recovery)"
    echo "10. Hashdeep (File Hashing)"
    echo "11. dcfldd (Forensic Disk Imaging)"
    echo "12. Caine (GUI Forensic Suite)"
    echo "13. FTK Imager (Imaging and Analysis)"
    echo "14. RKHunter (Rootkit Detection)"
    echo "15. OpenSSH (Remote Access)"
    echo "16. Exit"
}

# Loop for menu
while true; do
    show_menu
    read -p "Enter your choice [1-16]: " choice

    case $choice in
        1)
            echo -e "${CYAN}Starting Autopsy...${RESET}"
            autopsy &
            ;;
        2)
            echo -e "${CYAN}Launching Sleuth Kit...${RESET}"
            read -p "Enter file/disk image for analysis: " file
            fls $file
            ;;
        3)
            echo -e "${CYAN}Launching Volatility...${RESET}"
            read -p "Enter memory dump file: " mem_file
            volatility -f $mem_file imageinfo
            ;;
        4)
            echo -e "${CYAN}Launching Wireshark...${RESET}"
            wireshark &
            ;;
        5)
            echo -e "${CYAN}Scanning for rootkits with Chkrootkit...${RESET}"
            chkrootkit
            ;;
        6)
            echo -e "${CYAN}Recovering files with Foremost...${RESET}"
            read -p "Enter file/image for recovery: " file
            foremost -i $file -o recovered_files/
            echo "Recovered files saved in 'recovered_files/'"
            ;;
        7)
            echo -e "${CYAN}Analyzing metadata with ExifTool...${RESET}"
            read -p "Enter file for metadata analysis: " file
            exiftool $file
            ;;
        8)
            echo -e "${CYAN}Analyzing binaries with Binwalk...${RESET}"
            read -p "Enter binary file: " file
            binwalk $file
            ;;
        9)
            echo -e "${CYAN}Recovering partitions with TestDisk...${RESET}"
            testdisk
            ;;
        10)
            echo -e "${CYAN}Generating file hashes with Hashdeep...${RESET}"
            read -p "Enter directory to hash: " dir
            hashdeep -r $dir
            ;;
        11)
            echo -e "${CYAN}Imaging disk with dcfldd...${RESET}"
            read -p "Enter source device (e.g., /dev/sda): " src
            read -p "Enter output file: " out
            dcfldd if=$src of=$out
            echo "Image saved as $out"
            ;;
        12)
            echo -e "${CYAN}Launching Caine...${RESET}"
            caine &
            ;;
        13)
            echo -e "${CYAN}Launching FTK Imager...${RESET}"
            ftkimager &
            ;;
        14)
            echo -e "${CYAN}Scanning for rootkits with RKHunter...${RESET}"
            rkhunter --check
            ;;
        15)
            echo -e "${CYAN}Starting OpenSSH for remote access...${RESET}"
            read -p "Enter username@hostname: " remote
            ssh $remote
            ;;
        16)
            echo -e "${RED}Exiting... Goodbye!${RESET}"
            break
            ;;
        *)
            echo -e "${RED}Invalid choice, please try again.${RESET}"
            ;;
    esac
done
