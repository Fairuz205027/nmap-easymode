# nmap-easymode

---

## **1. How to Use the Script**
### **Basic Syntax**
```bash
sudo ./nmap_advanced.sh <target_ip>
```
**Example**:
```bash
sudo ./nmap_advanced.sh 10.1.2.157
```

### **Step-by-Step Execution**
1. **Ensure Nmap is installed**  
   The script checks automatically. If missing, install Nmap:
   ```bash
   sudo apt install nmap  # Debian/Ubuntu
   ```

2. **Run as root**  
   Nmap requires root privileges for deep scanning (e.g., full port scans).

3. **Select Scan Mode**  
   After execution, a menu appears with 6 options:
   ```
   1) Normal Scan (-sCV)  
   2) Brutal Scan (-p- -sCV --min-rate 1000)  
   3) Normal Scan + Vuln (-sCV --script vuln)  
   4) Brutal Scan + Vuln (-p- -sCV --min-rate 1000 --script vuln)  
   5) Run All Scans  
   6) Exit  
   ```

4. **Results**  
   Outputs are saved in `/tmp/nmap_scan_<timestamp>/`:
   ```
   - normal_scan.txt       # Ops 1 results
   - brutal_scan.txt       # Ops 2 results
   - normal_vuln_scan.txt  # Ops 3 results
   - brutal_vuln_scan.txt  # Ops 4 results
   - summary.txt           # Consolidated report (if Ops 5)
   - error.log             # Errors (if any)
   ```

---

## **2. Key Features**
### **a. Scan Modes**
| Option | Nmap Command | Description |
|--------|-------------|-------------|
| 1      | `-sCV` | Standard scan with version detection and default scripts. |
| 2      | `-p- -sCV --min-rate 1000` | **Full port scan (1-65535)** at high speed. |
| 3      | `-sCV --script vuln` | Standard scan + **vulnerability detection** (CVE checks). |
| 4      | `-p- -sCV --min-rate 1000 --script vuln` | Brutal scan + vuln detection. |
| 5      | - | Runs **all scan modes** sequentially. |

### **b. Additional Features**
- **Error Handling**  
  Errors are logged in `error.log`.
- **Summary Report**  
  `summary.txt` consolidates **open ports** and **vulnerabilities**.
- **Timestamped Outputs**  
  Prevents overwrites with `nmap_scan_<YYYYMMDD_HHMMSS>`.

---

## **3. Example Output**
#### **`summary.txt` Contents**
```plaintext
Scan Summary for 10.1.2.157
========================
Scan completed at: Fri Jun 14 15:30:00 UTC 2024
Scanned by: 0xiyuzz
------------------------

Results from normal_scan.txt:
----------------------------------------
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu
80/tcp open  http    Apache 2.4.41

Results from brutal_vuln_scan.txt:
----------------------------------------
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu
80/tcp open  http    Apache 2.4.41
|_http-vuln-cve2017-5638: VULNERABLE (CVE-2017-5638)
```

---

## **4. Pro Tips**
1. **Brutal Scans (Ops 2/4)** are aggressive. Use only in permitted environments!
2. For **CTF/Pentesting**, use **Ops 3 or 4** for vulnerability checks.
3. If the target has **IDS/IPS**, reduce speed by changing `--min-rate 1000` to `--min-rate 500`.

---

## **5. Troubleshooting**
- **"Nmap not installed"**:  
  Install Nmap: `sudo apt install nmap`.
- **"Permission denied"**:  
  Always run with `sudo`.
- **Slow scans**:  
  Lower `--min-rate` or use Ops 1/3.

---

This script streamlines **network scanning** for **pentesting** or **security audits** with a user-friendly interface. 🚀  

## indonesia version

---

### **1. Cara Penggunaan**
#### **Sintaks Dasar**
```bash
sudo ./script_nmap.sh <target_ip>
```
Contoh:
```bash
sudo ./nmap_advanced.sh 10.1.2.157
```

