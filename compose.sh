#!/bin/bash

set -e

read -rp "Enter PrestaShop version you want to download (eg 1.6.1.24): " PS_VERSION

PS_ADMIN_DIR='admin-dev'
PS_INSTALL_DIR='install-dev'

# --- download clean prestashop

echo "Download clean PrestaShop ${PS_VERSION}...";

rm -Rf "prestashop";
mkdir "prestashop";
cd "prestashop";
wget -q "https://github.com/PrestaShop/PrestaShop/releases/download/${PS_VERSION}/prestashop_${PS_VERSION}.zip" --no-check-certificate;
unzip -q "prestashop_${PS_VERSION}.zip";

if [[ $PS_VERSION == 1.7.* ]]; then
	rm "Install_PrestaShop.html" "index.php" "prestashop_${PS_VERSION}.zip";
	unzip -q "prestashop.zip";
	rm "prestashop.zip";
else
	cd "prestashop"
fi

mv "admin" "${PS_ADMIN_DIR}";
mv "install" "${PS_INSTALL_DIR}";
if [[ -d "../shop" || -d "../../shop" ]]; then
	rm -Rf "modules";
	rm -Rf "${PS_INSTALL_DIR}";
fi

cd "..";
if [[ $PS_VERSION == 1.6.* ]]; then
  cd "..";
fi

# --- deploy

echo "Deploy...";

if [[ $PS_VERSION == 1.7.* ]]; then
	cp -nR "./prestashop/." "./shop/";
else
	cp -nR "./prestashop/prestashop/." "./shop/";
fi

# --- clean

echo "Clean...";

rm -Rf "./prestashop"
