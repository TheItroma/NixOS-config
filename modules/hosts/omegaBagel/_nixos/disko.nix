{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-CT1000P3PSSD8_24464C3782DA";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "16G";
            content = {
              type = "swap";
              resumeDevice = true; # resume from hiberation from this device
            };
          };
          root = {
            size = "30%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          home = {
            size = "70%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
#          luks = {
#            size = "10%";
#            content = {
#              type = "luks";
#              name = "secrets";
#              settings = {
#                # if you want to use the key for interactive login be sure there is no trailing newline
#                # for example use `echo -n "password" > /tmp/secret.key`
#                keyFile = "/tmp/secret.key";
#                allowDiscards = true;
#              };
#              content = {
#                type = "filesystem";
#                format = "ext4";
#                mountpoint = "/home/secrets";
#              };
#            };
#          };
        };
      };
    };
  };
}
