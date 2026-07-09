# Installed by:
# version = "0.107.0"
# config nu --doc | nu-highlight | less -R

$env.config.buffer_editor = "vim"
$env.PATH = ($env.PATH | append '/usr/bin/vendor_perl')
$env.PATH = ($env.PATH | append "~/.local/bin")
$env.config.history.max_size = 500
$env.config.show_banner = "short"

# === Alias ===

alias samba_start = sudo systemctl start smb.service nmb.service
alias samba_restart = sudo systemctl restart smb.service nmb.service
alias samba_stop = sudo systemctl stop smb.service nmb.service
alias samba_status = sudo systemctl status smb.service nmb.service
alias torr_start = sudo systemctl start torrserver.service
alias torr_restart = sudo systemctl restart torrserver.service
alias torr_stop = sudo systemctl stop torrserver.service
alias torr_status = sudo systemctl status torrserver.service
alias vlc = flatpak run org.videolan.VLC
alias ll = ls -l
alias ls = ls -a
alias ff = fastfetch
alias fl = flatpak update
alias pacup = sudo pacman -Syu
alias wttr = curl wttr.in
alias update-grub = sudo grub-mkconfig -o /boot/grub/grub.cfg
alias birth = sh -c "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"
alias v = vim
alias sv = sudo vim
alias sdst = sudo systemctl start sddm
alias sdsp = sudo systemctl stop sddm
alias sdsr = sudo systemctl restart sddm
alias son = sudo sh -c 'sleep 10s && systemctl suspend'
alias artix = ssh ridge@192.168.1.5

def ss [] {
    sensors | lines | first 6
}

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
