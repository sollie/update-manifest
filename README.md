# update-manifests

## Inputs

  * ssh_private_key:
    * description: 'Private key'
    * required: true
  * ssh_auth_sock:
    * description: 'Location of SSH Agent socket'
    * required: false
    * default: "/tmp/ssh_agent.sock"
  * ghes_host:
    * description: "GHES server address"
    * required: true
  * registry_host:
    * description: "Hostname of container registry"
    * required: true
  * manifest_org:
    * description: "Org or username owning manifest repo"
    * required: true
  * manifest_repo:
    * description: "Name of repo containing manifests"
    * required: true
  * manifest_name:
    * description: "Name of manifest"
    * required: true
  * manifest_path:
    * description: "Path of manifests inside repo"
  * image_tag:
    * description: "Image tag"
    * required: true
