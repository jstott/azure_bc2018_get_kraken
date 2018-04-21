This requires the Azure CLI version 2.0.4 or later. Run `az --version` to find the version. If you need to upgrade, see [Install Azure CLI 2.0](/cli/azure/install-azure-cli). You can also use [Cloud Shell](/azure/cloud-shell/quickstart) from your browser.

[Docs Azure CLI - Install ](https://docs.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest)

CMD / PowerShell: [MSI Installer](https://aka.ms/installazurecliwindows) 

Bash: `sudo apt-get update && sudo apt-get install azure-cli`

Docker: `docker run -it microsoft/azure-cli`   
Docker w/ssh keys: 
Docker: `docker run -it -v ${HOME}:/root microsoft/azure-cli`


## Basic Azure Resource Manager commands in Azure CLI
For more detailed help with specific command line switches and options, you can use the online command help and options by typing `az <command> <subcommand> --help`.

### Account Information

| Task | Azure CLI commands |
| --- | --- |
| Show Account | `az account show` |
| List locations | `az account list-locations`|
| Clear Account | `az account clear` |
| Create Service Principal | `az ad sp create-for-rbac -n "<name-of-principal>"` |
| Add Role SP | `az role assignment create --assignee <your Service Principal ID> --role <YourCustomRole> ` |  
| Delete Role SP | `az role assignment delete --assignee <your Service Principal ID> --role Contributor` |
| List Role SP | `az role assignment list --assignee <your Service Principal ID>` |
| More Details | ** requires owner permission ** |
| List AD SP's | `az ad sp list` |
| SP Details | `az ad sp show --id <service Principal id>` |
| List Roles | `az role definition list -o json | jq '.[] | {"roleName":.properties.roleName, "description":.properties.description}'  ` |

### List VM Sizes - Availability
| Task | Azure CLI commands |
| --- | --- |
| List VM Sizes | `az vm list-sizes --location eastus2` |
| List VM Sizes | `az vm list-sizes --location eastus2 --query "[?ends_with(name, '_v3')]" -o table ` |
| Get usage of VM resources | `az vm list-usage --location eastus -o table` |
| Get all available VM sizes | `az vm list-sizes --location eastus -o table` |
| List SKU's | `az vm list-skus --location eastus2 -o table` |


### Create
| Task | Azure CLI commands |
| --- | --- |
| Create a resource group | `az group create --name myResourceGroup --location eastus` |
| Create a Linux VM | `az vm create --resource-group myResourceGroup --name myVM --image ubuntults` |
| Create a Windows VM | `az vm create --resource-group myResourceGroup --name myVM --image win2016datacenter` |

### Manage VM state
| Task | Azure CLI commands |
| --- | --- |
| Start a VM | `az vm start --resource-group myResourceGroup --name myVM` |
| Stop a VM | `az vm stop --resource-group myResourceGroup --name myVM` |
| Deallocate a VM | `az vm deallocate --resource-group myResourceGroup --name myVM` |
| Restart a VM | `az vm restart --resource-group myResourceGroup --name myVM` |
| Redeploy a VM | `az vm redeploy --resource-group myResourceGroup --name myVM` |
| Delete a VM | `az vm delete --resource-group myResourceGroup --name myVM` |

### Get VM info
| Task | Azure CLI commands |
| --- | --- |
| List VMs | `az vm list -o table` |
| List VM IPs (by RG) | `az vm list-ip-addresses --ids $(az vm list -g MyResourceGroup --query "[].id" -o tsv)`|
| Get information about a VM | `az vm show --resource-group myResourceGroup --name myVM` |


## Disks and images
| Task | Azure CLI commands |
| ---            | ---      |
| Show VM Images | `az vm image list --publisher Canonical --offer UbuntuServer --all --output table -l eastus2  --sku 16.04-LTS`   |
| Add a data disk to a VM | `az vm disk attach --resource-group myResourceGroup --vm-name myVM --disk myDataDisk --size-gb 128 --new ` |
| Remove a data disk from a VM | `az vm disk detach --resource-group myResourceGroup --vm-name myVM --disk myDataDisk` |
| Resize a disk | `az disk update --resource-group myResourceGroup --name myDataDisk --size-gb 256` |
| Snapshot a disk | `az snapshot create --resource-group myResourceGroup --name mySnapshot --source myDataDisk` |
| Create image of a VM | `az image create --resource-group myResourceGroup --source myVM --name myImage` |
| Create VM from image | `az vm create --resource-group myResourceGroup --name myNewVM --image myImage` |
