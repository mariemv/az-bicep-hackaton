# Bicep Playground Experiments

## Setting up : 

To follow along, you will need : </br>
- A tab with this document open
- Another tab open and connected to the PS Bicep Hackaton Azure Subscription

To deploy to your Subscription you will need : </br>
- EITHER The azure portal integrated cloudshell promp (set to bash) - Bicep should be ready to go, we recommand you use this today.
- OR your own host terminal connect to the subscription you are targeting 

> If you already have the latest version of Az CLI installed (v2.20.0 or later), the Bicep CLI will automatically be installed when a command that depends on it is executed, you can check with.
```
az -v
```
> You can upgrade your Azure CLI to the latest version to use bicep on linux with the following command if you are currently running version 2.11.0 or later 
```
az upgrade
``` 
> If you are currently running a version of Azure CLI prior to 2.11.0, you can update to lastest by reinstalling the client with : 
```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```
> Should you need to install bicep manually at some point, see instructions [here](https://github.com/Azure/bicep/blob/main/docs/installing.md#options-for-installing-the-bicep-cli)




## Deploy Resource Group 

[Link to the Azure Bicep Playground](https://bicepdemo.z22.web.core.windows.net/) </br>
This playground offers a preconfigured environment to experiment with bicep template and ARM.
</br>

[Microsoft Docs - Resource Group Template](https://docs.microsoft.com/en-us/azure/templates/microsoft.resources/resourcegroups?tabs=json) </br>
This is to show that Microsoft Docs now contain a tab for bicep template next to the ARM template one for most resources. 
</br>

[Bicep Resource Group Playground Template](https://aka.ms/bicepdemo#eJxtj81qwzAMx+9+Ct1y6pKWnQyDMVZ6acvY9gKupwVDGhlJKXQj7z6lTShhPRj8/7CsX1nCOwp1HBE2TF2Gt8DhiIos4FweBHC9NwtEObU1PEFRjEH42VK842uo1+3pfvCKuaEzfr2cZ7nTwDXqR6SMgyPdQSKnrIlaS8t/e37iMTdBERxPwXS5FopdikxC3/owPZVyVpHnVbVaLqrHRbUs7NNfB9AaqR+JTTYUw7CCv7KaYwjiL1UAg/Qj7EXf2Pwc1dLeTmajY004Tuhd/wczSn7S)

Copy this template into your host, to deploy replace {VALUES} with the one that are relevant to you and run : 
```
az deployment sub create --template-file "{PATH_TO_FILE}" --name "deploy-rg-$RANDOM" --location "{AZURE_LOCATION}" 
```

## Deploy Storage Account(s)

[Deploy Single Storage Account](https://aka.ms/bicepdemo#eJyVUE1LAzEUvC/sf3i36KHdtgfBBUFBsAe/cItXSdO3JTTNC+9lhUX6391PbYsXc0iGybyZSbIMikistwh3xlDlI7xq1nuMyJImocUgveK5oRvM1m/hBpSCNEmTLIN7DI5qKOw+ODy3SxNGoYoNjjZjjnqyhkmojNNhJjtVyO1iNr+ezK4ms7lqEr/SBMA3JfLjRi3pyOhoyecwhj0wVeHicjretKrAFJCjRcl7LwCpQiCOsowxyIp1WVrz4l2dQ+QKe402BkVWFjkHtaSoehq94Tr0qYMbwA7rosvP/3ieGlWC/GnNUY12rR2tT4g2Qq8dbo7LtOvwC0vr8J9DA+iObttZ36jVUPJ90dWUXfXj2395I9B+o3nz8fhWqGH68A1hKKke)

```
az deployment group create --template-file "{PATH_TO_FILE}" --name "{DEPLOYMENT_NAME}-$RANDOM" --resource-group {YOUR_RG_NAME} 
```

[Deploy Multiple Storage Accounts](https://aka.ms/bicepdemo#eJyVkE1rwzAMhu/5Fbp5O7RpexgsMFhhsB72AW3ZZZThOsowdS0jO4Uw+t9n52MLZZcZYjvSq1ePnOewZJYNUAU+EMtPBKkU1TaAlUf0mZMsj0Nu2aU8yLboDt4zACFG2y7L8hwe0BlqwOMJWRrQJdqgVbxt+h6DUcboqWaFFx3WfdiDeNaKyVMVpn1xfgFzv5jNbyezm8lsLhJSRTy4vcQRQNtL/AK+Im2arxgrY8yQkkGTLWAAe2Sq3dX1dMhEkWNyyEFjbwTga+eIg1+F4PyWZVVp9WpNU0DgGltJfFX0fquRCxArCqKNolXcuK5jZwVwwGbTti7+GF70Io980uqXIK29of34P9nLvcFyhJHW+edWaYP/qejOtKfvoG0Uip7sbZHY/KEeDLv3jWlpS8nlx9N6I9rK8+4bdwLDQQ==)

```
az deployment group create --template-file "{PATH_TO_FILE}" --name "{DEPLOYMENT_NAME}-$RANDOM" --resource-group {YOUR_RG_NAME}
```

[Limit Access to Storage Accounts](https://aka.ms/bicepdemo#eJyVUsFqGzEQvRv8D3NTc0jWySGQhUIXDM2hTcAOuQQTtNrZolqRxEhy2Rb/eyVLSreml+qwGt68N/NmtE0DHRGfwIzgvCH+DYELYYL2oPkbuuXCcuJvNdnlnAN+Un2El+UCgAE7v3bLRZVKuwkKwfTfUfgo+ZVIAAeuArbAIvmYyE0Da7TKTODwgMQVyAG1lyJG22Kttl8uCJ0JJPDM2KbADthXKcg4M/qrom7OZvh0s7q+u1zdXq6uWZpkNFSrPcTRQerzqdvsPS2mnVMTqIzgXhrdQrX2mUywHy6uaiaxLBmL5CXWWgAuWGvIu3vvrXsiPo5SPGo1teApYObEJ0HnniRSXNi98SzDqAVNNnct1QD2OG1P/dt/7IBVlkM6SDGzkU6vTP8XkFrwXuEwN5PO8U84SoX/KSpBuTT6H4b2nVBzN/1kuYsA634Gwm2x++4//1Qx/zJrnMEK7ABqOODIg/KdyLtia9QTm5k4ffZSR8usbOr55kRw+/BuKr97JHA9cBpev2y2rKiPu9+Jp/O9) 

```
az deployment group create --template-file "{PATH_TO_FILE}" --name "{DEPLOYMENT_NAME}-$RANDOM" --resource-group {YOUR_RG_NAME}
```

## Generating templates with the Bicep extension for Visual Studio Code 
- Bicep extension on VS code demo

## Decompile

If you already have working ARM templates for your resources, you can decompile them to have a starter Bicep template. Be careful however that the decompiled file needs to be adapted in most case : resource symbolicname, variables and sometimes parameter do not decompile in an adequate way. 
```
az bicep decompile --file {FILE}.json
```

## Keyvault(s)
- Using the tools previously mentionned, it is your turn to use the available resources and deploy one or several keyvault(s) in Azure from scratch - please deploy to the resource group created earlier. You can make it as simple or complex as you wish (parameters, loops, limited access,...) , depending on how comfortable you are now with the technology. We will remain available to help you in the process and will take some time for a quick feedback.

## Clean up 

```
az group delete --name {YOUR_RG_NAME}
```
