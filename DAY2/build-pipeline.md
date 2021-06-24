# Building Azure Resources with Azure Devops CI/CD Pipline - Part 2 

If you still have Tuesday's repository saved on your computer, pull the latest changes as we have added new files and updated others. Else, browse to the BicepHackaton Devops Project and clone the repository named after you. General tips : 

- Be EXTRA careful with indentation and extra white spaces
- Be patient - as we experienced Friday, build can fail for reasons beyond our control. 

## Recap from Tuesday 

At this point, your pipeline should look like this with suche {VALUES} replaced with your custom ones : 

```yaml
# Build is manually triggered from the [main] branch in the Repo.

trigger:
- none

# Using an Azure DevOps Microsoft-Hosted Linux Agent.
pool: bicep-hackaton

# Standard Variables.
variables:
  env: demo
  deployedBy: {YOUR_EMAIL}
  serviceConnection: devops-bicephackaton-spn
  azSubId: b3df4070-f1b7-44c5-8d1b-52f0e5590c74
  azTenantId: cb05d17b-90dd-49f6-a513-7c45f5343852
  azLoc: westeurope
  prefix: {YOUR_PREFIX}

# Network variables 
  aksVnetRgName: hack-network-rg
  aksVnetName: hack-vnet
  aksSubnet: {YOUR_VNET}

stages:

# Deploy Azure Resources.
- stage: deploy_azure_resources
  displayName: Deploy Azure Resources

  jobs:

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
        {"tenantId":"$(azTenantId)","objectId":"0a266bb2-7af5-4781-a5b0-b26c1fa61a20","permissions":{"keys":[],"secrets":["Get","List","Set"],"certificates":[]}}
      ]'
      kvIpRules: '[
        {"value": "20.71.230.186"},
        {"value": "84.115.208.19"},
        {"value": "213.47.155.102"},
        {"value": "YOUR_IP"}
      ]'
      kvVirtualNetworkRules: '[
        {"id": "/subscriptions/$(azSubId)/resourceGroups/$(aksVnetRgName)/providers/Microsoft.Network/virtualNetworks/$(aksVnetName)/subnets/hack-snet-1"},
        {"id": "/subscriptions/$(azSubId)/resourceGroups/$(aksVnetRgName)/providers/Microsoft.Network/virtualNetworks/$(aksVnetName)/subnets/$(aksSubnet)"}
      ]'

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

## Deploy AKS 

Add the following section to deploy a [PRIVATE/PUBLIC ?] AKS cluster. This deployment can take up to 15min to run.

```yaml
# Deploy AKS 
- stage: deploy_aks
  displayName: Deploy AKS
  jobs:

  # Deploy AKS.
  - template: /templates/resources/deploy-aks.yaml
    parameters:
      serviceConnection: $(serviceConnection)
      azLoc: $(azLoc)
      aksRgName: $(prefix)-aks-rg
      aksClusterName: $(prefix)-az-k8s
      aksClusterDnsPrefix: $(prefix)-az-k8s
      aksSubnetId: /subscriptions/$(azSubId)/resourceGroups/$(aksVnetRgName)/providers/Microsoft.Network/virtualNetworks/$(aksVnetName)/subnets/$(aksSubnet)
      aksClusterAdminUsername: linuxadmin
      nodePoolCount: 2
      nodePoolMaxCount: 5
      nodePoolMinCount: 2
      nodeResourceGroupName: $(prefix)-aks-nodes-rg
      nodePoolEnableAutoScaling: true
      aadEnabled: false
      aksClusterEnablePrivateCluster: true
      aadProfileManaged: false
      aadProfileEnableAzureRBAC: false
