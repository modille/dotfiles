function gg --description "git get a repo and cd into it"
    if test (count $argv) -eq 0
        echo "[gg] usage: gg <github-url-or-path>"
        return 1
    end

    # Strip protocol if present
    set -l input (string replace -r '^https?://' '' $argv[1])

    # Take only host/owner/repo (first 3 path segments)
    set -l parts (string split '/' $input)
    if test (count $parts) -lt 3
        echo "[gg] expected at least host/owner/repo, got: $input"
        return 1
    end
    set -l repo_path "$parts[1]/$parts[2]/$parts[3]"

    git get $repo_path
    or return 1

    cd ~/git/$repo_path
end
