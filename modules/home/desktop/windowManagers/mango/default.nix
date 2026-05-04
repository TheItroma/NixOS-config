{
  flake.modules.homeManager.mango = {
    pkgs,
    inputs,
    ...
  }: {
    wayland.windowManager.mango = {
      enable = true;
      settings = ''
        # General

        monitorrule=name:^DP-2$,width:2560,height:1440,refresh:165.001,x:0,y:0
        # see back to gpu stuff
        numlockon=1
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
        border_radius=22
        bordercolor=0x000000
        focuscolor=0x008080

        # - Blur
        blur=1
        blur_layer=1
        blur_params_num_passes=2
        shadows=0
        blur_params_radius=3
        blur_params_saturation=1.5
        blur_optimized=1
        blur_params_brightness=1

        # - Animations
        animations=1
        layer_animations=1
        animation_type_open=slide
        animation_type_close=slide
        layer_animation_type_open=slide
        layer_animation_type_close=slide
        tag_animation_direction=1

        # Bindings
        bind=SUPER,s,toggle_scratchpad
        bind=SUPER+SHIFT,R, reload_config

        # - Rotate?
        bind=SUPER,U, focuslast
        bind=SUPER,M, incnmaster, +1
        bind=SUPER+SHIFT,M, incnmaster, -1

        # - Spawn, Kill
        bind=SUPER, R, spawn_shell, pkill rofi || rofi -show run
        bind=SUPER,Q, spawn, kitty
        bind=SUPER,F, spawn, librewolf
        bind=SUPER,C,killclient

        # - Layout

        # - Navigation
        bind=SUPER,h,focusdir,left
        bind=SUPER,j,focusstack,prev
        bind=SUPER,k,focusstack,next
        bind=SUPER,l,focusdir,right
        bind=SUPER,1,view,1,0
        bind=SUPER,2,view,2,0
        bind=SUPER,3,view,3,0
        bind=SUPER,4,view,4,0
        bind=SUPER,5,view,5,0
        bind=SUPER,6,view,6,0
        bind=SUPER,7,view,7,0
        bind=SUPER,8,view,8,0
        bind=SUPER,9,view,9,0
        bind=SUPER+SHIFT,1,tag,1,0
        bind=SUPER+SHIFT,2,tag,2,0
        bind=SUPER+SHIFT,3,tag,3,0
        bind=SUPER+SHIFT,4,tag,4,0
        bind=SUPER+SHIFT,5,tag,5,0
        bind=SUPER+SHIFT,6,tag,6,0
        bind=SUPER+SHIFT,7,tag,7,0
        bind=SUPER+SHIFT,8,tag,8,0
        bind=SUPER+SHIFT,9,tag,9,0

        # - Volume
        bind=NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%+
        bind=NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%-
        bind=NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK@ toggle
        bind=CTRL,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SOURCE@ toggle

        # - Playback
        bind=NONE,XF86AudioNext,spawn,playerctl next --player=spotify,spotifyd
        bind=NONE,XF86AudioPrev,spawn,playerctl previous --player=spotify,spotifyd
        bind=NONE,XF86AudioPlay,spawn,playerctl play-pause --player=spotify,spotifyd

        # -- Fast
        bind=SHIFT,XF86AudioRaiseVolume,spawn,playerctl next --player=spotify,spotifyd
        bind=SHIFT,XF86AudioLowerVolume,spawn,playerctl previous --player=spotify,spotifyd
      '';
    };
  };
}
