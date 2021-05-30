# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AOSiP/platform_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/flashokiller/mainfest_personal --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic

# If you would like to include gapps in your build, after lunching device enter:
export WITH_GAPPS=true


# upload rom
rclone copy out/target/product/ysl/2021*.zip cirrus:ysl -P

