#/bin/zsh

CFLAGS='-march=znver3 -O3 -flto -pipe'
CXXFLAGS=${CFLAGS}

cd `pwd`

make -j 10 CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS}
make -j 10 CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS} modules
sudo make -j 10 CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS} modules_install

KERNEL_NAME=$(ls -1rt /lib/modules | tail -1)

sudo cp arch/x86_64/boot/bzImage /boot/vmlinux-linux-${KERNEL_NAME}

sudo mkinitcpio -k ${KERNEL_NAME} -g /boot/initramfs-linux-${KERNEL_NAME}

sudo grub-mkconfig -o /boot/grub/grub.cfg
