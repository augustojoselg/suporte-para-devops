# Suporte para DevOps e SREs

## Sobre o Projeto

Este repositório oferece um conjunto abrangente de recursos e templates para profissionais de **DevOps** e **Site Reliability Engineering (SRE)** que trabalham com infraestrutura como código (IaC) e automação de nuvem.

## O que Oferecemos

### **Multi-Cloud Support Completo**
- **AWS** - Infraestrutura completa com EC2, VPC, ECR, IAM e Security Groups
- **Azure** - VM, VNet, ACR, Network Security Groups e Resource Groups
- **Google Cloud Platform (GCP)** - Compute Engine, VPC, Artifact Registry e Service Accounts
- **Oracle Cloud Infrastructure (OCI)** - Compute Instance, VCN, OCIR e Compartments (Always Free elegível)

### **Ferramentas e Tecnologias**
- **Terraform** - Infraestrutura como código (IaC) para todas as nuvens
- **Container Registries** - ECR (AWS), ACR (Azure), Artifact Registry (GCP), OCIR (OCI)
- **Backend Configurations** - Estado remoto para todas as plataformas
- **Provider Configurations** - Configurações otimizadas para cada nuvem
- **Templates Reutilizáveis** - Código modular e padronizado
- **Segurança Automatizada** - Firewall, SSH keys e IAM/RBAC
- **Documentação Completa** - READMEs detalhados para cada nuvem

## Recursos Disponíveis

### **AWS Terraform - Infraestrutura Completa**

#### **Infraestrutura de Rede**
- **`vpc.tf`** - VPC com CIDR 10.0.0.0/16, subnet pública 10.0.1.0/24, internet gateway e route table configurada

#### **Computação e Aplicação**
- **`ec2.tf`** - Instância EC2 t3.micro com Amazon Linux 2, security group configurado para SSH, HTTP e HTTPS
- **`ecr.tf`** - Repositório ECR `app_prod` para armazenamento de imagens Docker

#### **Segurança e Acesso**
- **`iam.tf`** - Role IAM `ECR_EC2_APP` com políticas para acesso ao ECR, instance profile configurado
- **`keypair.tf`** - Geração automática de chave SSH RSA 4096 bits, upload automático para AWS

#### **Configuração e Dados**
- **`provider.tf`** - Providers AWS, TLS (para chaves SSH) e HTTP (para detecção de IP)
- **`data.tf`** - Busca automática da AMI mais recente do Amazon Linux 2 e detecção do IP público atual
- **`variables.tf`** - Variáveis configuráveis para região, ambiente, tipo de instância, etc.
- **`outputs.tf`** - Outputs para IP público, DNS, IDs de recursos, comando SSH e informações IAM

#### **Estado e Configuração**
- **`backend.tf`** - Backend S3 configurado para estado remoto com criptografia
- **`terraform.tfvars.example`** - Template de variáveis com valores padrão

#### **Documentação e Scripts**
- **`README.md`** - Documentação completa da infraestrutura AWS
- **`INSTRUCTIONS_IAM.md`** - Instruções detalhadas para configuração de permissões IAM
- **`TerraformMinimalPolicy.json`** - Política IAM completa com todas as permissões necessárias
- **`apply_iam_policy.sh`** - Script bash para aplicar política IAM automaticamente

#### **Recursos Criados Automaticamente**
- **VPC**: Rede isolada com internet gateway
- **Subnet Pública**: Acesso direto à internet
- **Security Group**: Regras para SSH (seu IP), HTTP (80), HTTPS (443)
- **EC2**: Instância com acesso ao ECR via IAM role
- **ECR**: Repositório para imagens de produção
- **IAM**: Role, política e instance profile para EC2 acessar ECR

### **Azure Terraform - Infraestrutura Completa**

#### **Infraestrutura de Rede**
- **`vnet.tf`** - Virtual Network, subnet pública, Network Security Group com regras para SSH, HTTP e HTTPS
- **`resource_group.tf`** - Resource Group para organizar todos os recursos Azure

#### **Computação e Aplicação**
- **`vm.tf`** - VM Linux Ubuntu 22.04 LTS, IP público estático, interface de rede configurada
- **`acr.tf`** - Azure Container Registry para armazenamento de imagens Docker

