FROM gitpod/workspace-full
USER root
RUN sudo apt-get update -y && sudo apt-get install qemu qemu-system-x86