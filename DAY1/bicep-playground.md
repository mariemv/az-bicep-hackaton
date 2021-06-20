# Bicep Playground Experiments

TODO : Make this public as we will refer to this document during the walkthough 
## Setting up : 

To follow along, you will need : </br>
- A tab with this document open
- Another with your Azure Subscription 

To deploy to you Subscription you will need : </br>
- The azure portal integrsted cloudshell promp (set to bash) - Bicep should be ready to go
- OR your own host terminal connect to the subscription you are targeting 

> If you already have the latest version of Az CLI installed (v2.20.0 or later), the Bicep CLI will automatically be installed when a command that depends on it is executed.
```
az -v
```
> You can upgrade your Azure CLI to the latest version to use bicep on linux. 
> To install bicep manually, see instructions [here](https://github.com/Azure/bicep/blob/main/docs/installing.md#options-for-installing-the-bicep-cli)




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
az deployment group create --template-file "{PATH_TO_FILE}" --name "{DEPLOYMENT_NAME}-$RANDOM" --resource-group {NAME_OF_RG_ABOVE} 
```

[Deploy Multiple Storage Accounts](https://aka.ms/bicepdemo#eJyVkE1rwzAMhu/5Fbp5O7RpexgsMFhhsB72AW3ZZZThOsowdS0jO4Uw+t9n52MLZZcZYjvSq1ePnOewZJYNUAU+EMtPBKkU1TaAlUf0mZMsj0Nu2aU8yLboDt4zACFG2y7L8hwe0BlqwOMJWRrQJdqgVbxt+h6DUcboqWaFFx3WfdiDeNaKyVMVpn1xfgFzv5jNbyezm8lsLhJSRTy4vcQRQNtL/AK+Im2arxgrY8yQkkGTLWAAe2Sq3dX1dMhEkWNyyEFjbwTga+eIg1+F4PyWZVVp9WpNU0DgGltJfFX0fquRCxArCqKNolXcuK5jZwVwwGbTti7+GF70Io980uqXIK29of34P9nLvcFyhJHW+edWaYP/qejOtKfvoG0Uip7sbZHY/KEeDLv3jWlpS8nlx9N6I9rK8+4bdwLDQQ==)

```
az deployment group create --template-file "{PATH_TO_FILE}" --name "{DEPLOYMENT_NAME}-$RANDOM" --resource-group {NAME_OF_RG_ABOVE} 
```

[Limit Access to Storage Accounts](https://aka.ms/bicepdemo#eJyVUsFq3DAQvS/sP8xN7SH2eklLYijUEGgOSQq7oZewBFkeF3UVSYykLW7Zf6+8llJn6aU6WMOb9zRPTy5LaIj4AKYH5w3x7whcCBO0B81f0C0XlhN/yc1m6jngJ9UneFouABiw8223XGSptJugEEz7A4WPkt8jCeDAVcAa2NVlUVUfivXqqqiuo/IY26O4LOEGrTIDODwgcQWyQ+2liNU2Wc12lgtCZwIJPDO6SbADdi8FGWd6XyR1eXanz+tVdX2x+nixqth4s95QPu0hRgFSn6dQT3cZg6rn1BFURnAvja4hW/tCJth374vcGVmWjEXyEvNZAC5Ya8i7W++teyTe91J81WqowVPAiROfCJ17lEgxwFvj2QSjFjTYaWo6DWCPw/Y0v/5HBiyzHNJBipmNcbXKtG+AcQRvFXZzM+M6/i17qfA/RalIm0b/09C+EWruph0sdxFgza9AuE12X/1PP1nsP80GT2AGdgC57LDnQflGTFmxG9QDm5k4ffZSR8ssJfVtfSK4fXg1Nb17JHDdceqe7zZbltTH3R+6SPaF) **ASK RYAN IF THIS IS WHAT HE MEANT**

```
az deployment group create --template-file "{PATH_TO_FILE}" --name "{DEPLOYMENT_NAME}-$RANDOM" --resource-group {NAME_OF_RG_ABOVE} 
```

## Deploy Virtual Machine 
Walkthough outside of the Playground with VS code extension -  


## Decompile

```
az bicep decompile --file {FILE}.json
```
