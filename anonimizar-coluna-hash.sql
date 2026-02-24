CREATE OR REPLACE TABLE `rj-impatech.enderecos_atuais.pessoa_endereco_anon` AS

SELECT
  TO_HEX(SHA256(cpf)) AS cpf_hash,
  endereco
FROM `rj-crm-registry.rmi_dados_mestres.pessoa_fisica`;
