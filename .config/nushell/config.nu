# Installed by:
# version = "0.107.0"
# config nu --doc | nu-highlight | less -R

$env.PATH = ($env.PATH | append '/usr/bin/vendor_perl')
$env.PATH = ($env.PATH | append "~/.local/bin")
$env.config.history.max_size = 500
$env.config.show_banner = "short"
$env.config.buffer_editor = "vim"
$env.EDITOR = "vim"

# ==== ALIASES ====

# === (Samba, TorrServer) ===

#def samba_start []   { sudo systemctl start smb.service nmb.service }
#def samba_restart [] { sudo systemctl restart smb.service nmb.service }
#def samba_stop []    { sudo systemctl stop smb.service nmb.service }
#def samba_status []  { sudo systemctl status smb.service nmb.service }

#def torr_start []   { sudo systemctl start torrserver.service }
#def torr_restart [] { sudo systemctl restart torrserver.service }
#def torr_stop []    { sudo systemctl stop torrserver.service }
#def torr_status []  { sudo systemctl status torrserver.service }

# === Utilities ===

alias ll = ls -l
alias ls = ls -a
alias ff = fastfetch
#alias fl = flatpak update
alias wttr = curl wttr.in
alias update-grub = doas grub-mkconfig -o /boot/grub/grub.cfg
alias v = vim
alias dv = doasedit
alias sx = startx
alias ea = doas emaint -a sync
alias es = doas emerge -avuDN @world
alias esx = doas emerge -avuDN @world --exclude sys-kernel/gentoo-kernel
alias ec = doas emerge -cav

# === Logs and Diagnostics ===

def dudush [] { doas dmesg -TH --level=err+ }
def tt [] { sys temp | sort-by unit | first 6 }
#def jopa [] { journalctl -b -0 -p err..emerg }#

# === Power Management ===

def son [] {
    sleep 3sec
    loginctl suspend
}

def off [] {
    sleep 3sec
    loginctl poweroff
}

def rec [] {
    sleep 3sec
    loginctl reboot
}

# === Changing the keyboard layout ===

def aze [] {
    setxkbmap -layout "us,az" -option "grp:caps_toggle"
    xmodmap ~/.Xmodmap
}
def rus [] {
    setxkbmap -layout "us,ru" -option "grp:caps_toggle"
    xmodmap ~/.Xmodmap
}

# === System lifetime ===

def birth [] {
    sh -c 'birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days'
}

# ==== Carapace ====

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

# ==== Starship ====

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# ==== Yazi ====

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}
