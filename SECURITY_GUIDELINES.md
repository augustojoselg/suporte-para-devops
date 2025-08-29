# Diretrizes de Segurança

## Dados Sensíveis Identificados

### **🚨 ATENÇÃO: Dados que NÃO devem ser commitados:**

1. **Account ID AWS**: `167290362223`
2. **Bucket S3**: `terraform-state-augustojoselg`
3. **Usuário IAM**: `terraform-prod`
4. **Nome do Cliente**: `Sysmac-NF`
5. **Arquivos de Estado**: `terraform.tfstate`
6. **Configurações Reais**: `terraform.tfvars`

## Como Limpar Dados Sensíveis

### **1. Arquivos que devem ser removidos do Git:**
```bash
# Remover arquivos de estado
git rm --cached aws/terraform/terraform.tfstate
git rm --cached aws/terraform/.terraform.lock.hcl

# Remover configurações reais
git rm --cached aws/terraform/terraform.tfvars
git rm --cached aws/terraform/backend.tf

# Remover diretório .terraform
git rm -r --cached aws/terraform/.terraform/
```

### **2. Arquivos de Exemplo (podem ser commitados):**
- `terraform.tfvars.example`
- `backend.tf.example`
- `TerraformMinimalPolicy.json`

### **3. Substituir dados sensíveis por placeholders:**
- `SEU_ACCOUNT_ID_AQUI`
- `SEU_BUCKET_S3_AQUI`
- `SEU_CLIENTE_AQUI`
- `SEU_USUARIO_IAM_AQUI`

## Configuração Segura

### **1. Criar arquivo terraform.tfvars local:**
```bash
cp terraform.tfvars.example terraform.tfvars
# Editar com valores reais (não commitar)
```

### **2. Configurar backend local:**
```bash
cp backend.tf.example backend.tf
# Editar com bucket S3 real (não commitar)
```

### **3. Configurar credenciais AWS:**
```bash
export AWS_ACCESS_KEY_ID="sua_access_key"
export AWS_SECRET_ACCESS_KEY="sua_secret_key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Verificação de Segurança

### **Antes de fazer commit:**
```bash
# Verificar se há dados sensíveis
grep -r "167290362223" .
grep -r "terraform-state-augustojoselg" .
grep -r "Sysmac-NF" .
grep -r "terraform-prod" .

# Verificar se arquivos sensíveis estão no .gitignore
git status
```

### **Arquivos que devem estar no .gitignore:**
- `*.tfstate`
- `*.tfvars`
- `.terraform/`
- `terraform.tfstate`
- `backend.tf`

## Boas Práticas

1. **Nunca commitar** arquivos de estado do Terraform
2. **Sempre usar** arquivos de exemplo
3. **Substituir dados reais** por placeholders
4. **Configurar credenciais** via variáveis de ambiente
5. **Revisar commits** antes de fazer push
6. **Usar branches** para desenvolvimento
7. **Fazer backup** dos arquivos de configuração reais

## Recursos de Segurança

- [Terraform Security Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/security.html)
- [AWS Security Best Practices](https://aws.amazon.com/security/security-learning/)
- [Git Security Best Practices](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)
