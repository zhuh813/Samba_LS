# Samba Server 多重權限共享環境建置實驗

本專案紀錄於 VMware Workstation 環境下，使用 Ubuntu Server 24.04 架設 Samba (SMB) 伺服器，並針對 Windows 與 Linux 兩款不同的客戶端（Client）進行三種不同權限情境的網路共享驗證。

## 實驗環境拓撲

本實驗所有虛擬機均連接至 VMware 的 **VMnet8 (NAT 模式)** 虛擬交換機，網段為 `192.168.132.0/24`。

- **Samba 伺服器端**：Ubuntu Server 24.04.4 Live Server
- **Windows 客戶端**：Windows Server 2016
- **Linux 客戶端**：Ubuntu Desktop 24.04.4 Desktop

```mermaid
graph LR
    subgraph VMnet8 [VMware VMnet8 NAT 網路 192.168.132.0/24]
        direction LR
        Win["Windows Server<br>(客戶端)"]
        UbuntuCli["Ubuntu Desktop<br>(客戶端)"]
        UbuntuSrv["Ubuntu Server<br>(Samba伺服器端)"]
    end

    subgraph Shares [Samba 共享資料夾設定]
        direction TB
        S1["/var/shares (匿名唯讀)"]
        S2["/var/update (匿名讀寫)"]
        S3["/var/secret (密碼驗證 - amy)"]
    end

    Win -.->|網路芳鄰| Shares
    UbuntuCli -.->|SMB掛載| Shares
    UbuntuSrv ==>|提供服務| Shares
