#!/bin/bash

# Обновление системы и установка драйверов NVIDIA для Fedora
set -e  # Прервать выполнение при любой ошибке

echo "Обновление системы..."
sudo dnf upgrade --refresh -y

echo "Установка необходимых пакетов NVIDIA..."
sudo dnf install -y \
    gcc \
    kernel-headers \
    kernel-devel \
    akmod-nvidia \
    xorg-x11-drv-nvidia \
    xorg-x11-drv-nvidia-libs \
    xorg-x11-drv-nvidia-libs.i686 \
    xorg-x11-drv-nvidia-power \
    nvidia-settings \
    xorg-x11-drv-nvidia-cuda \
    xorg-x11-drv-nvidia-cuda-libs \
    xorg-x11-drv-nvidia-cuda-libs.i686

echo "Сборка модулей ядра NVIDIA..."
sudo akmods --force

echo "Пересоздание initramfs..."
sudo dracut --force

echo "Включение служб NVIDIA для suspend/resume/hibernate..."
sudo systemctl enable nvidia-suspend nvidia-resume nvidia-hibernate

echo "Перезагрузка системы..."
sudo systemctl reboot
