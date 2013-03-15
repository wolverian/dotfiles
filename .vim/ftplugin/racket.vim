nmap ,r :w\|:call Send_to_Tmux('(enter! "' . expand('%') . '")' . "\n")<cr>
