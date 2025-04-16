#!/bin/bash

# ASCII art banner
# Clear screen first
echo "
██████╗ ██╗  ██╗██╗██╗   ██╗██╗   ██╗███████╗███████╗
██╔══██╗╚██╗██╔╝██║╚██╗ ██╔╝██║   ██║╚══███╔╝╚══███╔╝
██║  ██║ ╚███╔╝ ██║ ╚████╔╝ ██║   ██║  ███╔╝   ███╔╝ 
██║  ██║ ██╔██╗ ██║  ╚██╔╝  ██║   ██║ ███╔╝   ███╔╝  
██████╔╝██╔╝ ██╗██║   ██║   ╚██████╔╝███████╗███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚══════╝
                Advanced Nmap Scanner v2.0
"

# Check if nmap is installed
if ! command -v nmap &> /dev/null; then
    echo "[-] Nmap is not installed. Please install it first."
    exit 1
fi

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo "[-] Please run as root"
    exit 1
fi

# Function to display menu
show_menu() {
    echo
    echo "Select scanning mode:"
    echo "1) Normal Scan (-sCV)"
    echo "2) Brutal Scan (-p- -sCV --min-rate 1000)"
    echo "3) Normal Scan + Vuln (-sCV --script vuln)"
    echo "4) Brutal Scan + Vuln (-p- -sCV --min-rate 1000 --script vuln)"
    echo "5) Run All Scans"
    echo "6) Exit"
    echo
}

# Function to run scan with error handling
run_scan() {
    local scan_type=$1
    local scan_command=$2
    local output_file=$3

    echo "[+] Running $scan_type..."
    echo "[+] Command: nmap $scan_command $TARGET"
    
    # Create temporary directory if it doesn't exist
    mkdir -p "$(dirname "$output_file")" 2>/dev/null
    
    # Run nmap with error handling
    if nmap $scan_command "$TARGET" -oN "$output_file" 2>"$OUTPUT_DIR/error.log"; then
        echo "[+] $scan_type completed successfully"
    else
        echo "[-] Error during $scan_type scan. Check error.log for details"
    fi
    echo "----------------------------------------"
}

# Check if IP address is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <ip_address>"
    echo "Example: $0 10.1.2.157"
    exit 1
fi

# Target IP
TARGET=$1

# Create output directory with timestamp and proper permissions
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="/tmp/nmap_scan_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"
chmod 755 "$OUTPUT_DIR"

echo "[+] Target: $TARGET"
echo "[+] Results will be saved in $OUTPUT_DIR"
echo "----------------------------------------"

# Show menu and get user choice
show_menu
read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        run_scan "Normal Scan" "-sCV" "$OUTPUT_DIR/normal_scan.txt"
        ;;
    2)
        run_scan "Brutal Scan" "-p- -sCV --min-rate 1000" "$OUTPUT_DIR/brutal_scan.txt"
        ;;
    3)
        run_scan "Normal Scan + Vuln" "-sCV --script vuln" "$OUTPUT_DIR/normal_vuln_scan.txt"
        ;;
    4)
        run_scan "Brutal Scan + Vuln" "-p- -sCV --min-rate 1000 --script vuln" "$OUTPUT_DIR/brutal_vuln_scan.txt"
        ;;
    5)
        run_scan "Normal Scan" "-sCV" "$OUTPUT_DIR/normal_scan.txt"
        run_scan "Brutal Scan" "-p- -sCV --min-rate 1000" "$OUTPUT_DIR/brutal_scan.txt"
        run_scan "Normal Scan + Vuln" "-sCV --script vuln" "$OUTPUT_DIR/normal_vuln_scan.txt"
        run_scan "Brutal Scan + Vuln" "-p- -sCV --min-rate 1000 --script vuln" "$OUTPUT_DIR/brutal_vuln_scan.txt"
        ;;
    6)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "[-] Invalid choice"
        exit 1
        ;;
esac

# Create summary with error handling
echo "[+] Creating scan summary..."
{
    echo "Scan Summary for $TARGET"
    echo "========================"
    echo "Scan completed at: $(date)"
    echo "Scanned by: 0xiyuzz"
    echo "------------------------"
    
    for scan_file in "$OUTPUT_DIR"/*.txt; do
        if [ -f "$scan_file" ]; then
            echo -e "\nResults from $(basename "$scan_file"):"
            echo "----------------------------------------"
            grep "open" "$scan_file" 2>/dev/null || echo "No open ports found"
            grep -A 5 "VULNERABLE" "$scan_file" 2>/dev/null || echo "No vulnerabilities found"
        fi
    done
} > "$OUTPUT_DIR/summary.txt"

echo "[+] All scans completed! Results saved in $OUTPUT_DIR/"
echo "[+] Check summary.txt for quick overview"