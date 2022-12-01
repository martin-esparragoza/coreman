FROM gitpod/workspace-full-vnc
RUN sudo apt-get update && sudo apt -y install qemu-system-x86 qemu nasm && \
    sudo apt-get install -y libgtk-3-dev && \
    sudo rm -rf /var/lib/apt/lists/*