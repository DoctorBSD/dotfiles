# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.buffer_editor = "vim"
$env.PATH = ($env.PATH | append '/usr/bin/vendor_perl')
$env.PATH = ($env.PATH | append "~/.local/bin")
$env.config.history.max_size = 500
$env.config.show_banner = "short"

# === Alias ===

alias start_samba = sudo systemctl start smb.service nmb.service
alias stop_samba = sudo systemctl stop smb.service nmb.service
alias status_samba = sudo systemctl status smb.service nmb.service
alias restart_samba = sudo systemctl restart smb.service nmb.service
alias start_torr = sudo systemctl start torrserver.service
alias stop_torr = sudo systemctl stop torrserver.service
alias status_torr = sudo systemctl status torrserver.service
alias vlc = flatpak run org.videolan.VLC
alias ll = ls -l
alias ls = ls -a
alias ff = fastfetch
alias fl = flatpak update
alias pacup = sudo pacman -Syu
alias wttr = curl wttr.in
alias update-grub = sudo grub-mkconfig -o /boot/grub/grub.cfg
alias birth = sh -c "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"
alias sul = sudo loginctl unlock-sessions

# === Carapace ===

let carapace_completer = {|spans: list<string>|
    let expanded_alias = (scope aliases | where name == $spans.0 | get -o 0.expansion)
    let spans = (if $expanded_alias != null  {
        $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
    } else { $spans })

    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
}


$env.config.completions.external = {
    enable: true
    max_results: 100
    completer: $carapace_completer
}

# === Starship ===

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
