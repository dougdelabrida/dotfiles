set -g status-interval 3
set-option -g status-position bottom
set-option -g pane-active-border-style "fg=green"
set-option -g pane-border-style "fg=brightwhite"
set-option -g message-style "bg=green,fg=black"
set-option -g message-command-style "bg=green,fg=black"

# Status line
set -g status-style default
set -g status-right-length 80
set -g status-left-length 100
set -g status-bg "default"

#Bars ---------------------------------
set -g status-left "#[bg=default,fg=white][#S] "

set -g status-right "#[bg=default,fg=white] %Y-%m-%d #[bg=white,fg=black] %I:%M #[bg=default,fg=white] @#H "

# Windows ------------------------------
set -g window-status-separator "|"
set -g status-justify left

set -g window-status-format "#[fg=white,bg=brightblack] #{?window_zoomed_flag,  ,}#W "
set -g window-status-current-format "#[bg=brightwhite,fg=black] #W #{?window_zoomed_flag,  ,}"
