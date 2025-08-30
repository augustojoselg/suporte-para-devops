# Container Registry namespace data source
data "oci_objectstorage_namespace" "main" {
  compartment_id = var.oci_tenancy_ocid
}

# Note: Oracle Cloud Infrastructure Registry (OCIR) é automaticamente disponível
# Não precisa criar recursos, apenas configurar autenticação
# O endpoint será: <region-key>.ocir.io

# Para usar OCIR, você precisará:
# 1. Auth Token para o usuário
# 2. Endpoint do registry: <region-key>.ocir.io
# 3. Namespace: resultado do data source acima
