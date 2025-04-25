#!/bin/bash

# Verifica se o parâmetro foi passado
if [ -z "$1" ]; then
    echo "Erro: Você deve especificar um sabor (ex: dev, homolog, prod)"
    exit 1
fi

# Mapeia os sabores para os arquivos main correspondentes
case $1 in
    dev)
        fvm flutter run --flavor desenvolvimento -t lib/main_dev.dart
        ;;
    homolog)
        fvm flutter run --flavor homologacao -t lib/main_homolog.dart
        ;;
    prod)
        fvm flutter run --flavor producao -t lib/main_prod.dart
        ;;
    *)
        echo "Erro: Sabor inválido. Use: dev, homolog ou prod."
        exit 1
        ;;
esac
