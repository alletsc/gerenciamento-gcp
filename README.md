# Gerenciamento GCP

Repositório com queries SQL para gerenciamento, análise e monitoramento de recursos do Google Cloud Platform (GCP).

## Estrutura do Projeto

```
gerenciamento-gcp/
├── custos-gcs/              # Análises de custos e billing
├── mapear-permissoes-acessos/  # Mapeamento de projetos e permissões
└── create-copy-datasets/    # Cópia e anonimização de datasets
```

## Módulos

### 1. Custos GCS (`custos-gcs/`)

Queries para análise de custos e consumo de recursos do GCP.

#### Arquivos:

- **[consulta-bucket-sku-custo.sql](custos-gcs/consulta-bucket-sku-custo.sql)**
  - Análise de custos do Cloud Storage por SKU
  - Foco em transferência de dados (Network Data Transfer)
  - Métricas: TB transferidos, localização, custos por recurso

- **[consulta-jobs-email.sql](custos-gcs/consulta-jobs-email.sql)**
  - Consulta jobs do BigQuery por email/usuário
  - Métricas: bytes processados/billed, duração, destino
  - Identificação de jobs em horários de pico

- **[consulta-jobs-email-custo.sql](custos-gcs/consulta-jobs-email-custo.sql)**
  - Análise de custos de jobs por usuário

- **[consulta-jobs-sem-converao.sql](custos-gcs/consulta-jobs-sem-converao.sql)**
  - Análise de billing sem conversão de moeda

- **[consulta-log-jobs-projeto.sql](custos-gcs/consulta-log-jobs-projeto.sql)**
  - Extração de logs de jobs por projeto

### 2. Mapeamento de Permissões e Acessos (`mapear-permissoes-acessos/`)

Queries para auditoria e gerenciamento de projetos GCP.

#### Arquivo:

- **[mapear-projetos-acessos-permissoes.sql](mapear-permissoes-acessos/mapear-projetos-acessos-permissoes.sql)**

Funcionalidades principais:

1. **Identificação de projetos sem permissão de acesso**
   - Compara projetos na dimensão vs jobs registrados
   - Lista projetos removidos por falta de permissão

2. **Análise de atividade de projetos**
   - Último job executado
   - Dias sem atividade
   - Status: Ativo, Inativo, Sem permissão

3. **Validação de classificação por órgão**
   - Verifica se projetos estão classificados corretamente
   - Padrões: IPLANRIO, RECRIO, etc.

4. **Análise de custos vs jobs**
   - Identifica projetos com custo no billing mas sem jobs
   - Indica problemas de permissão ou coleta incompleta

5. **Script CLI para concessão de permissões**
   - Exemplo de comando `gcloud` para adicionar IAM policies
   - Concessão em massa para múltiplos projetos

### 3. Criação e Cópia de Datasets (`create-copy-datasets/`)

Queries para gerenciamento de datasets do BigQuery.

#### Arquivos:

- **[consulta-copy-dataset.sql](create-copy-datasets/consulta-copy-dataset.sql)**
  - Geração automática de statements `CREATE TABLE ... COPY`
  - Cópia de todas as tabelas de um dataset

- **[anonimizar-coluna-hash.sql](create-copy-datasets/anonimizar-coluna-hash.sql)**
  - Anonimização de dados sensíveis (CPF)
  - Utiliza hash SHA256 para proteção de PII

## Tecnologias

- **Google Cloud Platform (GCP)**
  - BigQuery
  - Cloud Storage
  - IAM (Identity and Access Management)
  - Cloud Billing

- **SQL**
  - BigQuery Standard SQL
  - Análises OLAP
  - CTEs (Common Table Expressions)

## Projetos Monitorados

- `rj-iplanrio` (principal)
- Projetos da prefeitura do Rio: IPLANRIO, RECRIO, etc.
- Projetos específicos: datario, rj-superapp, rj-chatbot, entre outros

## Service Accounts Monitoradas

- `dbt-ci-github-rj-iplanrio@rj-iplanrio.iam.gserviceaccount.com`
- `dbt-stella-costa@rj-iplanrio.iam.gserviceaccount.com`

## Uso

1. Copie a query desejada
2. Execute no console do BigQuery ou via CLI
3. Ajuste os parâmetros conforme necessário:
   - `project_id`
   - Datas (timestamps)
   - Filtros específicos

## Observações

- Queries utilizam a tabela de billing: `rj-iplanrio.brutos_gcp.gcp_billing`
- Tabela de jobs: `rj-iplanrio.brutos_gcp.gcp_bigquery_jobs_v2`
- Dimensão de projetos: `rj-iplanrio.brutos_gcp.dim_gcp_project`
- Horários estão em UTC
