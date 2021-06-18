# Bicep Playground Experiments

TODO : Make this public as we will refer to this document during the walkthough 

- Use cloudshell (bash) - Bicep should be installed already, run bicep --version 
- OR your own host terminal connect to the subscription you are targeting 

> If you already have the latest version of Az CLI installed (v2.20.0 or later), the Bicep CLI will automatically be installed when a command that depends on it is executed.
```
az -v
```
> To install manually, see instructions [here](https://github.com/Azure/bicep/blob/main/docs/installing.md#options-for-installing-the-bicep-cli)




## Deploy Resource Group 

[Microsoft Docs - Resource Group Template](https://docs.microsoft.com/en-us/azure/templates/microsoft.resources/resourcegroups?tabs=json) </br>
[Bicep Resource Group Playground Template](https://aka.ms/bicepdemo#eJxVj8FOwzAMhu95Ct9yytJOnCohcUDiMhCCvUCITIhom8h2Qdu0d5+7UgQHS/5/f5b9ew/3WPtyGHAUeA4UBhQkBlPnHig9qdMCC+UxwS3Y4evgPkL8dJRca3+wcNyV+Af6RhacqFS0xngP+0AJBV6jOmDkqhahME9vHClXyWVc8BfkMlFEeKAyVdjjUPsguknrYG0WwD7mSIXLu2zWVfb/EL7bNtvWNTeuaa0ePRmAUZN1a0LVfYlh/qFb4qgjIXF3Zc9adc5DkvHXO18A4epqVg==)


```
az deployment sub create \
--template-file "{PATH_TO_FILE}" \
--name "{DEPLOYMENT_NAME}-$RANDOM" \
--location "AZURE_LOCATION" 
```

## Deploy Storage Account(s)

[Deploy Single Storage Account](https://aka.ms/bicepdemo#eJyVUMtqAzEMvO9X6Ob2kGySQ6ELhQYKzaEPSEKvxfFqg4ljGckbWEr+vd5Xm0IvMdiWNaPRWHkOS2bdAFUgkVjvEbQxVPsIXh9RsqBZH0fsLaVSzNbv4QGUgizLc3jC4KgBwROydmBL9NGaFG0GxWWvKBmjUM0GR70BWA9pAfVqDZNQFadDcf6XKo+L2fx+MrubzOYqefjKoDNaXFpMOUdGR0u+gLHnM1Mdbm6nI5JIgSkgR4tSdEIAUodAHGUVY5At66qy5t27poDINXaUNB4U2VrkAtSKouqy6A03oe/YSwEcsNl0rYt//qUGkiCfrPl10K6do93lu5XXO4flhY12nX+iyjq8pqK/27PdB+sTUQ3OPhatNznUo2A/3wRrX2ouP1/WG9VVnr8BNxexow==)

```
az deployment group create \
--template-file "{PATH_TO_FILE}" \
--name "{DEPLOYMENT_NAME}-$RANDOM" \
--resource-group {NAME_OF_RG_ABOVE} 
```

[Deploy Multiple Storage Accounts](https://aka.ms/bicepdemo#eJyVkE1rwzAMhu/5Fbp5O7RpexgsMFhhsB72AW3ZZZThOsowdS0jO4Uw+t9n52MLZZcZYjvSq1ePnOewZJYNUAU+EMtPBKkU1TaAlUf0mZMsj0Nu2aU8yLboDt4zACFG2y7L8hwe0BlqwOMJWRrQJdqgVbxt+h6DUcboqWaFFx3WfdiDeNaKyVMVpn1xfgFzv5jNbyezm8lsLhJSRTy4vcQRQNtL/AK+Im2arxgrY8yQkkGTLWAAe2Sq3dX1dMhEkWNyyEFjbwTga+eIg1+F4PyWZVVp9WpNU0DgGltJfFX0fquRCxArCqKNolXcuK5jZwVwwGbTti7+GF70Io980uqXIK29of34P9nLvcFyhJHW+edWaYP/qejOtKfvoG0Uip7sbZHY/KEeDLv3jWlpS8nlx9N6I9rK8+4bdwLDQQ==)

```
az deployment group create \
--template-file "{PATH_TO_FILE}" \
--name "{DEPLOYMENT_NAME}-$RANDOM" \
--resource-group {NAME_OF_RG_ABOVE} 
```

[Limit Access to Storage Accounts](TODO)

```
az deployment group create \
--template-file "{PATH_TO_FILE}" \
--name "{DEPLOYMENT_NAME}-$RANDOM" \
--resource-group {NAME_OF_RG_ABOVE} 
```

## Deploy Virtual Machine 
- Walkthough outside of the Playground with VS code extension 

## Decompile

```
az bicep decompile --file {FILE}.json
```
