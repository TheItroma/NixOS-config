{inputs, ...}: {
  flake.modules.homeManager.nixcord = {pkgs, ...}: {
    imports = [inputs.nixcord.homeModules.nixcord];
    home.packages = with pkgs; [
      discordchatexporter-cli
    ];
    programs.nixcord = {
      enable = true;
      equibop = {
        enable = true;
        autoscroll.enable = true;
      };
      config = {
        plugins = {
          ClearURLs.enable = true;
          IRememberYou.enable = true;
          messageLoggerEnhanced.enable = true;
          messageTranslate.enable = true;
          translate.enable = true;
          homeTyping.enable = true;
          readAllNotificationsButton.enable = true;
          fakeNitro.enable = true;
          alwaysAnimate.enable = true;
          musicControls.enable = true;
          messageClickActions.enable = true;
          silentMessageToggle.enable = true;
          noNitroUpsell.enable = true;
          noOnboardingDelay.enable = true;
          fixCodeblockGap.enable = true;
          relationshipNotifier.enable = true;
          fixSpotifyEmbeds.enable = true;
          youtubeAdblock.enable = true;
          clientTheme = {
            enable = true;
            color = "000000";
          };
        };
      };
    };
  };
}
