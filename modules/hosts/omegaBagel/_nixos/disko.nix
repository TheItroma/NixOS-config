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
                  keyFile = "/dev/disk/by-id/usb-SanDisk_Cruzer_Dial_4C531001460425116453-0:0";
		  keyfileSize = 4096;
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
            size = "20%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          home = {
            size = "60%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
#          luks = {
#            size = "20%";
#            content = {
#              type = "luks";
#              name = "crypted";
#              extraOpenArgs = [ ];
#              settings = {
#                # if you want to use the key for interactive login be sure there is no trailing newline
#                # for example use `echo -n "password" > /tmp/secret.key`
#                keyFile = "/tmp/secret.key";
#                allowDiscards = true;
#              };
#              additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
#              content = {
#                type = "filesystem";
#                format = "ext4";
#		mountpoint = "/home/Secrets";
#              };
#            };
#          };
        };
      };
    };
  };
}
