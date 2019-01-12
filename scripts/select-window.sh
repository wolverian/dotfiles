
window=`tmux list-windows -aF "#S:#W" | fzf-tmux -d 20`

if [[ $? -eq 0 ]]; then
  tmux switch-client -t "$window"
fi
