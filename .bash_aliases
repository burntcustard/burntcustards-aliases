
#########
# SETUP #
#########

# Enable extended pattern matching (used by some of the following aliases)
shopt -s extglob


###########
# GENERAL #
###########

alias ls='ls -A --color="auto"'
alias ll='ls -Al'
alias ..='cd ..'
alias rm='rm -r'
alias wget='wget --content-disposition'  # (Usually) corrects filenames

# Remove all except $1. Brackets must be used for inputs with special chars
rmx() {
  rm -rv !($1)
}

# Move the contents out of subfolder into current dir
mvout() {
  cp -r $@. . && rm $@
}

# Repeat the following text (basically just echo)
say() {
  echo $@
}

# Test if a string contains a substring
contains() {
  if [[ $1 = *"$2"* ]]; then
    echo $1 does contain $2\!
    return 1
  fi
}

# Create a directory and then cd into it
mkdircd() {
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

# Download a zip file from a URL, extract it here, delete the downloaded zip.
getzip() {
  wget -nv --show-progress -O temp $@
  unzip -q temp
  rm temp
}

# Wrapper around unzip to allow fetching & extracting files from the interwebs
unzip() {
  if [[ $@ = *"https://"* ||  $@ = *"http://"* ]]; then
    wget -q --show-progress -O Downloading $@
    echo -n "Extracting... "
    command unzip -q Downloading
    rm Downloading
    echo "Done!"
  else
    command unzip -q $@
  fi
}

# Rename all files in the current dir to lowercase
lowercase() {
  for i in $( ls | grep [A-Z] ); do mv -i $i `echo $i | tr 'A-Z' 'a-z'`; done
}

# Rename files in the current dir to lowercase, hypen-not-underscore
kebabcase() {
  for i in $( ls | grep [A-Z] ); do mv -i $i `echo $i | tr 'A-Z' 'a-z' | tr '_' '-'`; done
}


########
# URLs #
########

alias fractions='open http://unicodefractions.com/'


########
# META #
########

# Quick editing and reloading of aliases
aliases() {
  nano ~/.bash_aliases &&
  source ~/.bash_aliases 
}


###############
# OS SPECIFIC #
###############

# Open network preferences file on Raspberry Pi
alias wifi='sudo nano /etc/wpa_supplicant/wpa_supplicant.conf'

# Open custom keyboard shortcust file & key event viewer on Mac
alias keymods='brackets ~/.config/karabiner/karabiner.json'
alias keyevents='open /Applications/Karabiner-EventViewer.app/'

# PS1 (if supported & git installed)
export PS1="\[\033[38;5;11m\]John@\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[95m\]\`__git_ps1\`\[\033[38;5;15m\]\$ \[$(tput sgr0)\]"

# Prefer nano for text editing
export EDITOR=nano



