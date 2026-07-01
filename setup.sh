#!/bin/bash

# ====================================================================
# Ubuntu 24.04 Samba 自動化建置與目錄權限設定腳本
# ====================================================================

echo "========== 1. 更新軟體源並安裝 Samba =========="
sudo apt update && sudo apt install samba samba-common-bin -y

echo "========== 2. 建立實驗目標資料夾 =========="
sudo mkdir -p /var/shares /var/update /var/secret

echo "========== 3. 配置 Linux 檔案系統權限 =========="
# /var/shares 匿名唯讀 (755)
sudo chmod 755 /var/shares
# /var/update 匿名讀寫 (777)
sudo chmod 777 /var/update

echo "========== 4. 建立測試使用者 amy =========="
# 檢查 amy 是否已存在，若不存在則建立
if ! id "amy" &>/dev/null; then
    sudo useradd -m -s /bin/bash amy
    echo "系統使用者 amy 建立成功。"
fi

# 設定 /var/secret 為 amy 專屬
sudo chown -R amy:amy /var/secret
sudo chmod 700 /var/secret

echo "========== 5. 重啟 Samba 服務 =========="
sudo systemctl restart smbd
sudo systemctl enable smbd

echo "================================================="
echo " 基本環境已設定完成！"
echo " 請手動執行以下步驟來完成 Samba 密碼設定："
echo " 指令: sudo smbpasswd -a amy"
echo "================================================="
