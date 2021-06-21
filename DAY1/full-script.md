# Part 1 - Bicep SandBox

## Presentations etc 

Hello eveyone and welcome to the first day of this Azure Bicep hackaton ! My name is Marie Yerna, I work with Innofactor Norway and I mostly focus on Kubernetes in Azure and Infrastructure as Code, I am very happy to be here with you today with my colleague Ryan, Ryan maybe you can say a few words about yourself ? (LET RYAN SPEAK). Thank you Ryan ! I know this will feel a little like we are back to school, but in an attempt to make this hackaton as interactive as possible despite the current circumstances, we thought it would be nice to know a little more about you too so either in turn or someone introducing his team if we have several teams, can you tell us a few words about who you are and what your experience with Infrastructre as Code is : are you using or have you already use ARM, Terraform or Rancher? Are you working with Azure DevOps CI/CD Pipelines or something else? Have you ever used bicep ? Anything relevant to today's topic in IaC really. (EITHER ASK KEN ROBERT OR VELTE TO HELP - LET PEOPLE TALK). Thank you very much everyone ! I see we have a rather diverse team but i am convinced that all of you can bring something home today. 

## Intro

So for those of you who are familiar with ARM templates, you surely know that they are very verbose and complicated to write and read - let alone edit. It can get very frustrating to try to use them for something more complex than a basic resource deployment. ARM templates sure are efficient, but they are long and tedious and this is where Bicep comes into play. </br>

Good news is : almost everything that can be done with ARM can now be done with Bicep. There still are some limitations, we will of course come back to this later but for now as the difference is rather striking, let me show something : i will share my screen with you for a second (SHARE SCREEN). Can you all see my screen ? So, this "playground" shows us what one and the same deployment template looks like in both ARM syntax on the right, and bicep on the left. We can browse through some examples (hello world, resource locks, click on others at random). You will notice that Bicep is much more straightforward and reduces the amount of lines of code by about half of what ARM templates offer. I think that these couple of exemple easily replace a lenghty introduction, don't they Ryan ? (LET RYAN ADD STUFF)  </br>

## Today's planning : 

So what are we going to do today ? Today's session will be split in two main parts : first we are going to use the bicep sandbox I just showed you to get started with Azure Bicep and get used to its syntax, we will deploy a couple of resources in Azure using the templates we will generate here in this sandbox - you'll get a link in a second- and of course we will answer all of your questions as we go. For those of you familiar with Bicep or even ARM already this part might be a bit redundant but please bear with us for a moment as things will quickly get more complicated ! At the end of this first part, we will ask you to deploy a resource from scratch using the tools we will provide you in a minute. </br> 

For the second part of today's session, we will get started on using Azure Bicep in a CI/CD DevOps pipeline and show you the structure we recommend you to use when working on your Bicep projects. We will deploy Azure Resources with that pipeline (Keyvaults, VNet, a VM to interact with the cluster, storage accounts and more...) and depending on how this afternoon goes with might start with AKS - else AKS integration with Bicep will be our main topic on Friday. </br> 

Let's take a couple of minutes to get ready to go: I will send you the link to a github document called "bicep playground" that contains a couple of links here in the chat, please open it and keep another tab open with the Azure Portal you will work with and either a cloudshell prompt set to bash open or your own terminal connected to the subscription you want to target. I will use a VM connected to the subscription as it will be easier to read on screen. Cloudshell is always running the lastest version of Azure CLI and bicep should be ready to go, however if you are using another terminal you might need to update you CLI before we get started. The commands to check your installations are also in the doc. </br> 

While all those who want to follow up with us are getting ready, do you have any first impressions you want to share or questions about the planning ? Ryan do you want to add something ? </br> 

## Deploy a resource group 

Ok now that we are hopefully all set, let's start deploying ! I suggest you to try and follow along and let us know if you encounter any issue or if you have any remark. We can start with the basics and create a simple resource group. I know already that this is not in the playground 101 templates list here, but it gives me a chance to show you something: if you go to the Microsoft official template reference documentation (OPEN MICROSOFT LINK AND SHOW THE TAB) , next to the ARM template tab, you can now have access to the corresponding bicep template for this resource. 

We can copy the template into our sandbox and see how we can tune it. (COPY TEMPLATE). It looks like it does not compile and we are indeed missing a thing or two. First, we need to add the targetScope we traditionnaly had in ARM $schema (TYPE targetScope = 'subscription'). This is better. Keep in mind that unless specified otherwise, Bicep will always assume that you are deploying at the resource group scope - which will obviously not work here. We can also take a moment to notice that all string values must be enclosed between single quotes, double quotes will not work here (SHOW THAT IT FAILS). </br>

