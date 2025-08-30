# GCP Terraform Infrastructure

Este diretório contém toda a infraestrutura Google Cloud Platform necessária para executar a aplicação sem precisar do console GCP.

## Arquivos Criados

### Infraestrutura de Rede
- **`vpc.tf`** - VPC, subnet, firewall rules para SSH, HTTP e HTTPS
- **`compute.tf`** - Instância Compute Engine e IP externo estático

### Segurança e Acesso
- **`iam.tf`** - Service Account e permissões para Artifact Registry
- **`keypair.tf`** - Geração automática de chave SSH

### Configuração e Dados
- **`provider.tf`** - Configuração dos providers GCP, TLS e HTTP
- **`data.tf`** - Busca dinâmica de imagem Ubuntu e IP público
- **`variables.tf`** - Variáveis configuráveis do projeto
- **`outputs.tf`** - Informações importantes após o deploy

### Container Registry
- **`artifact_registry.tf`** - Artifact Registry para imagens Docker

### Estado e Configuração
- **`backend.tf`** - Configuração do backend Google Cloud Storage para estado remoto
- **`terraform.tfvars.example`** - Exemplo de configuração das variáveis

## Como Executar

### 1. Pré-requisitos
```bash
# Instalar Terraform
# Instalar Google Cloud SDK e fazer login
gcloud auth login

# Verificar a conta ativa
gcloud auth list

# Definir projeto padrão
gcloud config set project SEU_PROJECT_ID_AQUI

# Habilitar APIs necessárias
gcloud services enable compute.googleapis.com
gcloud services enable artifactregistry.googleapis.com
```

### 2. Configurar Variáveis
```bash
# Copiar o arquivo de exemplo
cp terraform.tfvars.example terraform.tfvars

# Editar conforme necessário (OBRIGATÓRIO definir gcp_project_id)
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
# Após o deploy, usar o output para conectar (com chave SSH)
terraform output ssh_connection

# Ou usar gcloud (mais fácil)
terraform output gcloud_ssh_connection

# Conectar manualmente
ssh -i ~/.ssh/gcp-key.pem seu-cliente-aqui@<IP_PUBLICO>
```

## Recursos Criados

### Rede
- **VPC**: Custom network com subnet `10.0.1.0/24`
- **Firewall Rules**: SSH (seu IP), HTTP (80), HTTPS (443)
- **IP Externo**: IP estático público

### Computação
- **Compute Engine**: e2-micro com Ubuntu 22.04 LTS
- **Disco**: 20GB SSD padrão
- **Startup Script**: Instala Docker e Google Cloud SDK

### Segurança
- **Firewall Rules**: Acesso controlado por tags
- **Service Account**: Permissões para Artifact Registry
- **SSH Keys**: Chave SSH gerada automaticamente

### Container Registry
- **Artifact Registry**: Repository Docker na região especificada

## Outputs Disponíveis

Após o deploy, você terá acesso a:
- **IP Externo** da instância
- **IP Interno** da instância
- **IDs** de todos os recursos criados
- **URL** do Artifact Registry
- **Email** da Service Account
- **Comandos SSH** para conexão

## Para Destruir a Infraestrutura

```bash
terraform destroy
```

**ATENÇÃO**: Isso removerá TODOS os recursos criados!

## Troubleshooting

### Erro de Autenticação
```bash
# Verificar se está logado no GCP
gcloud auth list

# Fazer login novamente se necessário
gcloud auth login
```

### Erro de Projeto
```bash
# Verificar projeto ativo
gcloud config get-value project

# Definir projeto
gcloud config set project SEU_PROJECT_ID_AQUI

# Verificar se o projeto existe
gcloud projects describe SEU_PROJECT_ID_AQUI
```

### Erro de APIs
```bash
# Verificar APIs habilitadas
gcloud services list --enabled

# Habilitar APIs necessárias
gcloud services enable compute.googleapis.com
gcloud services enable artifactregistry.googleapis.com
```

### Erro de Quotas
```bash
# Verificar quotas
gcloud compute project-info describe --project=SEU_PROJECT_ID_AQUI

# Verificar se a região/zona suporta o tipo de máquina
gcloud compute machine-types list --zones=us-central1-a
```

### Erro de Permissões
```bash
# Verificar permissões
gcloud projects get-iam-policy SEU_PROJECT_ID_AQUI

# Verificar se tem papel de Editor ou Owner
gcloud projects get-iam-policy SEU_PROJECT_ID_AQUI --flatten="bindings[].members" --format="table(bindings.role)" --filter="bindings.members:$(gcloud config get-value account)"
```

## Custos Estimados

### Recursos Principais (us-central1)
- **Compute Engine e2-micro**: ~$4.28/mês (elegível para Always Free)
- **Disco SSD 20GB**: ~$3.20/mês
- **IP Externo Estático**: ~$7.30/mês
- **Artifact Registry**: Grátis até 0.5GB
- **Total Estimado**: ~$14.78/mês

**Nota**: e2-micro pode ser gratuito se você estiver no nível Always Free do GCP.

## Comandos Úteis

### Docker com Artifact Registry
```bash
# Configurar Docker para usar Artifact Registry
gcloud auth configure-docker us-central1-docker.pkg.dev

# Fazer push de uma imagem
docker tag minha-app us-central1-docker.pkg.dev/SEU_PROJECT_ID/app-prod/minha-app
docker push us-central1-docker.pkg.dev/SEU_PROJECT_ID/app-prod/minha-app
```

### Monitoramento
```bash
# Ver logs da instância
gcloud logging read "resource.type=gce_instance" --limit=50

# Conectar via console serial
gcloud compute instances get-serial-port-output vm-seu-cliente-prod --zone=us-central1-a
```

## Recursos Adicionais

- [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Google Cloud Compute Engine](https://cloud.google.com/compute/docs)
- [Google Cloud VPC](https://cloud.google.com/vpc/docs)
- [Google Cloud Artifact Registry](https://cloud.google.com/artifact-registry/docs)

---

**Agora tudo pode ser executado via Terraform sem precisar do console GCP!**
