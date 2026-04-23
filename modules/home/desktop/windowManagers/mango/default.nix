{
  flake.modules.homeManager.mango = {
    pkgs,
    inputs,
    ...
  }: {
    imports = [inputs.mangowm.hmModules.mango];

    wayland.windowManager.mango = {
      enable = true;
      settings = ''
        # General

        monitorrule=name:^DP-2$,width:2560,height:1440,refresh:165.001,x:0,y:0
        # see back to gpu stuff
        numlockon=1
        xkb_rule_layout=us
        accel_profile=0

        # Visuals
        focused_opacity=0.9
        unfocused_opacity=0.8
        border_radius=7

        # - Borders
        borderpx=4
        gappih=4
        gappoh=4
        gappiv=4
        gappov=4

        # - Blur
        blur=1
        blur_layer=1
        blur_params_num_passes=2
        shadows=0
        blur_params_radius=3
        blur_params_saturation=1.5
        blur_optimized=1
        border_radius=2
        no_radius_when_single=1
        blur_params_brightness=1

        # - Animations
        # TO IMPLEMEMNT

        # Bindings


      '';
    };
  };
}
