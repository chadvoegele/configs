# quick change directories
rationalise-dot() {
 if [[ $LBUFFER = *.. ]]; then
   LBUFFER+=/..
 else
   LBUFFER+=.
 fi
}
zle -N rationalise-dot

turbo_left() {
  cmd="vi-backward-char"
  for i in {1..5}; do; zle $cmd; done;
}
zle -N turbo_left

turbo_right() {
  cmd="vi-forward-char"
  for i in {1..5}; do; zle $cmd; done;
}
zle -N turbo_right

bindkey -v
bindkey -M vicmd h vi-backward-char
bindkey -M vicmd H turbo_left
bindkey -M vicmd l vi-forward-char
bindkey -M vicmd L turbo_right
bindkey -M vicmd k vi-up-line-or-history
bindkey -M vicmd j vi-down-line-or-history
bindkey -M vicmd i vi-insert
bindkey -M vicmd '?' history-incremental-pattern-search-backward
bindkey -M vicmd '/' history-incremental-pattern-search-forward
bindkey -M viins '^^' insert-last-word 
bindkey -M viins '^h' backward-delete-char
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^u' kill-whole-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^a' beginning-of-line
bindkey -M viins "^d" delete-char
bindkey -M viins "^f" forward-char
bindkey -M viins "^b" backward-char
bindkey -M viins "^n" down-line-or-history
bindkey -M viins "^p" up-line-or-history
bindkey -M viins "^r" history-incremental-pattern-search-backward
bindkey -M viins "^s" history-incremental-pattern-search-forward
bindkey -M viins "^_" vi-cmd-mode
bindkey -M viins . rationalise-dot
bindkey -M viins "^[[D" backward-char
bindkey -M viins "^[[C" forward-char
bindkey -M isearch . self-insert
KEYTIMEOUT=1