#### **Segurança e Acesso**
- **`keypair.tf`** - Geração automática de chave SSH RSA 4096 bits
- **Network Security Group** - Regras de firewall para SSH (seu IP), HTTP e HTTPS

#### **Configuração e Dados**
- **`provider.tf`** - Provider AzureRM, TLS e HTTP configurados
- **`data.tf`** - Detecção automática do IP público atual
- **`variables.tf`** - Variáveis para região, ambiente, tamanho da VM, etc.
- **`outputs.tf`** - IPs público/privado, IDs de recursos, credenciais ACR, comando SSH

### **GCP Terraform - Infraestrutura Completa**

#### **Infraestrutura de Rede**
- **`vpc.tf`** - VPC custom, subnet, firewall rules para SSH, HTTP e HTTPS
- **`iam.tf`** - Service Account com permissões para Artifact Registry

#### **Computação e Aplicação**
- **`compute.tf`** - Compute Engine Ubuntu 22.04, IP externo estático, startup script com Docker
- **`artifact_registry.tf`** - Artifact Registry para imagens Docker, habilitação automática de APIs

#### **Segurança e Acesso**
- **`keypair.tf`** - Geração automática de chave SSH RSA 4096 bits
- **Firewall Rules** - Controladas por tags de rede para SSH, HTTP e HTTPS

#### **Configuração e Dados**
- **`provider.tf`** - Provider Google, TLS e HTTP configurados
- **`data.tf`** - Busca automática de imagem Ubuntu e detecção de IP
- **`variables.tf`** - Variáveis para projeto, região, zona, tipo de máquina, etc.
- **`outputs.tf`** - IPs externo/interno, URL do Artifact Registry, comandos SSH

### **OCI Terraform - Infraestrutura Completa**

#### **Infraestrutura de Rede**
- **`vcn.tf`** - Virtual Cloud Network, subnet pública, internet gateway, route table e security lists
- **`compartment.tf`** - Compartment para organizar recursos OCI

#### **Computação e Aplicação**
- **`compute.tf`** - Compute Instance Oracle Linux 8, shape Always Free elegível
- **`cloud-init.yaml`** - Script de inicialização com Docker, Docker Compose e OCI CLI
- **`ocir.tf`** - Configuração para Oracle Cloud Infrastructure Registry

#### **Segurança e Acesso**
- **`keypair.tf`** - Geração automática de chave SSH RSA 4096 bits
- **Security Lists** - Regras para SSH (seu IP), HTTP e HTTPS

#### **Configuração e Dados**
- **`provider.tf`** - Provider OCI, TLS e HTTP configurados
- **`data.tf`** - Busca automática de availability domains, imagens e IP
- **`variables.tf`** - Variáveis para tenancy, usuário, região, shape, etc.
- **`outputs.tf`** - IPs público/privado, namespace OCIR, comandos SSH e gcloud

## Casos de Uso

### **Para DevOps Engineers:**
- **Automação de Infraestrutura** - Deploy automatizado de recursos em múltiplas nuvens
- **Padronização** - Templates consistentes para diferentes ambientes
- **Versionamento** - Controle de versão da infraestrutura
- **CI/CD Integration** - Integração com pipelines de entrega contínua
- **Container Management** - ECR configurado para imagens Docker
- **Security Automation** - IAM roles e policies criados automaticamente
- **Network Automation** - VPC, subnets e security groups via código

### **Para SREs:**
- **Reliability** - Infraestrutura reproduzível e consistente
- **Monitoring Setup** - Base para implementação de monitoramento
- **Disaster Recovery** - Recuperação rápida de infraestrutura
- **Capacity Planning** - Gerenciamento de recursos escalável
- **Security Compliance** - Políticas IAM padronizadas e auditáveis
- **Network Security** - Security groups configurados automaticamente
- **Access Management** - Chaves SSH geradas e gerenciadas via Terraform

## Como Usar

### **Pré-requisitos**
- Terraform instalado (versão >= 1.0)
- Credenciais configuradas para os provedores de nuvem desejados
- Acesso às APIs dos provedores de nuvem

### **Quick Start**

#### **AWS - Infraestrutura Completa**
```bash
# Navegar para diretório AWS
cd aws/terraform

# Configurar permissões IAM (primeira vez)
chmod +x apply_iam_policy.sh
./apply_iam_policy.sh

# Inicializar Terraform
terraform init

# Verificar plano
terraform plan

# Aplicar infraestrutura
terraform apply

# Conectar via SSH (após deploy)
terraform output ssh_connection
```

