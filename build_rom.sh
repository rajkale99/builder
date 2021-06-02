#Repo init command, that -device,-mips,-darwin,-notdefault part will save you more time and storage to sync, add more according to your rom and choice. Optimization is welcomed! Let's make it quit, and with depth=1 so that no unnecessary things.
# I want to sync aex source!
repo init -q --no-repo-verify --depth=1 https://github.com/descendant-xi/manifests.git -b eleven-staging -g default,-device,-mips,-darwin,-notdefault

# Clone local manifest! So that no need to manually git clone repos or change hals, you can use normal git clone or rm and re clone, they will cost little more time, and you may get timeout! Let's make it quit and depth=1 too.
# My local manifest can do all clone, and removing or changing repository i need, so lets use it! I am lazy to manually git clone!
git clone https://github.com/Yasundram/local_manifest --depth 1 -b main .repo/local_manifests

# Sync source with -q, no need unnecessary messages, you can remove -q if want! try with -j30 first, if fails, it will try again with -j8
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j 30 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patches
#cd external/selinux
#curl -LO https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
#patch -p1 < *.patch
#cd ../..

# build rom
source build/envsetup.sh
lunch descendant_RMX1941-userdebug
mka descendant

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
 
