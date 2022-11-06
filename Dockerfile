FROM bitnami/kubectl:1.21.14

LABEL version="1.0.2"
LABEL name="kubectl"
LABEL repository="http://github.com/nickgronow/kubectl"
LABEL homepage="http://github.com/nickgronow/kubectl"

LABEL maintainer="Nick Gronow <nick@wov.io>"
LABEL com.github.actions.name="Kubernetes CLI - kubectl"
LABEL com.github.actions.description="Runs kubectl"
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="blue"

COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]

