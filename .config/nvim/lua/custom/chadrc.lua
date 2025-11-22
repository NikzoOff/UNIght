-- detect WM
local wm = os.getenv("WM_SESSION") or ""

local theme = "gruvbox"       -- default
if wm == "hyprland" then
    theme = "tokyonight"        -- Hyprland theme
elseif wm == "bspwm" then
    theme = "gruvbox"     -- bspwm theme
end

-- set NvChad theme
vim.g.nvchad_theme = theme
