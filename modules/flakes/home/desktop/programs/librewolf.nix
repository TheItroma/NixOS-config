{ config, pkgs, inputs, ... }: {
  flake.modules.homeManager.librewolf = {
    programs.librewolf = {
      enable = true;
      policies = {
        DisplayBookmarksToolbar = "never";
      };
      profiles.default = {
        isDefault = true;

        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
        };
        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [

          # Privacy and Security
          adnauseam
          facebook-container
          google-container
          passff
          clearurls
          privacy-settings

          # Youtube
          sponsorblock
          return-youtube-dislikes
          youtube-suite-search-fixer
          redirect-shorts-to-youtube
          multiselect-for-youtube
          videospeed
          enhanced-h264ify

          # Looks
          tabliss
          darkreader
          pywalfox
          new-window-without-toolbar

          # QOL
          external-application
          indie-wiki-buddy
          nyaa-linker
          one-click-wayback
          search-by-image
          #shortkeys
          firenvim
          tab-session-manager
          don-t-fuck-with-paste
          sidebery
          
          # Languages
          yomitan
          
          # Github
          enhanced-github
          refined-github

          # Misc
          musescore-downloader
        ];
        settings = {
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };
}
