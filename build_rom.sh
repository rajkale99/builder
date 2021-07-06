# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault # Initilizeing dotOS11 sources
git clone https://github.com/RahulPalXDA/local_manifest.git --depth=1 -b dot_holland2 .repo/local_manifests # adding builder's local_manifest to Initilized sources
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 # Syncing previously Initilized sources

# build rom
source build/envsetup.sh
lunch dot_holland2-userdebug
export TZ=Asia/Kolkata #put before last build command (setting timezone)
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
