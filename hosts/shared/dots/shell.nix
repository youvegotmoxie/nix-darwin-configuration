{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "k8s dev";

  nativeBuildInputs = with pkgs; [
    awscli2
    azure-cli
    cilium-cli
    cmctl
    k9s
    kops
    kubeseal
    hubble
    k8sgpt
    kustomize
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    kubernetes-helm
    kubectl
    kubectx
    packer
    vault
    terraform
    neovim
  ];
}