#### **Azure - Infraestrutura Completa**
```bash
# Navegar para diretório Azure
cd azure/terraform

# Configurar credenciais (fazer login no Azure)
az login

# Copiar e editar variáveis (opcional)
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars

# Inicializar Terraform
terraform init

# Verificar plano
terraform plan

# Aplicar infraestrutura
terraform apply

# Conectar via SSH (após deploy)
terraform output ssh_connection
```

#### **GCP - Infraestrutura Completa**
```bash
# Navegar para diretório GCP
cd gcp/terraform

# Configurar credenciais (fazer login no GCP)
gcloud auth login
gcloud config set project SEU_PROJECT_ID

# Habilitar APIs necessárias
gcloud services enable compute.googleapis.com
gcloud services enable artifactregistry.googleapis.com

# Copiar e editar variáveis (OBRIGATÓRIO)
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars  # Definir gcp_project_id

# Inicializar Terraform
terraform init

# Verificar plano
terraform plan

# Aplicar infraestrutura
terraform apply

# Conectar via SSH (após deploy)
terraform output gcloud_ssh_connection
```

#### **OCI - Infraestrutura Completa**
```bash
# Navegar para diretório OCI
cd oci/terraform

# Configurar credenciais (configurar OCI CLI)
oci setup config

# Copiar e editar variáveis (OBRIGATÓRIO)
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars  # Definir OCIDs necessários

# Inicializar Terraform
terraform init

# Verificar plano
terraform plan

# Aplicar infraestrutura
terraform apply

# Conectar via SSH (após deploy)
terraform output ssh_connection
```

## Personalização

### **AWS - Configurações Avançadas**
- **Variáveis**: Edite `terraform.tfvars` para personalizar região, tipo de instância, CIDR da VPC
- **Security Groups**: Modifique regras de firewall em `ec2.tf`
- **IAM Policies**: Ajuste permissões do role em `iam.tf`
- **Network**: Configure VPC e subnets em `vpc.tf`
- **EC2**: Personalize tipo de instância, AMI e configurações em `ec2.tf`

### **Azure - Configurações Avançadas**
- **Variáveis**: Edite `terraform.tfvars` para personalizar região, tamanho da VM, CIDR da VNet
- **Network Security Group**: Modifique regras de firewall em `vnet.tf`
- **VM Configuration**: Ajuste tamanho, imagem e configurações em `vm.tf`
- **ACR**: Configure o Container Registry em `acr.tf`
- **Resource Group**: Organize recursos em `resource_group.tf`

### **GCP - Configurações Avançadas**
- **Variáveis**: Edite `terraform.tfvars` para personalizar projeto, região, zona, tipo de máquina
- **Firewall Rules**: Modifique regras de rede em `vpc.tf`
- **Compute Engine**: Ajuste machine type, imagem e startup script em `compute.tf`
- **Service Account**: Configure permissões em `iam.tf`
- **Artifact Registry**: Modifique configurações do registry em `artifact_registry.tf`

### **OCI - Configurações Avançadas**
- **Variáveis**: Edite `terraform.tfvars` para personalizar tenancy, região, shape, CIDR da VCN
- **Security Lists**: Modifique regras de firewall em `vcn.tf`
- **Compute Instance**: Ajuste shape, imagem e cloud-init em `compute.tf`
- **Compartment**: Organize recursos em `compartment.tf`
- **OCIR**: Configure Container Registry em `ocir.tf`

## Comparação entre Nuvens

### **Recursos Equivalentes**

| Funcionalidade | AWS | Azure | GCP | OCI |
|---|---|---|---|---|
| **Computação** | EC2 t3.micro | VM Standard_B1s | Compute Engine e2-micro | Compute Instance VM.Standard.E2.1.Micro |
| **Rede Virtual** | VPC | Virtual Network | VPC | Virtual Cloud Network |
| **Container Registry** | ECR | ACR | Artifact Registry | OCIR |
| **Firewall** | Security Groups | Network Security Group | Firewall Rules | Security Lists |
| **IP Público** | Elastic IP | Public IP | External IP | Public IP |
| **Gerenciamento de Acesso** | IAM Roles | Service Principal | Service Account | Compartments |
| **Armazenamento de Estado** | S3 | Azure Storage | Google Cloud Storage | Object Storage |

