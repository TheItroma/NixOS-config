{pkgs, ...}: {
  vim = {
    extraPlugins = with pkgs.vimPlugins; {
      smear-cursor-nvim = {
        package = smear-cursor-nvim;
        setup = ''
           require('smear_cursor').setup({
             cursor_color = "#00FEFC",

             particles_enabled = false,
             stiffness = 0.5,
             trailing_stiffness = 0.5,
             trailing_exponent = 1,
             damping = 0.6,
             gradient_exponent = 0,
             gamma = 1,
             matrix_pixel_threshold = 1,

             never_draw_over_target = true, -- if you want to actually see under the cursor
             hide_target_hack = true,       -- same

             particle_spread = 3,
             particles_per_second = 6000,
             particles_per_length = 30000,
             particle_max_lifetime = 2000,
             particle_max_initial_velocity = -10,
             particle_velocity_from_cursor = -0.3,
             particle_damping = 0.15,
             particle_gravity = 50,
             min_distance_emit_particles = 0,
          })
        '';
      };
    };

    binds.cheatsheet.enable = true;
    dashboard.alpha.enable = true;
    notify.nvim-notify.enable = true;
    autopairs.nvim-autopairs.enable = true;
    snippets.luasnip.enable = true;
    presence.neocord.enable = true;
    comments.comment-nvim.enable = true;
    gestures.gesture-nvim.enable = false; # Super interesting, ill have to see
    session.nvim-session-manager.enable = true;

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
      neogit.enable = true;
    };

    filetree.neo-tree = {
      enable = true;

      setupOpts = {
        enable_cursor_hijack = true;
        add_blank_line_at_the_top = true;
      };
    };

    utility = {
      ccc.enable = true; # Color picker
      undotree.enable = true;
      diffview-nvim.enable = true;
      yanky-nvim = {
        enable = true;
        setupOpts.ring.storage = "sqlite";
      };
      icon-picker.enable = true;
      surround.enable = true;
      smart-splits.enable = true;
      #nvim-biscuits.enable = true;

      motion = {
        hop.enable = true;
        leap.enable = true;
      };

      images = {
        image-nvim.enable = false; # Uhhhhh, lets see later if we want or not
        img-clip.enable = true;
      };
    };

    notes = {
      neorg.enable = true;
      todo-comments.enable = true;
    };

    # Not sure about this one
    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    statusline.lualine = {
      enable = true;
    };

    formatter.conform-nvim = {
      enable = true;
    };

    autocomplete.blink-cmp = {
      enable = true;
    };

    telescope = {
      enable = true;
    };

    treesitter = {
      context.enable = false;
      enable = true;
    };

    visuals = {
      rainbow-delimiters.enable = true;
      nvim-cursorline = {
        enable = true;

        setupOpts = {
          cursorline = {
            enable = false;
            timeout = 100; # Flickers otherwise
          };

          cursorword = {
            enable = true;
            timeout = 0;
          };
        };
      };

      indent-blankline = {
        enable = true;

        setupOpts = {
          scope = {
            enabled = true;
            highlight = "IblScope";
          };

          indent = {
            tab_char = "·";
          };
        };
      };
    };

    lsp = {
      enable = true;

      formatOnSave = true;
      harper-ls.enable = true;
      lspsaga.enable = false;
      nvim-docs-view.enable = true;
      otter-nvim.enable = true;
      trouble.enable = true;
    };

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };
  };
}
