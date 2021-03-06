![Continuous Integration](https://github.com/nickgronow/kubectl/workflows/Continuous%20Integration/badge.svg)

# Github Action for Kubernetes CLI

This action provides `kubectl` for Github Actions.

## Why another Kubectl Github Action?

We need a Kubectl action that has already been built with an image hosted on Docker Hub.  Every other Kubectl action in the marketplace build an image every time they run.  I will be maintaining a built image hosted on docker hub that hopefully stays up-to-date with the Bitnami Kubectl.  This shaves off quite a bit of time in your pipeline.

## Usage

In your workflow, here is an example that deploys your new image and verifies it is successful.

```yaml
on: push
name: Deploy
jobs:
  deploy:
    name: Deploy to cluster
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Deploy to cluster
      uses: nickgronow/kubectl@master
      with:
        config_data: ${{ secrets.kube_config }}
        args: set image --record deployment/<my-deploy> <my-container>=<my-image>:<new-tag>
    - name: Verify deployment
      uses: nickgronow/kubectl@master
      with:
        config_data: ${{ secrets.kube_config }}
        args: '"rollout status deployment/<my-deploy>"'
```

## Kube configuration

Make sure to base64-encode your kubeconfig file and put it in a github secret.  You can get the string by running:

```bash
cat $HOME/.kube/config | base64
```

## Kubectl version

The Kubectl version that is used is driven by the action version you specify.  If you want to use the latest kubectl version, simply provide `master` as the ref.  To select a specific version, simply change the ref in the `uses` option, like so:

```yaml
steps:
- name: Step Name
  uses: nickgronow/kubectl@v1.15
```

## Supported kubectl tags

* master
* v1.17.4
* v1.17.3
* v1.17
* v1.16
* v1.15
* v1.14
* v1.13
* v1.12
