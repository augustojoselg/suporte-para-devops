#!/bin/bash

# Script para aplicar a política IAM TerraformMinimalPolicy
# Execute este script após criar a política no console AWS

echo "Aplicando política IAM TerraformMinimalPolicy..."

# Nome da política
POLICY_NAME="TerraformMinimalPolicy"
USER_NAME="terraform-prod"

echo "Criando política: $POLICY_NAME"

# Criar a política
aws iam create-policy \
    --policy-name "$POLICY_NAME" \
    --policy-document file://TerraformMinimalPolicy.json \
    --description "Política mínima para usuário Terraform com permissões completas"

if [ $? -eq 0 ]; then
    echo "Política criada com sucesso!"
    
    # Obter o ARN da política
    POLICY_ARN=$(aws iam list-policies --query "Policies[?PolicyName=='$POLICY_NAME'].Arn" --output text)
    echo "ARN da política: $POLICY_ARN"
    
    echo "Anexando política ao usuário: $USER_NAME"
    
    # Anexar a política ao usuário
    aws iam attach-user-policy \
        --user-name "$USER_NAME" \
        --policy-arn "$POLICY_ARN"
    
    if [ $? -eq 0 ]; then
        echo "Política anexada com sucesso ao usuário $USER_NAME!"
        echo ""
        echo "Agora você pode executar o Terraform com todas as permissões necessárias!"
        echo "Execute: terraform plan"
    else
        echo "Erro ao anexar política ao usuário"
        exit 1
    fi
else
    echo "Erro ao criar política"
    exit 1
fi

echo ""
echo "Verificando políticas anexadas ao usuário:"
aws iam list-attached-user-policies --user-name "$USER_NAME"
