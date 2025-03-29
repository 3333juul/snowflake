{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.lists) elem map;

  # we remap ntfs3 to ntfs as they are the same thing for nix
  fs = map (f: {ntfs3 = "ntfs";}.${f} or f) config.garden.system.fs.support;
in {
  config = mkMerge [
    {
      # discard blocks that are not in use by the filesystem, good for SSDs health
      services.fstrim = {
        enable = true;
        interval = "weekly";
      };

      # include our allowed file systems in the supported fileSystems lists
      boot = {
        supportedFilesystems = fs;
        initrd.supportedFilesystems = fs;
      };
    }

    # clean btrfs devices
    (mkIf (elem "btrfs" fs) {
      services.btrfs.autoScrub = {
        enable = true;
        interval = "weekly";
        fileSystems = ["/"];
      };
    })
  ];
}
