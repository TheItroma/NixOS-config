{ inputs, ... }: {
  flake.modules.homeManager.nixcord = {
    imports = [ inputs.nixcord.homeModules.nixcord ];
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
          betterFolders.enable = true;
          musicControls.enable = true;
          messageClickActions.enable = true;
          silentMessageToggle.enable = true;
          noNitroUpsell.enable = true;
          noOnboardingDelay.enable = true;
          fixCodeblockGap.enable = true;
          relationshipNotifier.enable = true;
          fixSpotifyEmbeds.enable = true;
          youtubeAdblock.enable = true;
          anammox.enable = true;
        };
      };
    };
  };
}
