# OCI Terraform Infrastructure

Este diretório contém toda a infraestrutura Oracle Cloud Infrastructure necessária para executar a aplicação sem precisar do console OCI.

## Arquivos Criados

### Infraestrutura de Rede
- **`vcn.tf`** - VCN, subnet pública, internet gateway, route table e security lists
- **`compute.tf`** - Instância Compute e configurações de rede

### Organização e Segurança
- **`compartment.tf`** - Compartment para organizar recursos
- **`keypair.tf`** - Geração automática de chave SSH
- **`cloud-init.yaml`** - Script de inicialização da instância

### Configuração e Dados
- **`provider.tf`** - Configuração dos providers OCI, TLS e HTTP
- **`data.tf`** - Busca dinâmica de availability domains, imagens e IP público
- **`variables.tf`** - Variáveis configuráveis do projeto
- **`outputs.tf`** - Informações importantes após o deploy

### Container Registry
- **`ocir.tf`** - Configuração para Oracle Cloud Infrastructure Registry

### Estado e Configuração
- **`backend.tf`** - Configuração do backend Object Storage para estado remoto
- **`terraform.tfvars.example`** - Exemplo de configuração das variáveis

## Como Executar

### 1. Pré-requisitos

#### Instalar OCI CLI
```bash
# Linux/macOS
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"

# Verificar instalação
oci --version
```

#### Configurar Credenciais OCI
```bash
# Executar configuração interativa
oci setup config

# Isso criará:
# - ~/.oci/config (arquivo de configuração)
# - ~/.oci/oci_api_key.pem (chave privada)
# - ~/.oci/oci_api_key_public.pem (chave pública)
```

#### Obter OCIDs Necessários
```bash
# Tenancy OCID
oci iam tenancy get --tenancy-id $(oci iam tenancy get --query 'data.id' --raw-output 2>/dev/null || echo "CONFIGURE_FIRST")

# User OCID
oci iam user list --compartment-id $(oci iam tenancy get --query 'data.id' --raw-output)

# Fingerprint (do arquivo ~/.oci/config)
cat ~/.oci/config | grep fingerprint
```

### 2. Configurar Variáveis
```bash
# Copiar o arquivo de exemplo
cp terraform.tfvars.example terraform.tfvars

# Editar com os valores obtidos (OBRIGATÓRIO)
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

# Conectar manualmente
ssh -i ~/.ssh/oci-key.pem opc@<IP_PUBLICO>
```

## Recursos Criados

### Organização
- **Compartment**: Organiza todos os recursos do projeto
- **Tags**: Identificação e categorização dos recursos

### Rede
- **VCN**: `10.0.0.0/16` Virtual Cloud Network
- **Subnet Pública**: `10.0.1.0/24` com acesso à internet
- **Internet Gateway**: Acesso externo
- **Route Table**: Roteamento para internet
- **Security Lists**: SSH (seu IP), HTTP (80), HTTPS (443)

### Computação
- **Compute Instance**: VM.Standard.E2.1.Micro com Oracle Linux 8
- **Cloud-init**: Instala Docker, Docker Compose e OCI CLI automaticamente
- **SSH Keys**: Chave SSH gerada automaticamente

### Container Registry
- **OCIR**: Oracle Cloud Infrastructure Registry (disponível automaticamente)

## Outputs Disponíveis

Após o deploy, você terá acesso a:
- **IP Público** e **IP Privado** da instância
- **OCIDs** de todos os recursos criados
- **Namespace** e **Endpoint** do OCIR
- **Comando SSH** para conexão
- **Região** e **Availability Domain** utilizados

## Para Destruir a Infraestrutura

```bash
terraform destroy
```

**ATENÇÃO**: Isso removerá TODOS os recursos criados!

## Troubleshooting

### Erro de Configuração OCI
```bash
# Verificar configuração
oci iam tenancy get

# Reconfigurar se necessário
oci setup config
```

### Erro de Permissões
```bash
# Verificar políticas do usuário
oci iam user list-groups --user-id SEU_USER_OCID

# Verificar se tem permissões adequadas no compartment
oci iam policy list --compartment-id SEU_TENANCY_OCID
```

### Erro de Quotas/Limites
```bash
# Verificar limites de serviço
oci limits service list

# Verificar quotas específicas
oci limits quota list --compartment-id SEU_TENANCY_OCID
```

### Erro de Shape Não Disponível
```bash
# Listar shapes disponíveis na região
oci compute shape list --compartment-id SEU_COMPARTMENT_OCID

# Verificar availability domains
oci iam availability-domain list --compartment-id SEU_TENANCY_OCID
```

### Erro de Imagem
```bash
# Listar imagens disponíveis
oci compute image list --compartment-id SEU_TENANCY_OCID --operating-system "Oracle Linux"
```

## Custos Estimados

### Always Free Tier (Elegível)
- **VM.Standard.E2.1.Micro**: 2 instâncias GRATUITAS (1 OCPU, 1GB RAM)
- **Block Volume**: 200GB GRATUITOS
- **OCIR**: 500GB GRATUITOS
- **Object Storage**: 20GB GRATUITOS
- **Outbound Data Transfer**: 10TB/mês GRATUITOS

### Recursos Pagos (se exceder limites gratuitos)
- **VM.Standard.E2.1**: ~$5.50/mês
- **Boot Volume 47GB**: ~$2.35/mês
- **Public IP**: GRATUITO

**Total Estimado**: GRATUITO (se permanecer nos limites Always Free)

## Comandos Úteis para OCIR

### Configurar Docker para OCIR
```bash
# Fazer login no OCIR
docker login <region-key>.ocir.io

# Username: <namespace>/<oci-username>
# Password: <auth-token>
```

### Exemplo de uso do OCIR
```bash
# Tag de uma imagem
docker tag minha-app iad.ocir.io/namespace/minha-app:latest

# Push para OCIR
docker push iad.ocir.io/namespace/minha-app:latest

# Pull do OCIR
docker pull iad.ocir.io/namespace/minha-app:latest
```

### Gerenciar Auth Tokens
```bash
# Criar auth token
oci iam auth-token create --user-id SEU_USER_OCID --description "Docker OCIR token"

# Listar auth tokens
oci iam auth-token list --user-id SEU_USER_OCID
```

## Configuração OCI CLI na Instância

A instância já vem com OCI CLI instalado via cloud-init. Para configurar:

```bash
# Conectar via SSH
ssh -i ~/.ssh/oci-key.pem opc@<IP_PUBLICO>

# Configurar OCI CLI na instância
oci setup config

# Testar
oci iam tenancy get
```

## Recursos Adicionais

- [Terraform OCI Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
- [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/)
- [OCI CLI Documentation](https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/)
- [OCIR Documentation](https://docs.oracle.com/en-us/iaas/Content/Registry/home.htm)
- [OCI Always Free Resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)

---

**Agora tudo pode ser executado via Terraform sem precisar do console OCI!**
