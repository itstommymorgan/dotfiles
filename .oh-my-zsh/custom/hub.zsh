alias git="hub"

git-smart-sync() {
  github_check=$((`git remote -v | grep github | wc -l`))
  if [ $github_check -eq 0 ]; then
     # this is not a github repo, so just run my up alias
    git up
  else
    # this is a github repo, so run sync
    git sync
  fi
}
