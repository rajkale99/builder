# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/hentaiOS/platform_manifest/ -b Rika -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/RahifM/local_manifests --depth 1 -b staging/hos-rika-local_m .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch hentai_mido-userdebug
export TZ=Asia/Kolkata
make -j24 otapackage

cd out/tar*/pro*/mido && find -name ipacm*

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
