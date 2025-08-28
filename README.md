# Suporte para DevOps e SREs

## Sobre o Projeto

Este repositório oferece um conjunto abrangente de recursos e templates para profissionais de **DevOps** e **Site Reliability Engineering (SRE)** que trabalham com infraestrutura como código (IaC) e automação de nuvem.

## O que Oferecemos

### **Multi-Cloud Support**
- **AWS** - Templates Terraform para EC2, ECR e infraestrutura básica
- **Azure** - Configurações para recursos Azure com Terraform
- **Google Cloud Platform (GCP)** - Templates para infraestrutura GCP
- **Oracle Cloud Infrastructure (OCI)** - Suporte para recursos OCI

### **Ferramentas e Tecnologias**
- **Terraform** - Infraestrutura como código (IaC)
- **Backend Configurations** - Configurações de estado remoto
- **Provider Configurations** - Configurações específicas de cada provedor
- **Templates Reutilizáveis** - Código modular e reutilizável

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

#### **Azure Terraform**
- `provider.tf` - Configuração do provedor Azure
- `backend.tf` - Configuração de backend para estado remoto

#### **GCP Terraform**
- `provider.tf` - Configuração do provedor Google Cloud
- `backend.tf` - Configuração de backend para estado remoto

#### **OCI Terraform**
- `provider.tf` - Configuração do provedor Oracle Cloud
- `backend.tf` - Configuração de backend para estado remoto

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

#### **Outras Clouds**
```bash
# Para Azure
cd azure/terraform
terraform init
terraform plan
terraform apply

# Para GCP
cd gcp/terraform
terraform init
terraform plan
terraform apply

# Para OCI
cd oci/terraform
terraform init
terraform plan
terraform apply
```

## Personalização

### **AWS - Configurações Avançadas**
- **Variáveis**: Edite `terraform.tfvars` para personalizar região, tipo de instância, CIDR da VPC
- **Security Groups**: Modifique regras de firewall em `ec2.tf`
- **IAM Policies**: Ajuste permissões do role em `iam.tf`
- **Network**: Configure VPC e subnets em `vpc.tf`
- **EC2**: Personalize tipo de instância, AMI e configurações em `ec2.tf`

### **Outras Clouds**
Cada diretório de provedor contém:
- **Provider Configuration** - Ajuste as configurações específicas do provedor
- **Backend Configuration** - Configure o armazenamento de estado
- **Resource Templates** - Modifique os recursos conforme suas necessidades

## Contribuições

Contribuições são bem-vindas! Se você tem:
- Novos templates para recursos específicos
- Melhorias nos templates existentes
- Suporte para novos provedores de nuvem
- Documentação adicional

## Recursos Adicionais

### **AWS - Documentação Específica**
- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [AWS ECR Documentation](https://docs.aws.amazon.com/ecr/)
- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [AWS Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

### **Terraform e Outras Clouds**
- [Terraform Documentation](https://www.terraform.io/docs)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Google Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Oracle Provider Documentation](https://registry.terraform.io/providers/oracle/oci/latest/docs)

## Licença

Este projeto está sob licença MIT. Veja o arquivo LICENSE para mais detalhes.

---

**Se este projeto foi útil para você, considere dar uma estrela!**

**Conecte-se conosco para mais recursos de DevOps e SRE.**
