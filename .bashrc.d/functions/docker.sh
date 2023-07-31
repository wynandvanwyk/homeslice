function osim_docker_cleanup() {
  if $(gum confirm "would you like to delete all stopped docker containers?"); then
    docker rm $(docker ps -a -q)
  fi

  if $(gum confirm "would you like to delete all dangling docker images?"); then
    docker image prune
  fi

  if $(gum confirm "would you like to delete all unused docker images?"); then
    docker image prune --all
  fi

  if $(gum confirm "would you like to delete all unreferenced docker volumes?"); then
    docker volume prune
  fi
}
