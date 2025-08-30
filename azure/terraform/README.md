# Azure Terraform Infrastructure

Este diretório contém toda a infraestrutura Azure necessária para executar a aplicação sem precisar do portal Azure.

## Arquivos Criados

### Infraestrutura de Rede
- **`vnet.tf`** - VNet, subnet pública, Network Security Group e regras de acesso
- **`vm.tf`** - VM Linux e interface de rede com IP público

### Segurança e Acesso
- **`keypair.tf`** - Geração automática de chave SSH
- **`resource_group.tf`** - Resource Group para organizar recursos

### Configuração e Dados
- **`provider.tf`** - Configuração dos providers Azure, TLS e HTTP
- **`data.tf`** - Busca dinâmica de IP público
- **`variables.tf`** - Variáveis configuráveis do projeto
- **`outputs.tf`** - Informações importantes após o deploy

### Container Registry
- **`acr.tf`** - Azure Container Registry para imagens Docker

### Estado e Configuração
- **`backend.tf`** - Configuração do backend Azure Storage para estado remoto
- **`terraform.tfvars.example`** - Exemplo de configuração das variáveis

## Como Executar

### 1. Pré-requisitos
```bash
# Instalar Terraform
# Instalar Azure CLI e fazer login
az login

# Verificar a conta ativa
az account show

# (Opcional) Definir uma subscription específica
az account set --subscription "SUBSCRIPTION_ID"
```

### 2. Configurar Variáveis (Opcional)
```bash
# Copiar o arquivo de exemplo
cp terraform.tfvars.example terraform.tfvars

# Editar conforme necessário
nano terraform.tfvars
```

### 3. Executar Terraform
```bash
# Inicializar
terraform init

# Verificar plano
terraform plan

# Aplicar mudanças
terraform apply
```

### 4. Conectar via SSH
```bash
# Após o deploy, usar o output para conectar
terraform output ssh_connection

# Ou conectar manualmente
ssh -i ~/.ssh/azure-key.pem azureuser@<IP_PUBLICO>
```

## Recursos Criados

### Rede
- **VNet**: `10.0.0.0/16`
- **Subnet Pública**: `10.0.1.0/24`
- **Network Security Group** com regras de acesso
- **IP Público** estático

### Computação
- **VM Linux**: Standard_B1s com Ubuntu 22.04 LTS
- **Network Security Group**: Acesso SSH (seu IP), HTTP (80), HTTPS (443)
- **Key Pair**: Chave SSH gerada automaticamente

### Segurança
- **Network Security Group**: Regras de entrada configuradas
- **Key Pair**: Chave SSH gerada automaticamente
- **Autenticação**: Apenas por chave SSH (senha desabilitada)

### Container Registry
- **Azure Container Registry**: Para imagens Docker

## Outputs Disponíveis

Após o deploy, você terá acesso a:
- **IP Público** da VM
- **IP Privado** da VM
- **IDs** de todos os recursos criados
- **URL** do Container Registry
- **Credenciais** do Container Registry
- **Comando SSH** para conexão

## Para Destruir a Infraestrutura

```bash
terraform destroy
```

**ATENÇÃO**: Isso removerá TODOS os recursos criados!

## Troubleshooting

### Erro de Autenticação
```bash
# Verificar se está logado no Azure
az account show

# Fazer login novamente se necessário
az login
```

### Erro de Permissões
```bash
# Verificar permissões da conta
az role assignment list --assignee $(az account show --query user.name -o tsv)

# Verificar se tem permissões de Contributor ou Owner na subscription
```

### Erro de Quotas
```bash
# Verificar quotas disponíveis
az vm list-usage --location "East US"

# Verificar se o tamanho da VM está disponível na região
az vm list-sizes --location "East US"
```

### Erro de Backend Azure Storage
```bash
# Verificar se o storage account existe
az storage account show --name SEU_STORAGE_ACCOUNT_AQUI --resource-group SEU_RG_TERRAFORM_AQUI
```

## Custos Estimados

### Recursos Principais (East US)
- **VM Standard_B1s**: ~$7.30/mês
- **Disco Premium SSD 30GB**: ~$4.81/mês
- **IP Público Estático**: ~$3.65/mês
- **ACR Basic**: ~$5.00/mês
- **Total Estimado**: ~$20.76/mês

**Nota**: Preços podem variar conforme região e promoções Azure.

## Recursos Adicionais

- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Virtual Networks](https://docs.microsoft.com/en-us/azure/virtual-network/)
- [Azure Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/)
- [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/)

---

**Agora tudo pode ser executado via Terraform sem precisar do portal Azure!**
