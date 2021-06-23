# Building Azure Resources with Azure Devops CI/CD Pipline

1. First, browse to the repository with your name in the Devops Project [BicepHackaton](https://dev.azure.com/basefarm/BicepHackaton)
2. Clone this repository in Vistual Studio Code - we strongly suggest that you install the Bicep extension for VS code if you have not already
3. Please insure that the deployedby and prefix variables included in your starter repository are correct. </br>


Each attendee is provided with a starter repository. This starter repostory inclues : </br>
- A starter pipeline.yaml file in which custom variables need to be set
- 6 Bicep templates for deploying azure resources
- 6 resources deploy.yaml file for deploying the Bicep templates
 
</br>

Each job will be explained and commented as we build the pipeline.yaml file using the following sections. </br>
Be careful with indentation as copy/pasting and formatting can be tricky and pay attention not to leave any extra white space after you edit a piece. </br>
 
 ## Resource Groups 
 On your starter repository, replace the existing "Deploy Resource Groups" job with the following : 
 
 ```yaml
  # Deploy Resource Groups.
  - template: /templates/resources/deploy-resource-groups.yaml
    parameters:
      env: $(env)
      deployedBy: $(deployedBy)
      serviceConnection: $(serviceConnection)
      azLoc: $(azLoc)
      rgNames: [
        "hack-network-rg",
        "$(prefix)-aks-rg",
        "$(prefix)-vm-kv-rg",
        "$(prefix)-aks-vm-rg",
        "$(prefix)-aks-str-rg",
        "$(prefix)-db-rg",
        "$(prefix)-srv-kv-rg",
        "$(prefix)-db-kv-rg"
        ]
 ```
 

## Deploy Keyvault 

Next, paste the section below in your yaml file and update kvIpRules Parameter to include your home IP address. Your objectId should already be included in the keyvault access policies.

```yaml
  # Deploy Keyvaults.
  - template: /templates/resources/deploy-keyvaults.yaml
    parameters:
      env: $(env)
      deployedBy: $(deployedBy)
      serviceConnection: $(serviceConnection)
      azLoc: $(azLoc)
      kvNamesAndRGs: [
        "$(prefix)-srv-kv:$(prefix)-srv-kv-rg",
        "$(prefix)-db-kv:$(prefix)-db-kv-rg",
        "$(prefix)-vm-kv:$(prefix)-vm-kv-rg"
        ]
      azTenantId: $(azTenantId)
      kvAccessPolicies: '[
        {"tenantId":"$(azTenantId)","objectId":"f09e647a-7f78-4be7-9766-34c65cc21960","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"4a58a69d-7e43-458d-ac0a-6a973f5c555e","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"b93d3757-0347-4d2f-b347-d3809365ac56","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"005b755f-4845-41af-9f6d-d085da45c9bc","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"e9592765-a1ba-4ab2-b94b-a0c870a21ba8","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"50a53945-8666-49e9-8068-8381afe8f3b5","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"69bd3625-83fc-49ec-b026-e97055717f68","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"6105e311-ba3c-4899-8da6-0a70251e2d9f","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"d657cc93-2a05-43c5-98c6-b8b55766710c","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"22e877c6-5183-468e-ab6f-db3fa9e373ef","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"7f734da3-5fe6-4d29-82ad-bdfc499e080a","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"3e2604ec-4e62-4e12-8361-333f1a08c529","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"13e3fae5-f15d-4a07-9e85-148463da56d0","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"a1874132-7d5d-4ccd-82fc-2d0ac4450ca5","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"c1b0f2d0-1cb9-4970-945a-5440e33c7efb","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"a6a9dc79-2821-4d9d-a4c9-cb08348c5e30","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"3f4d96c4-a937-4f6a-9f02-b1d6721255b0","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"0a266bb2-7af5-4781-a5b0-b26c1fa61a20","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}},
        {"tenantId":"$(azTenantId)","objectId":"0a266bb2-7af5-4781-a5b0-b26c1fa61a20","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}}
      ]'
```

## Deploy Virtual Machine

To deploy the Virtual Machine you will later use to interact with a private AKS cluster, add the section below to the yaml pipeline. You may can the adminusername parameter if you want to. 

```yaml
  # Deploy VM.
  - template: /templates/resources/deploy-vm.yaml
    parameters:
      env: $(env)
      deployedBy: $(deployedBy)
      serviceConnection: $(serviceConnection)
      azLoc: $(azLoc)
      vmKvName: $(prefix)-vm-kv
      vmRgName: $(prefix)-aks-vm-rg
      vmName: $(prefix)-aks-vm
      vmDiskSize: 100
      vmSize: Standard_DS2_v2
      imagePublisher: Canonical
      imageOffer: UbuntuServer
      imageSku: 18.04-LTS
      imageVersion: latest
      adminusername: linuxadmin
      aksSubnetId: /subscriptions/$(azSubId)/resourceGroups/$(aksVnetRgName)/providers/Microsoft.Network/virtualNetworks/$(aksVnetName)/subnets/$(aksSubnet)
```

## Deploy Storage Account 

Next, add the following section to your .yaml pipeline to deploy a storage account and a fileshare. 

```yaml
  # Deploy Storage Account.
  - template: /templates/resources/deploy-storage.yaml
    parameters:
      env: $(env)
      deployedBy: $(deployedBy)
      serviceConnection: $(serviceConnection)
      azLoc: $(azLoc)
      strRgName: $(prefix)-aks-str-rg
      strFileShareName: $(prefix)fileshare
      strSku: Standard_LRS
      strKind: StorageV2
      strAccessTier: Hot
      strSupportHttpsTrafficOnly: true
      strMinimumTlsVersion: TLS1_2
 ``` 
 
 ## Deploy VNET 
 
 We have not included a VNET deployment as part of this session as a vnet along with a subnet for each attendee was put in place as part of the preparations for the hackaton, however a bicep template as well as a yaml deployment job for a vnet + subnet have been included in your repositories as an exemple that we will review and comment. 
 
 ## Clean-up 
 
 - Resources will be cleaned up by the Hackaton host and redeployed in advance for day 2.
