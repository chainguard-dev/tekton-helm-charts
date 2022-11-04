# Helm Charts


[Helm](https://helm.sh) Charts to support the [Tekton](https://tekton.dev/) project.

## Usage

Charts are available in the following formats:

* [Chart Repository](https://helm.sh/docs/topics/chart_repository/)

### Installing from the Chart Repository

The following command can be used to add the chart repository:

```shell
helm repo add tekton https://chainguard-dev.github.io/tekton-helm-charts
helm repo update
```

Once the chart has been added, install one of the available charts:

```shell
helm upgrade -i <release_name> tekton/<chart_name>
```


## Provenance

Charts are signed using the [provenance methods provided by the Helm project](https://helm.sh/docs/topics/provenance/) as well as uploaded to the [Rekor transparency server](https://github.com/sigstore/rekor) using the [Helm sigstore plugin](https://github.com/sigstore/helm-sigstore).

Verification of the signed charts can be accomplished by importing the GPG Public Key that was used to sign the associated chart.

```shell
cat security/pubkey.gpg | gpg --import --batch
```

Once the public key has been imported, charts can be verified using the `helm verify` and/or `helm tekton verify` commands.

NOTE: The public key that was used to sign a particular chart may not be identical to the public key on the `main` branch. Each chart release has an associated git tag. The public key that was used to sign the particular chart will be included in this tag.

## Charts

* [tekton-pipelines](charts/tekton-pipelines)
* [tekton-chains](charts/tekton-chains)
* [tekton-dashboard](charts/tekton-dashboard)


## Updates

Each new release will have new values for things like images etc. 

1. Download and helmify the new release.yaml 
`make update_CHARTNAME`

2. Update the chart version and appVersion. 

3. Verify the RBACs work, sometimes the config names aren't updated properly. 

4. Verify the charts install with `ct install --config ct.yaml`

5. Update the Chart's readme [helm-docs](https://github.com/norwoodj/helm-docs)

6. Commit changes, merge to main will deploy new charts.
