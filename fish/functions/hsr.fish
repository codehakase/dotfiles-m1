function hsr --description "hs-review runs and ledger"
    set -l L ~/.hs-review/skill/scripts/ledger
    set -l repo (command $L repokey)
    set -l runs ~/.hs-review/state/$repo/runs
    switch "$argv[1]"
        case '' last
            set -l f (find $runs -name findings.md -type f 2>/dev/null | sort | tail -1)
            if test -n "$f"; cat $f; else; echo "no runs yet for $repo"; end
        case edit
            set -l f (find $runs -name findings.md -type f 2>/dev/null | sort | tail -1)
            if test -n "$f"; eval $EDITOR $f; else; echo "no runs yet for $repo"; end
        case plan verify
            set -l f (find $runs -name "$argv[1].md" -type f 2>/dev/null | sort | tail -1)
            if test -n "$f"; cat $f; else; echo "no $argv[1].md yet"; end
        case runs
            find $runs -name findings.md -type f 2>/dev/null | sort | sed "s#$runs/##;s#/findings.md##"
        case ledger
            echo "-- suppressed --"; command $L suppressed
            echo "-- deferred --";   command $L deferred
        case rules
            command $L rules
        case upstream
            command ~/.hs-review/skill/scripts/check-upstream.sh
        case '*'
            echo "hsr [last|edit|plan|verify|runs|ledger|rules|upstream]"
    end
end
