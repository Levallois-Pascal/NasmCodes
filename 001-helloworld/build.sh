#!/bin/bash

# Script pour compiler, exécuter et nettoyer un programme assembleur NASM

TARGET="helloworld"
SOURCE="helloworld.asm"
FORMAT="elf64"

# Fonction pour compiler le programme
compile() {
    echo "Compilation de $SOURCE..."
    nasm -f $FORMAT $SOURCE -o "${TARGET}.o"
    if [ $? -eq 0 ]; then
        echo "Compilation réussie !"
        ld "${TARGET}.o" -o $TARGET
        if [ $? -eq 0 ]; then
            echo "Liaison réussie !"
        else
            echo "Erreur lors de la liaison."
            exit 1
        fi
    else
        echo "Erreur lors de la compilation."
        exit 1
    fi
}

# Fonction pour exécuter le programme
run() {
    if [ -f "$TARGET" ]; then
        echo "Exécution de $TARGET..."
        ./$TARGET
    else
        echo "Le programme $TARGET n'existe pas. Compilation en cours..."
        compile
        ./$TARGET
    fi
}

# Fonction pour nettoyer les fichiers générés
clean() {
    echo "Nettoyage des fichiers générés..."
    rm -f "${TARGET}.o" $TARGET
    echo "Nettoyage terminé."
}

# Gestion des arguments du script
case "$1" in
    compile)
        compile
        ;;
    run)
        run
        ;;
    clean)
        clean
        ;;
    *)
        echo "Usage: $0 {compile|run|clean}"
        echo "  compile : Compile le programme assembleur."
        echo "  run     : Exécute le programme."
        echo "  clean   : Nettoie les fichiers générés."
        exit 1
        ;;
esac

