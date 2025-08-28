# Instruções para Aplicar a Política IAM

## O que foi Criado

1. **`TerraformMinimalPolicy.json`** - Arquivo da política IAM completa
2. **`apply_iam_policy.sh`** - Script para aplicar a política automaticamente
3. **`INSTRUCTIONS_IAM.md`** - Este arquivo com instruções

## Opção 1: Aplicar via Script (Recomendado)

### 1. Dar permissão de execução ao script
```bash
chmod +x apply_iam_policy.sh
```

### 2. Executar o script
```bash
./apply_iam_policy.sh
```

**O script fará automaticamente:**
- Criar a política `TerraformMinimalPolicy`
- Anexar a política ao usuário `terraform-prod`
- Verificar se foi aplicada com sucesso

## Opção 2: Aplicar Manualmente no Console AWS

### 1. Acessar o Console AWS IAM
- Vá para: https://console.aws.amazon.com/iam/
- Clique em "Policies" no menu lateral

### 2. Criar Nova Política
- Clique em "Create policy"
- Escolha "JSON" como método
- Cole o conteúdo do arquivo `TerraformMinimalPolicy.json`
- Clique em "Next: Tags" (opcional)
- Clique em "Next: Review"
- Nome: `TerraformMinimalPolicy`
- Descrição: `Política mínima para usuário Terraform com permissões completas`
- Clique em "Create policy"

### 3. Anexar Política ao Usuário
- Clique em "Users" no menu lateral
- Clique no usuário `terraform-prod`
- Clique na aba "Permissions"
- Clique em "Add permissions"
- Escolha "Attach policies directly"
- Procure por `TerraformMinimalPolicy`
- Marque a política e clique em "Next: Review"
- Clique em "Add permissions"

## Verificar se Funcionou

### Via AWS CLI
```bash
# Verificar políticas anexadas
aws iam list-attached-user-policies --user-name terraform-prod

# Verificar permissões
aws iam get-user --user-name terraform-prod
```

### Via Console AWS
- Vá para IAM > Users > terraform-prod
- Aba "Permissions"
- Deve mostrar `TerraformMinimalPolicy` anexada

## Após Aplicar a Política

### 1. Descomente o arquivo `iam.tf`
```bash
# Editar o arquivo iam.tf e descomente todas as linhas
nano iam.tf
```

### 2. Execute o Terraform
```bash
terraform plan
terraform apply
```

## Permissões Incluídas na Política

### Serviços Principais
- **EC2**: Todas as operações
- **S3**: Todas as operações
- **IAM**: Todas as operações (incluindo criação de roles)
- **ECR**: Todas as operações
- **VPC**: Todas as operações
- **Security Groups**: Todas as operações

### Serviços Adicionais
- **CloudWatch, Logs, X-Ray**
- **Auto Scaling, Load Balancer**
- **Lambda, API Gateway**
- **RDS, ElastiCache, Redshift**
- **ECS, EKS**
- **E muito mais...**

## Importante

- **Esta política é muito ampla** para uso em produção
- **Use apenas para desenvolvimento/teste**
- **Para produção, crie políticas mais restritivas**
- **Monitore o uso das permissões**

## Troubleshooting

### Erro de Permissões
```bash
# Verificar se a política foi aplicada
aws iam list-attached-user-policies --user-name terraform-prod

# Verificar se o usuário existe
aws iam get-user --user-name terraform-prod
```

### Erro no Script
```bash
# Verificar permissões do usuário atual
aws sts get-caller-identity

# Executar com debug
bash -x apply_iam_policy.sh
```

---

**Após aplicar esta política, o Terraform terá todas as permissões necessárias para criar a infraestrutura completa!**
