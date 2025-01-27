# macos-ram-volume

Scripts to create and remove RAM volume on macOS

## Prerequisites

- **macOS** operating system.
- **Terminal Access** to execute shell scripts.
- **Execute Permissions** on the scripts.

## Installation

1. **Clone the Repository**
   
   ```bash
   git clone https://github.com/yourusername/macos-ram-volume.git
   ```

2. **Navigate to the Project Directory**
   
   ```bash
   cd macos-ram-volume
   ```

3. **Make the Scripts Executable**
   
   ```bash
   chmod +x create_ram_volume.sh remove_ram_volume.sh
   ```

## Usage

### Creating a RAM Volume

To create a RAM volume, run the `create_ram_volume.sh` script. You can specify the size in megabytes (MB) as an argument. If no size is provided, it defaults to **128 MB**.

**Syntax:**

```bash
./create_ram_volume.sh [size_in_MB]
```

**Examples:**

- **Default Size (128 MB):**
  
  ```bash
  ./create_ram_volume.sh
  ```

- **Custom Size (e.g., 256 MB):**
  
  ```bash
  ./create_ram_volume.sh 256
  ```

### Removing a RAM Volume

To remove an existing RAM volume, run the `remove_ram_volume.sh` script. Ensure you specify the correct size if you created a RAM volume with a custom size. If no size is provided, it defaults to **128 MB**.

**Syntax:**

```bash
./remove_ram_volume.sh [size_in_MB]
```

**Examples:**

- **Default Size (128 MB):**
  
  ```bash
  ./remove_ram_volume.sh
  ```

- **Custom Size (e.g., 256 MB):**
  
  ```bash
  ./remove_ram_volume.sh 256
  ```

## Notes

- **Default Behavior:** If no size is provided when running the scripts, they will default to creating or removing a **128 MB** RAM volume.
  
- **Error Handling:** The scripts include enhanced error handling to provide detailed feedback in case of failures. Review the error messages for guidance.
  
- **Permissions:** If you encounter permission-related errors, consider running the scripts with `sudo`:
  
  ```bash
  sudo ./create_ram_volume.sh
  sudo ./remove_ram_volume.sh
  ```
  
- **Data Volatility:** Remember that all data stored on the RAM volume is **volatile** and will be **lost** once it's unmounted or the system is restarted. Ensure you back up any important data before unmounting.