#### **Langkah-Langkah**
1. **Pastikan Nmap terinstal**  
   Script akan mengecek otomatis. Jika belum, install dengan:
   ```bash
   sudo apt install nmap  # Untuk Debian/Ubuntu
   ```

2. **Jalankan sebagai root**  
   Nmap membutuhkan akses root untuk scan mendalam (misal: scan port 1-65535).

3. **Pilih Mode Scan**  
   Setelah menjalankan script, akan muncul menu dengan 6 opsi:
   ```
   1) Normal Scan (-sCV)  
   2) Brutal Scan (-p- -sCV --min-rate 1000)  
   3) Normal Scan + Vuln (-sCV --script vuln)  
   4) Brutal Scan + Vuln (-p- -sCV --min-rate 1000 --script vuln)  
   5) Run All Scans  
   6) Exit  
   ```

4. **Hasil Scan**  
   Semua output disimpan di direktori `/tmp/nmap_scan_<timestamp>/` dengan struktur:
   ```
   - normal_scan.txt       # Hasil opsi 1
   - brutal_scan.txt       # Hasil opsi 2
   - normal_vuln_scan.txt  # Hasil opsi 3
   - brutal_vuln_scan.txt  # Hasil opsi 4
   - summary.txt           # Ringkasan semua scan (bila pilih opsi 5)
   - error.log             # Log error (jika ada)
   ```

---

### **2. Penjelasan Fitur**
#### **a. Mode Scan**
| Opsi | Command Nmap | Deskripsi |
|------|-------------|-----------|
| 1    | `-sCV` | Scan standar dengan deteksi versi dan script default. |
| 2    | `-p- -sCV --min-rate 1000` | Scan **semua port (1-65535)** dengan kecepatan tinggi. |
| 3    | `-sCV --script vuln` | Scan standar + deteksi **vulnerability** (CVE). |
| 4    | `-p- -sCV --min-rate 1000 --script vuln` | Kombinasi brutal scan + deteksi vuln. |
| 5    | - | Menjalankan **semua mode scan** sekaligus. |

#### **b. Fitur Tambahan**
- **Error Handling**  
  Jika scan gagal, pesan error akan disimpan di `error.log`.
- **Summary Report**  
  File `summary.txt` berisi **port terbuka** dan **vulnerability** yang ditemukan.
- **Timestamp Output**  
  Direktori hasil scan menggunakan format `nmap_scan_<YYYYMMDD_HHMMSS>` untuk menghindari overwrite.

---

### **3. Contoh Output**
#### **Isi `summary.txt`**
```plaintext
Scan Summary for 10.1.2.157
========================
Scan completed at: Fri Jun 14 15:30:00 UTC 2024
Scanned by: 0xiyuzz
------------------------

Results from normal_scan.txt:
----------------------------------------
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu
80/tcp open  http    Apache 2.4.41

Results from brutal_vuln_scan.txt:
----------------------------------------
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu
80/tcp open  http    Apache 2.4.41
|_http-vuln-cve2017-5638: VULNERABLE (CVE-2017-5638)
```

---

### **4. Tips Penggunaan**
1. **Scan Brutal** (Opsi 2/4) bisa sangat agresif. Gunakan hanya di lingkungan yang diizinkan!
2. Untuk **CTF/Pentest**, gunakan opsi **3 atau 4** untuk deteksi vulnerability.
3. Jika target memiliki **IDS/IPS**, kurangi kecepatan scan dengan mengganti `--min-rate 1000` menjadi `--min-rate 500`.

---

### **5. Troubleshooting**
- **Error "Nmap not installed"**:  
  Install nmap: `sudo apt install nmap`.
- **Error "Permission denied"**:  
  Pastikan menjalankan script dengan `sudo`.
- **Scan terlalu lambat**:  
  Kurangi `--min-rate` atau gunakan opsi 1/3.

---

Dengan script ini, Anda bisa melakukan **scan jaringan secara efisien** dengan fitur lengkap untuk **pentesting** atau **audit keamanan**. 🚀