### **Custos Estimados (Mensais)**

| Nuvem | Instância | Disco | IP Público | Container Registry | **Total** |
|---|---|---|---|---|---|
| **AWS** | ~$7.30 | ~$4.81 | ~$3.65 | ~$5.00 | **~$20.76** |
| **Azure** | ~$7.30 | ~$4.81 | ~$3.65 | ~$5.00 | **~$20.76** |
| **GCP** | ~$4.28* | ~$3.20 | ~$7.30 | Gratuito | **~$14.78** |
| **OCI** | **GRATUITO*** | **GRATUITO*** | **GRATUITO*** | **GRATUITO*** | **GRATUITO** |

_*GCP e2-micro pode ser gratuito no Always Free tier_  
_*OCI oferece Always Free tier para VM.Standard.E2.1.Micro_

### **Tempo de Deploy Estimado**
- **AWS**: 3-5 minutos
- **Azure**: 4-6 minutos  
- **GCP**: 3-5 minutos
- **OCI**: 5-8 minutos

## Contribuições

Contribuições são bem-vindas! Se você tem:
- Novos templates para recursos específicos
- Melhorias nos templates existentes
- Suporte para novos provedores de nuvem
- Documentação adicional
- Otimizações de custos
- Melhorias de segurança

## Recursos Adicionais

### **AWS - Documentação Específica**
- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [AWS ECR Documentation](https://docs.aws.amazon.com/ecr/)
- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [AWS Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

### **Azure - Documentação Específica**
- [Azure Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Virtual Networks](https://docs.microsoft.com/en-us/azure/virtual-network/)
- [Azure Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/)
- [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)

### **GCP - Documentação Específica**
- [Google Terraform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Google Cloud Compute Engine](https://cloud.google.com/compute/docs)
- [Google Cloud VPC](https://cloud.google.com/vpc/docs)
- [Google Cloud Artifact Registry](https://cloud.google.com/artifact-registry/docs)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs)

### **OCI - Documentação Específica**
- [Oracle Terraform Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
- [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/)
- [OCI CLI Documentation](https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/)
- [OCIR Documentation](https://docs.oracle.com/en-us/iaas/Content/Registry/home.htm)
- [OCI Always Free Resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)

### **Terraform e Multi-Cloud**
- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [Multi-Cloud Architecture Patterns](https://www.terraform.io/docs/providers/index.html)

## Licença

Este projeto está sob licença MIT. Veja o arquivo LICENSE para mais detalhes.

---

## Estrutura do Projeto

```
suporte-para-devops/
├── aws/terraform/          # Infraestrutura AWS completa
│   ├── *.tf                # Arquivos Terraform
│   ├── *.sh                # Scripts de automação
│   ├── *.json              # Políticas IAM
│   └── README.md           # Documentação AWS
├── azure/terraform/        # Infraestrutura Azure completa
│   ├── *.tf                # Arquivos Terraform
│   └── README.md           # Documentação Azure
├── gcp/terraform/          # Infraestrutura GCP completa
│   ├── *.tf                # Arquivos Terraform
│   └── README.md           # Documentação GCP
├── oci/terraform/          # Infraestrutura OCI completa
│   ├── *.tf                # Arquivos Terraform
│   ├── cloud-init.yaml     # Script de inicialização
│   └── README.md           # Documentação OCI
├── README.md               # Este arquivo
└── SECURITY_GUIDELINES.md  # Diretrizes de segurança
```

## Quick Start Summary

### **AWS** - Mais Completo
```bash
cd aws/terraform && ./apply_iam_policy.sh && terraform init && terraform apply
```

### **Azure** - Balanced
```bash
cd azure/terraform && az login && terraform init && terraform apply
```

### **GCP** - Developer Friendly
```bash
cd gcp/terraform && gcloud auth login && terraform init && terraform apply
```

### **OCI** - Always Free
```bash
cd oci/terraform && oci setup config && terraform init && terraform apply
```

---

**Se este projeto foi útil para você, considere dar uma estrela!**

**Conecte-se conosco para mais recursos de DevOps e SRE.**
