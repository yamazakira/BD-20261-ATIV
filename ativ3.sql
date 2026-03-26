CREATE TABLE lucro_modelo AS
SELECT
    M.nome AS modelo,
    COALESCE(SUM(V.valor - I.valor_aquisicao),0)         AS lucro_acumulado
FROM
    modelo M
LEFT JOIN item I ON I.modelo_id = M.id
LEFT JOIN venda V ON V.id_item = I.num_serie
GROUP BY
    M.nome
ORDER BY
    lucro_acumulado DESC;

SELECT *
FROM lucro_modelo;

SELECT *
FROM lucro_modelo;

-- v2
CREATE TABLE lucro AS
SELECT
    VENDA.id_item,
    (VENDA.valor - ITEM.valor_aquisicao) AS lucro_item
FROM
    venda VENDA
JOIN item ITEM ON VENDA.id_item  = ITEM.num_serie;

SELECT *
FROM lucro
