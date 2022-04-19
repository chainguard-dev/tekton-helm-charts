# tekton-dashboard

![Version: 0.2.1](https://img.shields.io/badge/Version-0.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.24.1](https://img.shields.io/badge/AppVersion-v0.24.1-informational?style=flat-square)

A Helm chart for Tekton Dashboards

**Homepage:** <https://github.com/tektoncd/dashboard>

## Values

| Key                                            | Type   | Default                                                                                                                          | Description |
|------------------------------------------------|--------|----------------------------------------------------------------------------------------------------------------------------------|-------------|
| dashboardDeployment.container.image.digest     | string | `"sha256:fe4febbb74ca3e7027c29719e32e38074b3af6be588ee08cca5826f21fa003a1"`                                                      |             |
| dashboardDeployment.container.image.repository | string | `"gcr.io/tekton-releases/github.com/tektoncd/dashboard/cmd/dashboard"`                                                           |             |
| dashboardDeployment.container.image.tag        | string | `"v0.24.1"`                                                                                                                      |             |
| dashboardDeployment.container.port             | int    | `9097`                                                                                                                           |             |
| dashboardDeployment.replicas                   | int    | `1`                                                                                                                              |             |
| icon                                           | string | `"https://github.com/cdfoundation/artwork/blob/main/tekton/additional-artwork/tekton_dashboard/color/TektonDashboard_color.svg"` |             |

