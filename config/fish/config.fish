if status is-interactive
  fish_vi_key_bindings

  abbr --add gco "git checkout"
  abbr --add gd "git diff"
  abbr --add gdc "git diff --cached"
  abbr --add gf "git fetch"
  abbr --add gfp "git fetch --prune"
  abbr --add gpr "git pull --rebase"
  abbr --add gpu "git push --set-upstream origin"
  abbr --add grh "git reset --hard HEAD^"
  abbr --add grs "git reset --soft HEAD^"
  abbr --add gs "git status"
  abbr --add gsi "git status --ignored"
  abbr --add gsw "git switch"
  abbr --add gsuir "git submodule update --init --recursive"
  abbr --add kc "kubectl"
  abbr --add kcd "kubectl --context=dev"
  abbr --add kcp "kubectl --context=prd"
  abbr --add kcs "kubectl --context=stg"
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish
