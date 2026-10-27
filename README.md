# Get_IPConfig

A lightweight, automated PowerShell utility designed to remotely collect network configuration data (`ipconfig /all`) from multiple network computers simultaneously.

## Features

- **Relative Paths:** Automatically tracks its own execution directory using `$PSScriptRoot`. No hardcoded folder structures required.
- **Error Handled Log Isolation:** Cleanly separates successful connections from failures. Failed logs are saved inside a dedicated `Failed` directory alongside the exact network error message.
- **Sanitizing Logic:** Automatically ignores empty or whitespace lines within the hosts list.
- **Double-Click Execution:** Includes a Windows Batch runner wrapper (`.bat`) configured with folder discovery (`%~dp0`) and execution bypass policy rules to quickly run the tool without manually launching an elevated terminal shell.

## Repository Directory Structure

```text
Remote_IPConfig/
├── Remote_IPConfig.bat      # Quick-launch wrapper script
├── Remote_IPConfig.ps1      # Main PowerShell core execution script
├── hosts.txt                # Plain-text target inventory list
└── ipconfig_outputs/        # Target generated folder for active returns
    ├── Failed/              # Automatically generated folder for failed returns
    │   └── computer2.txt    # Example connectivity error logs
    └── computer1.txt        # Example raw ipconfig output dumps
```

## Requirements

1. **Windows Remote Management (WinRM):** Targeted machines must have PowerShell Remoting enabled (`Enable-PSRemoting`).
2. **Network/Firewall Permissions:** WinRM ports (5985 for HTTP / 5986 for HTTPS) must be open from your host machine to target clients.
3. **Privileges:** The user running the script must hold administrative permissions on the target machines to access network diagnostic subsystems remotely.

## Usage

1. **Populate Targets:** Open `hosts.txt` and populate it with target computer names or IP addresses (one target entry per line).
2. **Execute:** Double-click `Remote_IPConfig.bat` to launch the runner.
3. **Review Data:** 
   - Check `ipconfig_outputs/` for text outputs from responding computers.
   - Check `ipconfig_outputs/Failed/` to inspect specific reasons why offline systems missed collection requests.

## License

This project is licensed under the GNU General Public License v3.0 - see the LICENSE file for details.
