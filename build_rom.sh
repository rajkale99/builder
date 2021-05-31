# sync rom
repo init --depth=1 -u git://github.com/Lineage-FE/manifest.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/yashlearnpython/local_manifest.git --depth=1 -b Lineage-FE .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# build rom
source build/envsetup.sh
lunch lineage_mido-userdebug
mka bacon

# Upload build
rclone copy out/target/product/mido/*.zip cirrus:mido -P
