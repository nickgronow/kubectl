# Github Action for Kubernetes CLI

This action provides `kubectl` for Github Actions.

## Usage

`.github/workflows/push.yml`

```yaml
on: push
name: deploy
jobs:
  deploy:
    name: deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: deploy to cluster
      uses: nickgronow/kubectl@master
      with:
        config_data: ${{ secrets.kube_config }}
        args: set image --record deployment/my-app container=${{ github.repository }}:${{ github.sha }}
    - name: verify deployment
      uses: nickgronow/kubectl@master
      with:
        config_data: ${{ secrets.kube_config }}
        version: "1.15"
        args: '"rollout status deployment/my-app"'
```

## Secrets

`KUBE_CONFIG_DATA` – **required**: A base64-encoded kubeconfig file with credentials for Kubernetes to access the cluster. You can get it by running the following command:

```bash
cat $HOME/.kube/config | base64
```

## Environment

`KUBECTL_VERSION` - (optional): Used to specify the kubectl version. If not specified, this defaults to kubectl 1.13

**Note**: Do not use kubectl config view as this will hide the certificate-authority-data.
