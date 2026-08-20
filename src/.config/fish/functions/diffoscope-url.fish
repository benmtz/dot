function diffoscope-url --description 'Download two files from URLs (cached) and diffoscope them'
    set -l urls
    set -l rest

    for a in $argv
        if string match -qr '^https?://' -- $a
            set -a urls $a
        else
            set -a rest $a
        end
    end

    if test (count $urls) -ne 2
        echo "usage: diffoscope-url [diffoscope-args...] URL1 URL2 [diffoscope-args...]" >&2
        echo "       (expected exactly 2 http(s) URLs, got "(count $urls)")" >&2
        return 1
    end

    set -l cache (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo ~/.cache)/diffoscope-url
    mkdir -p $cache

    set -l files
    for u in $urls
        set -l h (echo -n $u | shasum | cut -d' ' -f1)
        set -l dest $cache/$h"_"(basename $u)

        if test -f $dest
            echo "→ cached: $u"
        else
            echo "→ fetching: $u"
            curl -fsSL $u -o $dest.part; or begin
                echo "✗ download failed: $u" >&2
                rm -f $dest.part
                return 1
            end
            mv $dest.part $dest
        end
        set -a files $dest
    end

    echo "→ diffoscope $rest"
    diffoscope $rest $files
end
