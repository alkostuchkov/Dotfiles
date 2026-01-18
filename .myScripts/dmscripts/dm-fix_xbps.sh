#!/usr/bin/env bash

echo "➡️ Atualizando sistema com xbps-install -Suvy..."
OUTPUT=$(xbps-install -Suvy 2>&1)

echo "$OUTPUT"

if echo "$OUTPUT" | grep -q "failed to open repository: https://repo-default.voidlinux.org/current: failed to read index: Invalid argument"; then
    echo "⚠️ Erro detectado: índice do repositório corrompido."
    echo "🧹 Removendo arquivo corrompido..."
    sudo rm -v /var/db/xbps/https___repo-default_voidlinux_org_current/x86_64-repodata

    echo "🔁 Tentando novamente..."
    sudo xbps-install -Suvy
else
    echo "✅ Atualização concluída sem erros."
fi
