name_prefix                              = "Atum"
domain                                   = "babosbird.com"
subdomain                                = "sally"
kubernetes_version                       = "1.28.3"  
ssh_public_key                           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDRHrICSTesKCNyH6vN4K3YwhDUO89cqnEDz2bcZ0sLn9mU6hwyXHna5vME8Y/A8Jbj4XiMyePbAJsX8R/Yyq5pZSiqYpPqSdRGOGqKxQPMBE8WFN1RZmrbrb0ElVQtdWWhlCis4PyMn76fbH6Q8zf/cPzzm9GTimVw62BGhdqdHHru7Sy3I+WRGVA3Z2xHqpda+4nd9LYQW3zkHP98TbIM5OW8kVhRUtmg3c0tOViU6CsGP9w4FU8TU7wLWoeig69kv6UgikwnJYXkItiLecCbVqOeGwbHZQmawcqEY674E3jgJkJ5nQVblCODR0ODNCtrCDVyT6pX0Hdt1ivIpkf"
vm_enabled                               = true
location                                 = "eastus"
admin_group_object_ids                   = ["4e4d0501-e693-4f3e-965b-5bec6c410c03"]
web_app_routing_enabled                  = true
dns_zone_name                            = "babosbird.com"
dns_zone_resource_group_name             = "DnsResourceGroup"
namespace                                = "chainlit"
service_account_name                     = "chainlit-sa"
#deployment_script_primary_script_uri     = "https://paolosalvatori.blob.core.windows.net/scripts/install-packages-for-chainlit-demo.sh"
grafana_admin_user_object_id             = "0c5267b2-01f3-4a59-970e-0d9218d5412e"
vnet_integration_enabled                 = true
openai_deployments      = [
  {
    name = "gpt-35-turbo-16k"
    model = {
      name = "gpt-35-turbo-16k"
      version = "0613"
    }
  },
  {
    name = "text-embedding-ada-002"
    model = {
      name = "text-embedding-ada-002"
      version = "2"
    }
  }
]