```

Next, add the following stage and task for postgres deployment. We will first deploy a postgresql server. 

```yaml
# Deploy Postgres
- stage: deploy_postgres
  displayName: Deploy Postgres
  jobs:

  # Deploy PostgreSQL Server.
  - template: /templates/resources/deploy-postgresql-server.yaml
    parameters:
      serviceConnection: $(serviceConnection)
      env: $(env)
      deployedBy: $(deployedBy)
      azLoc: $(azLoc)
      postgreSqlServerName: $(prefix)-k8s-db
      postgreSqlServerResourceGroupName: $(prefix)-db-rg
      postgreSqlServerKeyVaultName: $(prefix)-srv-kv
      postgreSqlServerSkuName: GP_Gen5_2
      postgreSqlServerSkuTier: GeneralPurpose
      postgreSqlServerSkuCapacity: 2
      postgreSqlServerSkuFamily: Gen5
      postgreSqlServerBackupRetentionDays: 30
      postgreSqlServerGeoRedundantBackup: Disabled
      postgreSqlServerStorageMb: 51200
      postgreSqlServerStorageAutogrow: Enabled
      postgreSqlServerAdministratorLogin: adminuser
      postgreSqlServerVersion: 11
      postgreSqlServerSslEnforcement: Disabled
      postgreSqlServerMinimalTlsVersion: TLSEnforcementDisabled
      postgreSqlServerInfrastructureEncryption: Disabled
      postgreSqlServerPublicNetworkAccess: Enabled
```

Next, we will add firewall rules to the PostgreSQL Server. Please add your own ip address following the syntax in place for firewall rules below : 

```yaml
# Deploy PostgreSQL Server Firewall Rules.
  - template: /templates/resources/deploy-postgresql-server-firewall-rules.yaml
    parameters:
      env: $(env)
      serviceConnection: $(serviceConnection)
      postgreSqlServerName: $(prefix)-k8s-db
      postgreSqlServerResourceGroupName: $(prefix)-db-rg
      postgreSqlServerFirewallRules: [
      "external_access_ryani:213.47.155.102:213.47.155.102",
      "external_access_mariey:84.115.208.19:84.115.208.19",
      "devops_agent_access:20.71.230.186:20.71.230.186"
      ]
```
Next, we will deploy a database for the demo application : 

```yaml
  # Deploy PostgreSQL Server Database.
  - template: /templates/resources/deploy-postgresql-server-db.yaml
    parameters:
      serviceConnection: $(serviceConnection)
      postgreSqlServerName: $(prefix)-k8s-db
      postgreSqlServerResourceGroupName: $(prefix)-db-rg
      postgreSqlServerKeyVaultName: $(prefix)-srv-kv
      postgreSqlServerDatabaseKeyVaultName: $(prefix)-db-kv
      postgreSqlServerAdministratorLogin: adminuser
      postgreSqlServerDbName: demoappdb
```

Finally, add the deploy app stage and job to get a basic application running in the kubernetes cluster.

```yaml
# Deploy Apps
- stage: deploy_apps
  displayName: Deploy Apps
  jobs:

  # Deploy App to Kubernetes
  - template: /templates/resources/deploy-demo-app.yaml
    parameters:
      serviceConnection: $(serviceConnection)
      aksRgName: $(prefix)-aks-rg
      aksClusterName: $(prefix)-az-k8s
      namespace: demoapp
      postgreSqlServerName: $(prefix)-k8s-db
      postgreSqlServerResourceGroupName: $(prefix)-db-rg
      postgreSqlServerDbName: demoappdb
      postgreSqlServerKeyVaultName: $(prefix)-srv-kv
      postgreSqlServerDatabaseKeyVaultName: $(prefix)-db-kv
      demoAppTagName: demoapp/spring-boot-app
      azPostgresSrvNameSecret: az-postgres-server-name
      azPostgresDbNameSecret: az-postgres-db-name
      azPostgresDbUserNameSecret: az-postgres-db-username
      azPostgresDbPasswordSecret: az-postgres-db-password
      nodeResourceGroupName: $(prefix)-aks-nodes-rg
```

Looking at the logs for this last deployment, you will find the external ip of the application at the end of the app deployment job. Browse to this IP address to see the application running. 






## Installation script for the AKS VM 
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash &&
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl &&
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' &&
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - &&
sudo apt-get update &&
sudo apt-get install postgresql &&
sudo apt-get install postgresql-12 
```
