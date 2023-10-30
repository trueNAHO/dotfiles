# @url https://unix.stackexchange.com/questions/85374/loadkeys-gives-permission-denied-for-normal-user
# Set keyboard layout to 'us' (login shell).
loadkeys us
# Swap 'Control' and 'Caps_Lock' (login shell). File must end with newline!
loadkeys < <(printf '%s\n' \
    "keymaps 0-6,8-9,12" \
    "keycode 58 = Control" \
    "keycode 29 = Caps_Lock"
)

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
