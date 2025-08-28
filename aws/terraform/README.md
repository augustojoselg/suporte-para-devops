# AWS Terraform Infrastructure

Este diretório contém toda a infraestrutura AWS necessária para executar a aplicação sem precisar do console AWS.

## Arquivos Criados

### Infraestrutura de Rede
- **`vpc.tf`** - VPC, subnet pública, internet gateway e route table
- **`ec2.tf`** - Instância EC2 e security group com regras de acesso

### Segurança e Acesso
- **`iam.tf`** - Role IAM, políticas para ECR e instance profile
- **`keypair.tf`** - Geração automática de chave SSH

### Configuração e Dados
- **`provider.tf`** - Configuração dos providers AWS, TLS e HTTP
- **`data.tf`** - Busca dinâmica de AMI e IP público
- **`variables.tf`** - Variáveis configuráveis do projeto
- **`outputs.tf`** - Informações importantes após o deploy

### Estado e Configuração
- **`backend.tf`** - Configuração do backend S3 para estado remoto
- **`terraform.tfvars.example`** - Exemplo de configuração das variáveis

## Como Executar

### 1. Pré-requisitos
```bash
# Instalar Terraform
# Configurar credenciais AWS (AWS CLI ou variáveis de ambiente)
export AWS_ACCESS_KEY_ID="sua_access_key"
export AWS_SECRET_ACCESS_KEY="sua_secret_key"
export AWS_DEFAULT_REGION="us-east-1"
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
ssh -i ~/.ssh/aws-mentorias-01.pem ec2-user@<IP_PUBLICO>
```

## Recursos Criados

### Rede
- **VPC**: `10.0.0.0/16`
- **Subnet Pública**: `10.0.1.0/24` em `us-east-1a`
- **Internet Gateway** para acesso externo
- **Route Table** com rota para internet

### Computação
- **EC2**: Instância t3.micro com Amazon Linux 2
- **Security Group**: Acesso SSH (seu IP), HTTP (80), HTTPS (443)
- **Key Pair**: Chave SSH gerada automaticamente

### Segurança
- **Security Group**: Regras de entrada e saída configuradas
- **Key Pair**: Chave SSH gerada automaticamente
- **IAM Role**: Criado automaticamente com permissões para ECR

### Container Registry
- **ECR Repository**: `app_prod` para imagens Docker

## Outputs Disponíveis

Após o deploy, você terá acesso a:
- **IP Público** da instância EC2
- **DNS Público** da instância
- **IDs** de todos os recursos criados
- **URL** do repositório ECR
- **Comando SSH** para conexão

## Para Destruir a Infraestrutura

```bash
terraform destroy
```

**ATENÇÃO**: Isso removerá TODOS os recursos criados!

## Troubleshooting

### Erro de Credenciais
```bash
# Verificar se as credenciais estão configuradas
aws sts get-caller-identity
```

### Erro de Backend S3
```bash
# Verificar se o bucket S3 existe
aws s3 ls s3://terraform-state-augustojoselb
```

### Erro de Permissões IAM
```bash
# Verificar se o usuário tem permissões para criar recursos
aws iam get-user
```

**Resolvido**: Agora com permissões adequadas, o IAM role é criado automaticamente via Terraform.

## Recursos Adicionais

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [AWS ECR Documentation](https://docs.aws.amazon.com/ecr/)

---

**Agora tudo pode ser executado via Terraform sem precisar do console AWS!**
