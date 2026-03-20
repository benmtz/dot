function docker-grep-and-kill

    docker ps |\
        grep $argv |\
        awk '{print $1}' |\
        xargs -I{} docker kill {}

end
