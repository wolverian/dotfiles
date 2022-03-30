
def grep [pattern: string] {
  (
    rg --json $pattern
    | from json -o
    | where type == "match"
    | get data
    | select line_number path.text lines.text
    | rename line_number path match
  )
}

def edit [] {
  collect { |match| nvim -c $':($match.line_number)' $match.path }
}

def fe [] {
  fd -t file | fzf --height 20 | str trim | nvim $in
}

alias g = git
alias e = nvim
