
window=`tmux list-windows -aF "#S:#W" | fzf-tmux -d 20`

if [[ $? -eq 0 ]]; then
  tmux select-window -t "$window"
fi
