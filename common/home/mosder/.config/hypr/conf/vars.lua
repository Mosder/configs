-------------------
---- VARIABLES ----
-------------------

return {
  -- Files and locations
  scripts_dir = os.getenv 'HOME' .. '/.config/hypr/scripts',
  log_file = os.getenv 'HOME' .. '/.hypr.log',

  -- Used programs
  browser = 'brave --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-features=UseChromeOSDirectVideoDecoder',
  discord = 'discord --enable-features=UseOzonePlatform --ozone-platform=wayland',
  terminal = 'wezterm',
  editor = 'nvim',
  steam = 'steam',
  file_manager = 'thunar',
  menu = 'wofi',
  lockscreen = 'hyprlock',
  status_bar = 'waybar',
  wallpaper_manager = 'hyprpaper',
  idle_manager = 'hypridle',
  automount = 'udiskie',
  osd = 'swayosd',
  notification_daemon = 'dunst',
  color_picker = 'hyprpicker',
  screenshot = 'hyprshot',
}