So, In order to declare a resource to deploy in Azure, we first need to declate the object type of "resource" (HIGHLIGHT) and then provide a symbolic name for this resource (HIGHLIGHT) that we will use if we need to reference it later. Then comes the resource provider "Microsoft.Resource" (HIGHLIGHT) followed by the the provider type and api version (HIGHLIGHT). All of this has to be enclosed between single quotes as well. The resource is then defined with with different properties between curly braces. 

</br> 

Here I could hard-code my values like so (HARD CODE NAME AND LOC) but similar to arm, we can edit this template to use parameters like so (ADD PARAMETERS). We will also comment the template for readability : comments work in a way similar to other languages, with two forward slashes for single line. I will keep this template for myself and now invite you to click on the link here on github, add your own parameters and deploy it using the command below to test your set up and have a resource group in place for future deployment.


## Storage Account(s)

Now that we have a resource group in place (SHOW RESOURCE GROUP), we can start deploying resources to this resource group. You can click on the link provided on github (SHOW LINK) for a single storage and add the name parameter as you wish. This time we don't need to specifiy a target scope as the default to resource group will work for us. When chosing your parameters, please bear in mind that storage account names can only have upper case, lowercase and numbers - adding other characters like a dash for exemple will make your deployment fail. In most real environments, Storage Accounts are named using a randomly generated guid but I suppose your initals and a random rumber should work unless you are very unlucky and someone used that already.  

This time the deployment group created is targeted at the resource group we created previously as you can see if the command I provided on github (SHOW LINK). Other deployment options include management group or tenant but unless requested I don't think we will go that route today. (CAT STORAGE, DEPLOY)

### Deploy multiple storage accounts 

Now that we have a storage account in place, what if we want to add two mores using the same template ? We can edit our template to loop through an array of names and create a storage for each like so (OPEN SINGLE TEMPLATE, EDIT TO LOOP). If you did not have time to update your template as I was updating mine, I again provided a blank template for you to have a look at and fill in with your custom values. Use the deployment group create command like before. (DEPLOY, WAIT A BIT, REFRESH TO SHOW) 

Now depending on who you are working with and what their requirements are, you can also loop in yaml instead of biceps, we will show you this alternative today as well. 

### Configure access to storage accounts 

Using the same template, we can also configure access to storage account by adding VNet rules or IP rules after the resources are created. Just to show you that it works in a similar way to ARM, i am going to restrict access to my 3 storages and allow access from my IP address only. [RUN SECURE STORAGE]. I can access them, my IP is listed, now Ryan can you go on Azure and see if you can access this from your address ? [NOPE, hopefully, but we have to test it]. 

## Decompile ARM template

Now what if you have a library of functioning ARM Templates that you want to turn into Bicep templates ? This must not necessarily be a chore : a way to ease to process is to decompile your existing json files. For this you can either use this playground tool, or run the following command against the target file : 

```
az bicep decompile --file {FILE}.json
```

However, the Bicep file might need some revisions to be optimal - but it still gives us a good place to start instead of coding everything from scratch again.

## Virtual Machine : 

Maybe here we can go through the VS code integration and Ryan could show how you can do this ? It would fit well after the first option of decompiling to create bicep templates easily 

## Part 1 Q&R
- **ASK RYAN** we never use modules, why ? 
- Maybe mention the known limitations here 
- Maybe Ryan can talk about some Bicep refactoring he did, why and how it turned out 
- 

# Part 2 - CI/CD Pipeline 

# Intro 

Now using scattered templates is fun but we have a lot more in store for you - dont close out of VS Code just yet. We want to take a look now at how we can use biceps for infrastructure as code in an Azure Devops pipeline for continuous development and integration. 

## Set up 

- Create new repo in devops
- Clone/import the starter repo 
- Using the agent pool we set up, run a basic job to test the connection

## Bicep 

- Basic structure used 
- Why Bicep can be useful (Ryan reduced code by X for a client)

## Resource Groups 

- How we are creating multiple Resource Groups (for/loops) in CI/CD Pipeline
- How we can do the same thing natively in Bicep. We won't be doing much of this because we are using loops in CI/CD, but we want them to know it's there.
- Why do we have a azure cli Resource Group Check in bash in our tasks:  because without checking, the Resource Groups will take up to 45 seconds EACH to deploy as ARM will natively check against what we are trying to deploy using Bicep. If you have a ton of Resources to Deploy that don't change a lot, this will consume a stupid amount of time.
- The following resource groups are created : {ADD RGs}

## Keyvault 

- Firewall rules strings/object 

- Purging kv : if you are redeploying environments a lot, say as in a Development or Test Subscription, you want to automate the creation of finding deleted key vaults and purging them. However, if you are working in Stage and Production, you probably DO NOT want to automatically purge key vaults in case someone accidentally deleted a key vault that should have been left in place. + eventually add script to purge kv via automation to repo

## Storage Accounts

- **ASK RYAN** are we actually going to use them ? Maybe add locks to the template ? 
