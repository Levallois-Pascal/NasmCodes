#!/bin/bash

# Script pour compiler, exécuter et nettoyer un programme assembleur NASM

TARGET="helloworld"
SOURCE="helloworld.asm"
FORMAT="elf64"

# How to compile
compile() {
    echo "Compilation of $SOURCE..."
    nasm -f $FORMAT $SOURCE -o "${TARGET}.o"
    if [ $? -eq 0 ]; then
        echo "Compilation ok!"
        ld "${TARGET}.o" -o $TARGET
        if [ $? -eq 0 ]; then
            echo "Linking ok!"
        else
            echo "Linking errors."
            exit 1
        fi
    else
        echo "Compil errors."
        exit 1
    fi
}

# Exec function
run() {
    if [ -f "$TARGET" ]; then
        echo "$TARGET execution..."
        ./$TARGET
    else
        echo "$TARGET doesn't exist. Compiling..."
        compile
        ./$TARGET
    fi
}

# Clean function
clean() {
    echo "Cleaning up generated files."
    rm -f "${TARGET}.o" $TARGET
    echo "Cleaning up complete."
}

# Script arguments
case "$1" in
    run)
        run
        ;;
    clean)
        clean
        ;;
    *)
        echo "Usage: $0 {run|clean}"
        echo "  run     : Exécute le programme."
        echo "  clean   : Nettoie les fichiers générés."
        exit 1
        ;;
esac
