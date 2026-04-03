{ self, inputs, ... }:

{
  flake.modules.generic.niri-binds = { pkgs, lib, ... }: {
    settings.binds = {
      "Mod+Return".spawn-sh = "alacritty";
      # Keys consist of modifiers separated by + signs, followed by an XKB key name
      # in the end. To find an XKB name for a particular key, you may use a program
      # like wev.
      #
      # "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
      # when running as a winit window.
      #
      # Most actions that you can bind here can also be invoked programmatically with
      # `niri msg action do-something`.

      # Mod-Shift-/, which is usually the same as Mod-?,
      # shows a list of important hotkeys.
      
      "Mod+Shift+Slash".show-hotkey-overlay = _: {};
      "Mod+Ctrl+Space" = {
        _attrs = {
          hotkey-overlay-title="Toggle Music Playback";
          allow-when-locked=true;
        };
        spawn = [ "mpc" "toggle" ];
      };
      "Mod+Ctrl+Alt+J" = {
        _attrs = {
          hotkey-overlay-title="Music Volume Down";
          allow-when-locked=true;
        };
        spawn = [ "mpc" "volume" "-10" ];
      };
      "Mod+Ctrl+Alt+K" = {
        _attrs = {
          hotkey-overlay-title="Music Volume Up";
          allow-when-locked=true;
        };
        spawn = [ "mpc" "volume" "+10" ];
      };
      "Mod+Ctrl+Alt+H" = {
        _attrs = {
          hotkey-overlay-title="Previous Music Track";
          allow-when-locked=true;
        };
        spawn = [ "mpc" "prev" ];
      };
      "Mod+Ctrl+Alt+L" = {
        _attrs = {
          hotkey-overlay-title="Next Music Track";
          allow-when-locked=true;
        };
        spawn = [ "mpc" "next" ];
      };
      "Mod+Ctrl+Alt+Left" = {
        _attrs = {
          hotkey-overlay-title="Rewind Music";
          allow-when-locked=true;
        };
        spawn = [  "mpc" "seek" "-10" ];
      };
      "Mod+Ctrl+Alt+Right" = {
        _attrs = {
          hotkey-overlay-title="Skip Forward in Music";
          allow-when-locked=true;
        };
        spawn = [ "mpc" "seek" "+10" ];
      };
      "Mod+Left" = {
        _attrs = {
	        hotkey-overlay-title="Move Cursor Left";
        };
        spawn = [ "wlrctl" "pointer" "move" "-30" "0" ];
      };

      "Mod+Right" = {
        _attrs = {
	        hotkey-overlay-title="Move Cursor Right";
        };
        spawn = [ "wlrctl" "pointer" "move" "30" "0" ];
      };

      "Mod+Up" = {
        _attrs = {
	        hotkey-overlay-title="Move Cursor Up";
        };
        spawn = [ "wlrctl" "pointer" "move" "0" "-30" ];
      };
      "Mod+Down" = {
        _attrs = {
	        hotkey-overlay-title="Move Cursor Down";
        };
        spawn = [ "wlrctl" "pointer" "move" "0" "30" ];
      };
      "Mod+Period" = {
        _attrs = {
	        hotkey-overlay-title="Left Click";
        };
        spawn = [ "wlrctl" "pointer" "click" "left" ];
      };
      "Mod+Slash" = {
        _attrs = {
	        hotkey-overlay-title="Right Click";
        };
        spawn = [ "wlrctl" "pointer" "click" "right" ];
      };
      "Mod+B".spawn = "qutebrowser";
      "Mod+E".spawn = [ "emacsclient" "-c" ];
      "Mod+Ctrl+Alt+S" = {
        _attrs = {
          hotkey-overlay-title="Suspend and Lock";
          allow-when-locked=true;
        };
        spawn = [ "sh" "-c" "systemctl suspend && swaylock" ];
      };

      # suggested binds for running programs: terminal, app launcher, screen locker.

      "Mod+D" = {
        _attrs = {
          hotkey-overlay-title="Run an Application: fuzzel";
        };
        spawn = "fuzzel";
      };
      "Super+Alt+L" = {
        _attrs = {
          hotkey-overlay-title="Lock the Screen: swaylock";
        };
        spawn = "hyprlock";
      };

      # You can also use a shell. Do this if you need pipes, multiple commands, etc.
      # Note: the entire command goes as a single argument in the end.
      # Mod+T { spawn "bash" "-c" "notify-send hello && exec alacritty"; }

      # Example volume keys mappings for PipeWire & WirePlumber.
      # The allow-when-locked=true property makes them work even when the session is locked.
      "XF86AudioRaiseVolume" = {
        _attrs = {
          allow-when-locked=true;
          hotkey-overlay-title="Raise the volume";
        };
        spawn = [ "wpctl" "set-volume" "@DEFAULT_SINK@" "5%+" ];
      };
      "XF86AudioLowerVolume" = {
        _attrs = {
          allow-when-locked=true;
          hotkey-overlay-title="Lower the volume";
        };
        spawn = [ "wpctl" "set-volume" "@DEFAULT_SINK@" "5%-" ];
      };
      "XF86AudioMute" = {
        _attrs = {
          allow-when-locked=true;
          hotkey-overlay-title="Mute the audio";
        };
        spawn = [ "wpctl" "set-mute" "@DEFAULT_SINK@" "toggle" ];
      };
      "XF86AudioMicMute" = {
        _attrs = {
          allow-when-locked=true;
          hotkey-overlay-title="Mute the microphone";
        };
        spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
      };

      "XF86MonBrightnessUp" = {
        _attrs = {
          allow-when-locked=true;
          hotkey-overlay-title="Raise the brightness";
        };
        spawn = [ "brightnessctl" "set" "+5%" ];
      };
      "XF86MonBrightnessDown" = {
        _attrs = {
          allow-when-locked=true;
          hotkey-overlay-title="Lower the brightness";
        };
        spawn = [ "brightnessctl" "set" "5%-" ];
      };

      # Open/close the Overview: a zoomed-out view of workspaces and windows.
      # You can also move the mouse into the top-left hot corner,
      # or do a four-finger swipe up on a touchpad.
      "Mod+O".toggle-overview = _: {};

      "Mod+Q".close-window = _: {};

      # "Mod+Left".spawn =  { focus-column-left; };
      # "Mod+Down".spawn = { focus-window-down; };
      # "Mod+Up".spawn =    { focus-window-up; };
      # "Mod+Right".spawn = { focus-column-right; };
      "Mod+H".focus-column-left = _: {};
      "Mod+J".focus-window-or-workspace-down = _: {};
      "Mod+K".focus-window-or-workspace-up = _: {};
      "Mod+L".focus-column-right = _: {};

      "Mod+Ctrl+Left".move-column-left = _: {};
      "Mod+Ctrl+Down".move-window-down = _: {};
      "Mod+Ctrl+Up".move-window-up = _: {};
      "Mod+Ctrl+Right".move-column-right = _: {};
      "Mod+Ctrl+H".move-column-left = _: {};
      "Mod+Ctrl+J".move-window-down = _: {};
      "Mod+Ctrl+K".move-window-up = _: {};
      "Mod+Ctrl+L".move-column-right = _: {};

      # Alternative commands that move across workspaces when reaching
      # the first or last window in a column.
      # "Mod+J".spawn =     { focus-window-or-workspace-down; };
      # "Mod+K".spawn =     { focus-window-or-workspace-up; };
      # "Mod+Ctrl+J".spawn =     { move-window-down-or-to-workspace-down; };
      # "Mod+Ctrl+K".spawn =     { move-window-up-or-to-workspace-up; };

      "Mod+Home".focus-column-first = _: {};
      "Mod+End".focus-column-last = _: {};
      "Mod+Ctrl+Home".move-column-to-first = _: {};
      "Mod+Ctrl+End".move-column-to-last = _: {};

      "Mod+Shift+Left".focus-monitor-left = _: {};
      "Mod+Shift+Down".focus-monitor-down = _: {};
      "Mod+Shift+Up".focus-monitor-up = _: {};
      "Mod+Shift+Right".focus-monitor-right = _: {};
      "Mod+Shift+H".focus-monitor-left = _: {};
      "Mod+Shift+J".focus-monitor-down = _: {};
      "Mod+Shift+K".focus-monitor-up = _: {};
      "Mod+Shift+L".focus-monitor-right = _: {};

      "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: {};
      "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: {};
      "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: {};
      "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: {};
      "Mod+Shift+Ctrl+H".move-column-to-monitor-left = _: {};
      "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: {};
      "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: {};
      "Mod+Shift+Ctrl+L".move-column-to-monitor-right = _: {};

      # Alternatively, there are commands to move just a single window:
      # Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
      # ...

      # And you can also move a whole workspace to another monitor:
      # Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
      # ...

      "Mod+Page_Down".focus-workspace-down = _: {};
      "Mod+Page_Up".focus-workspace-up = _: {};
      "Mod+U".focus-workspace-down = _: {};
      "Mod+I".focus-workspace-up = _: {};
      "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _: {};
      "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _: {};
      "Mod+Ctrl+U".move-column-to-workspace-down = _: {};
      "Mod+Ctrl+I".move-column-to-workspace-up = _: {};

      # Alternatively, there are commands to move just a single window:
      # Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
      # ...

      "Mod+Shift+Page_Down".move-workspace-down = _: {};
      "Mod+Shift+Page_Up".move-workspace-up = _: {};
      "Mod+Shift+U".move-workspace-down = _: {};
      "Mod+Shift+I".move-workspace-up = _: {};

      # You can bind mouse wheel scroll ticks using the following syntax.
      # These binds will change direction based on the natural-scroll setting.
      #
      # To avoid scrolling through workspaces really fast, you can use
      # the cooldown-ms property. The bind will be rate-limited to this value.
      # You can set a cooldown on any bind, but it's most useful for the wheel.
      "Mod+WheelScrollDown" = {
        _attrs = {
          cooldown-ms = 150;
        };
        focus-workspace-down = _: {};
      };
      "Mod+WheelScrollUp" = {
        _attrs = {
          cooldown-ms = 150;
        };
        focus-workspace-up = _: {};
      };

      "Mod+Ctrl+WheelScrollDown" = {
        _attrs = {
          cooldown-ms = 150;
        };
        move-column-to-workspace-down = _: {};
      };
      
      "Mod+Ctrl+WheelScrollUp" = {
        _attrs = {
          cooldown-ms = 150;
        };
        move-column-to-workspace-up = _: {};
      };

      "Mod+WheelScrollRight".focus-column-right = _: {};
      "Mod+WheelScrollLeft".focus-column-left = _: {};
      "Mod+Ctrl+WheelScrollRight".move-column-right = _: {};
      "Mod+Ctrl+WheelScrollLeft".move-column-left = _: {};

      # Usually scrolling up and down with Shift in applications results in
      # horizontal scrolling; these binds replicate that.
      "Mod+Shift+WheelScrollDown".focus-column-right = _: {};
      "Mod+Shift+WheelScrollUp".focus-column-left = _: {};
      "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _: {};
      "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _: {};

      # Similarly, you can bind touchpad scroll "ticks".
      # Touchpad scrolling is continuous, so for these binds it is split into
      # discrete intervals.
      # These binds are also affected by touchpad's natural-scroll, so these
      # example binds are "inverted", since we have natural-scroll enabled for
      # touchpads by default.
      # Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
      # Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

      # You can refer to workspaces by index. However, keep in mind that
      # niri is a dynamic workspace system, so these commands are kind of
      # "best effort". Trying to refer to a workspace index bigger than
      # the current workspace count will instead refer to the bottommost
      # (empty) workspace.
      #
      # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
      # will all refer to the 3rd workspace.
      "Mod+1".focus-workspace = "w1";
      "Mod+2".focus-workspace = "w2";
      "Mod+3".focus-workspace = "w3";
      "Mod+4".focus-workspace = "w4";
      "Mod+5".focus-workspace = "w5";
      "Mod+6".focus-workspace = "w6";
      "Mod+7".focus-workspace = "w7";
      "Mod+8".focus-workspace = "w8";
      "Mod+9".focus-workspace = "w9";
      "Mod+Ctrl+1".move-column-to-workspace = "w1";
      "Mod+Ctrl+2".move-column-to-workspace = "w2";
      "Mod+Ctrl+3".move-column-to-workspace = "w3";
      "Mod+Ctrl+4".move-column-to-workspace = "w4";
      "Mod+Ctrl+5".move-column-to-workspace = "w5";
      "Mod+Ctrl+6".move-column-to-workspace = "w6";
      "Mod+Ctrl+7".move-column-to-workspace = "w7";
      "Mod+Ctrl+8".move-column-to-workspace = "w8";
      "Mod+Ctrl+9".move-column-to-workspace = "w9";

      # Alternatively, there are commands to move just a single window:
      # Mod+Ctrl+1 { move-window-to-workspace 1; }

      # Switches focus between the current and the previous workspace.
      # Mod+Tab { focus-workspace-previous; }

      # The following binds move the focused window in and out of a column.
      # If the window is alone, they will consume it into the nearby column to the side.
      # If the window is already in a column, they will expel it out.
      "Mod+BracketLeft".consume-or-expel-window-left = _: {};
      "Mod+BracketRight".consume-or-expel-window-right = _: {};

      # Consume one window from the right to the bottom of the focused column.

      # Expel the bottom window from the focused column to the right.


      "Mod+R".switch-preset-column-width = _: {};
      "Mod+Shift+R".switch-preset-window-height = _: {};
      "Mod+Ctrl+R".reset-window-height = _: {};
      "Mod+F".maximize-column = _: {};
      "Mod+Shift+F".fullscreen-window = _: {};

      # Expand the focused column to space not taken up by other fully visible columns.
      # Makes the column "fill the rest of the space".
      "Mod+Ctrl+F".expand-column-to-available-width = _: {};

      # Mod+C { center-column; }

      # Center all fully visible columns on screen.
      "Mod+Ctrl+C".center-visible-columns = _: {};

      # Finer width adjustments.
      # This command can also:
      # * set width in pixels: "1000"
      # * adjust width in pixels: "-5" or "+5"
      # * set width as a percentage of screen width: "25%"
      # * adjust width as a percentage of screen width: "-10%" or "+10%"
      # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
      # set-column-width "100" will make the column occupy 200 physical screen pixels.
      "Mod+Minus".set-column-width = "-5%";
      "Mod+Equal".set-column-width = "+5%";

      # Finer height adjustments when in column with other windows.
      "Mod+Shift+Minus".set-window-height = "-10%";
      "Mod+Shift+Equal".set-window-height = "+10%";

      # Move the focused window between the floating and the tiling layout.
      "Mod+V".toggle-window-floating = _: {};
      "Mod+Shift+V".switch-focus-between-floating-and-tiling = _: {};

      # Toggle tabbed column display mode.
      # Windows in this column will appear as vertical tabs,
      # rather than stacked on top of each other.
      "Mod+W".toggle-column-tabbed-display = _: {};

      # Actions to switch layouts.
      # Note: if you uncomment these, make sure you do NOT have
      # a matching layout switch hotkey configured in xkb options above.
      # Having both at once on the same hotkey will break the switching,
      # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
      # Mod+Space       { switch-layout "next"; }
      # Mod+Shift+Space { switch-layout "prev"; }

      "Print".screenshot = _: {};
      "Ctrl+Print".screenshot-screen = _: {};
      # "Alt+Print".screenshot-window = _: {};

      # Applications such as remote-desktop clients and software KVM switches may
      # request that niri stops processing the keyboard shortcuts defined here
      # so they may, for example, forward the key presses as-is to a remote machine.
      # It's a good idea to bind an escape hatch to toggle the inhibitor,
      # so a buggy application can't hold your session hostage.
      #
      # The allow-inhibiting=false property can be applied to other binds as well,
      # which ensures niri always processes them, even when an inhibitor is active.
      "Mod+Escape" = {
        _attrs = {
          allow-inhibiting=false;
        };
        toggle-keyboard-shortcuts-inhibit = _: {};
      };

      # The quit action will show a confirmation dialog to avoid accidental exits.
      "Mod+Shift+E".quit = _: {};
      
      # Powers off the monitors. To turn them back on, do any input like
      # moving the mouse or pressing any other key.
      "Mod+Shift+P".power-off-monitors = _: {};
    };
  };
}
