#!/bin/bash

set -e

read -p "Enter PrestaShop version you want to install (eg 1.6.1.24): " PS_VERSION

PS_ADMIN_DIR='admin-dev'
PS_INSTALL_DIR='install-dev'

# --- download clean prestashop

echo "Download clean PrestaShop ${PS_VERSION}...";

rm -Rf prestashop;
mkdir prestashop;
cd prestashop;
wget -q "https://github.com/PrestaShop/PrestaShop/releases/download/${PS_VERSION}/prestashop_${PS_VERSION}.zip" --no-check-certificate;
unzip -q "prestashop_${PS_VERSION}.zip";

if [[ $PS_VERSION == 1.7.* ]]; then
	rm "Install_PrestaShop.html" "index.php" "prestashop_${PS_VERSION}.zip";
	unzip -q "prestashop.zip";
	rm "prestashop.zip";
	mv "admin" "${PS_ADMIN_DIR}";
	mv "install" "${PS_INSTALL_DIR}";
else
	cd prestashop
	mv "admin" "${PS_ADMIN_DIR}";
	mv "install" "${PS_INSTALL_DIR}";
	cd ..
fi

if [[ -d "../shop" ]]; then
	rm -Rf "modules";
fi

cd ..;

# --- deploy

echo "Deploy...";

if [[ $PS_VERSION == 1.7.* ]]; then
	cp -nR "./prestashop/." "./shop/";
else
	cp -nR "./prestashop/prestashop/." "./shop/";
fi

rm -Rf "./prestashop"
