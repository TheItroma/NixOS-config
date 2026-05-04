{
  lib,
  config,
  pkgs,
  ...
}: let
  system = "x86_64-linux";
  inherit (lib.types) bool int float str attrs listOf submodule;
  inherit (lib) ElemAt mkOption;

  mkOpt = options:
    lib.mkOption {
      type = ElemAt options 0;
      default = ElemAt options 1;
    };

  cfg = config.wayland.windowManager.dwl.settings;

  boolToInt = bool:
    if bool
    then "1"
    else "0";

  nullToStr = value:
    if value == builtins.null
    then "NULL"
    else "\"${value}\"";
in {
  options = {
    wayland.windowManager.dwl = {
      enable = mkOpt [bool false];

      settings = {
        tagcount = mkOpt [int 9];

        keyboard = {
          xkb_rule_names = mkOpt [str builtins.null];
          repeat_rate = mkOpt [int 25];
          repeat_delay = mkOpt [int 600];
        };

        trackpad = {
          tap_to_click = mkOpt [bool true];
          tap_and_drag = mkOpt [bool true];
          drag_lock = mkOpt [bool true];
          natural_scrolling = mkOpt [bool false];
          disable_while_typing = mkOpt [bool true];
          left_handed = mkOpt [bool false];
          middle_button_emulation = mkOpt [bool false];
        };

        libinput = {
          scroll_method = mkOption {
            type = int;
            default = 1;
            apply = (
              index:
                lib.ElemAt
                [
                  "LIBINPUT_CONFIG_SCROLL_NO_SCROLL"
                  "LIBINPUT_CONFIG_SCROLL_2FG"
                  "LIBINPUT_CONFIG_SCROLL_EDGE"
                  "LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN"
                ]
                index
            );
          };
          click_method = mkOption {
            type = int;
            default = 2;
            apply = (
              index:
                lib.ElemAt
                [
                  "LIBINPUT_CONFIG_CLICK_METHOD_NONE"
                  "LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS"
                  "LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER"
                ]
                index
            );
          };
          send_events_mode = mkOption {
            type = int;
            default = 0;
            apply = (
              index:
                lib.ElemAt
                [
                  "LIBINPUT_CONFIG_SEND_EVENTS_ENABLED"
                  "LIBINPUT_CONFIG_SEND_EVENTS_DISABLED"
                  "LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE"
                ]
                index
            );
          };

          button_map = mkOption {
            type = int;
            default = 0;
            apply = (
              index:
                lib.ElemAt
                [
                  "LIBINPUT_CONFIG_TAP_MAP_LRM"
                  "LIBINPUT_CONFIG_TAP_MAP_LMR"
                ]
                index
            );
          };

          accel = {
            profile = mkOption {
              type = int;
              default = 0;
              apply = (
                index:
                  lib.ElemAt
                  [
                    "LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT"
                    "LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE"
                  ]
                  index
              );
            };
            speed = mkOpt [float 0.0];
          };
        };

        monitors = {
          type = listOf (submodule {
            options = {
              name = mkOpt [str builtins.null];
              mfact = mkOpt [float 0.5];
              nmaster = mkOpt [int 1];
              scale = mkOpt [int 2];
              layout = mkOpt [int 0];
              x = mkOpt [int (-1)];
              y = mkOpt [int (-1)];
            };
          });
        };

        bindHelper = mkOpt [
          str
          ''
            /* If you want to use the alt key for MODKEY, use WLR_MODIFIER_ALT */
            #define MODKEY WLR_MODIFIER_LOGO

            #define TAGKEYS(KEY,SKEY,TAG) \
            	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
            	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
            	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,             {.ui = 1 << TAG} }, \
            	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG} }

            /* helper for spawning shell commands in the pre dwm-5.0 fashion */
            #define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

            /* commands */
            static const char *termcmd[] = { "foot", NULL };
            static const char *menucmd[] = { "wmenu-run", NULL };
          ''
        ];

        binds = mkOption {
          type = listOf (submodule {
            options = {
              modifier = mkOpt [str "MODKEY"];
              key = mkOpt [str "space"];
              function = mkOpt [str "spawn"];
              argument = mkOpt [str "0"];
            };
          });
          buttons = mkOption {
            type = listOf (submodule {
              options = {
                modifier = mkOpt [str "MODKEY"];
                key = mkOpt [str "space"];
                function = mkOpt [str "spawn"];
                argument = mkOpt [str "0"];
              };
            });

            default = [
              {
                key = "BTN_LEFT";
                function = "togglefloating";
                argument = ".ui = CurMove";
              }
              {
                key = "BTN_MIDDLE";
                function = "togglefloating";
                argument = "0";
              }
              {
                key = "BTN_RIGHT";
                function = "moveresize";
                argument = ".ui = CurResize";
              }
            ];
          };

          extraBinds = mkOpt [
            str
            ''
              TAGKEYS(          XKB_KEY_1, XKB_KEY_exclam,                        0),
              TAGKEYS(          XKB_KEY_2, XKB_KEY_at,                            1),
              TAGKEYS(          XKB_KEY_3, XKB_KEY_numbersign,                    2),
              TAGKEYS(          XKB_KEY_4, XKB_KEY_dollar,                        3),
              TAGKEYS(          XKB_KEY_5, XKB_KEY_percent,                       4),
              TAGKEYS(          XKB_KEY_6, XKB_KEY_asciicircum,                   5),
              TAGKEYS(          XKB_KEY_7, XKB_KEY_ampersand,                     6),
              TAGKEYS(          XKB_KEY_8, XKB_KEY_asterisk,                      7),
              TAGKEYS(          XKB_KEY_9, XKB_KEY_parenleft,                     8),
            ''
          ];

          rules = mkOption {
            type = listOf (submodule {
              options = {
                appid = mkOpt [str builtins.null];
                title = mkOpt [str builtins.null];
                tagmask = mkOpt [str builtins.null];
                isfloating = mkOpt [bool false];
                monitor = mkOpt [str "-1"];
              };
            });
          };

          appearance = {
            sloppyfocus = mkOpt [bool true];
            bypass_surface_visibility = mkOpt [bool false];
            borderpx = mkOpt [int 1];

            colors = {
              root = mkOpt [str "0x222222ff"];
              border = mkOpt [str "0x444444ff"];
              focus = mkOpt [str "0x005577ff"];
              urgent = mkOpt [str "0xff0000ff"];
            };
          };
        };
      };
    };
    # Disclaimer : I used chatgpt to fill in all the "cfg.option" blanks, not the cleanest but oh well
    # (The concatMapStringsSep was terribly formated and didn't have the "nullToStr" helper :,( )
    config.home.file.".config/dwl/config.h".text = ''
      /* Taken from https://github.com/djpohly/dwl/issues/466 */
      #define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                              ((hex >> 16) & 0xFF) / 255.0f, \
                              ((hex >> 8) & 0xFF) / 255.0f, \
                              (hex & 0xFF) / 255.0f }
      /* appearance */
      static const int sloppyfocus = ${boolToInt cfg.appearance.sloppyfocus};
      static const int bypass_surface_visibility = ${boolToInt cfg.appearance.bypass_surface_visibility};
      static const unsigned int borderpx = ${toString cfg.appearance.borderpx};

      static const float rootcolor[]   = COLOR(${cfg.appearance.colors.root});
      static const float bordercolor[] = COLOR(${cfg.appearance.colors.border});
      static const float focuscolor[]  = COLOR(${cfg.appearance.colors.focus});
      static const float urgentcolor[] = COLOR(${cfg.appearance.colors.urgent});


      /* This conforms to the xdg-protocol. Set the alpha to zero to restore the old behavior */
      static const float fullscreen_bg[]         = {0.0f, 0.0f, 0.0f, 1.0f}; /* You can also use glsl colors */

      /* tagging - TAGCOUNT must be no greater than 31 */
      #define TAGCOUNT (${toString cfg.tagcount})

      /* logging */
      static int log_level = WLR_ERROR;

      static const Rule rules[] = {
      	/* app_id             title       tags mask     isfloating   monitor */
      	{ "Gimp_EXAMPLE",     NULL,       0,            1,           -1 }, /* Start on currently visible tags floating, not tiled */
      	{ "firefox_EXAMPLE",  NULL,       1 << 8,       0,           -1 }, /* Start on ONLY tag "9" */
          /* default/example rule: can be changed but cannot be eliminated; at least one rule must exist */

      ${lib.concatMapStringsSep
        "\n"
        (r: ''
          {
            ${nullToStr r.appid},
            ${nullToStr r.title},
            ${nullToStr r.tagmask},
            ${boolToInt r.isfloating},
            ${toString r.monitor}
          },
        '')
        cfg.rules}
      };

      /* layout(s) */
      static const Layout layouts[] = {
      	/* symbol     arrange function */
      	{ "[]=",      tile },
      	{ "><>",      NULL },    /* no layout function means floating behavior */
      	{ "[M]",      monocle },
      };

      /* monitors */
      /* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
       * WARNING: negative values other than (-1, -1) cause problems with Xwayland clients due to
       * https://gitlab.freedesktop.org/xorg/xserver/-/issues/899 */
      static const MonitorRule monrules[] = {
         /* name        mfact  nmaster scale layout       rotate/reflect                x    y
          * example of a HiDPI laptop monitor:
          { "eDP-1",    0.5f,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 }, */
      	{ NULL,       0.55f, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
      	/* default monitor rule: can be changed but cannot be eliminated; at least one monitor rule must exist */
        ${lib.concatMapStringsSep
        "\n"
        (m: ''
          {
            ${nullToStr m.name},
            ${toString m.mfact}f,
            ${toString m.nmaster},
            ${toString m.scale},
            &layouts[${toString m.layout}],
            WL_OUTPUT_TRANSFORM_NORMAL,
            ${toString m.x},
            ${toString m.y}
          },
        '')
        cfg.monitors}
      };

      /* keyboard */
      static const struct xkb_rule_names xkb_rules = {
      	/* can specify fields: rules, model, layout, variant, options */
      	/* example:
      	.options = "ctrl:nocaps",
      	*/
        .options = NULL,


        // TODO FOR NIXOS CONFIG ONLY : Need to implement that part

      };
      static const int repeat_rate = ${toString cfg.keyboard.repeat_rate};
      static const int repeat_delay = ${toString cfg.keyboard.repeat_delay};

      /* Trackpad */
      static const int tap_to_click = ${boolToInt cfg.trackpad.tap_to_click};
      static const int tap_and_drag = ${boolToInt cfg.trackpad.tap_and_drag};
      static const int drag_lock = ${boolToInt cfg.trackpad.drag_lock};
      static const int natural_scrolling = ${boolToInt cfg.trackpad.natural_scrolling};
      static const int disable_while_typing = ${boolToInt cfg.trackpad.disable_while_typing};
      static const int left_handed = ${boolToInt cfg.trackpad.left_handed};
      static const int middle_button_emulation = ${boolToInt cfg.trackpad.middle_button_emulation};

      static const enum libinput_config_scroll_method scroll_method = ${cfg.libinput.scroll_method};
      static const enum libinput_config_click_method click_method = ${cfg.libinput.click_method};
      static const uint32_t send_events_mode = ${cfg.libinput.sent_events_mode};

      static const enum libinput_config_accel_profile accel_profile = ${cfg.libinput.accel.profile};
      static const double accel_speed = ${toString cfg.libinput.accel.speed};

      /* You can choose between:
      LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
      LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
      */
      static const enum libinput_config_tap_button_map button_map = ${cfg.libinput.button_map};

      /* helper
      ${cfg.bindHelper}

      static const Key keys[] = {

      	/* Note that Shift changes certain key codes: 2 -> at, etc. */
      	/* modifier                  key                  function          argument */

        ${lib.concatMapStringsSep
        "\n"
        (k: ''
          {
            ${k.modifier},
            ${k.key},
            ${k.function},
            {${k.argument} },
          },
        '')
        cfg.binds}

        ${cfg.extraBinds}

      /* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
       * do not remove them.
       */
      #define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
      	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
      	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
      };

      static const Button buttons[] = {
        ${lib.concatMapStringsSep
        "\n"
        (k: ''
          {
            ${k.modifier},
            ${k.key},
            ${k.function},
            {${k.argument} },
          },
        '')
        cfg.buttons}
      };
    '';
  };
}
