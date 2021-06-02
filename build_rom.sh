# sync rom
repo init --depth=1 --no-repo-verify -urepo init -u https://github.com/descendant-xi/manifests.git -b eleven-staging -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/Yasundram/local_manifest --depth=1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
lunch descendant_RMX1941-userdebug
mka descendant

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
 
