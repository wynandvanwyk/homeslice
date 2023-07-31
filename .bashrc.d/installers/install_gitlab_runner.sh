install_gitlab_runner() {
    curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
    apt-get install gitlab-runner
}
