CREATE TRIGGER verifica_valor_venda
BEFORE INSERT ON venda
FOR EACH ROW
BEGIN
    DECLARE valor_minimo DECIMAL(10,2);

    SELECT valor_aquisicao * 1.3
    INTO valor_minimo
    FROM item
    WHERE num_serie = NEW.id_item;
    
    IF NEW.valor < valor_minimo THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Valor da venda abaio do mínimo permitido';
    END IF;
END;

INSERT INTO
    venda (data, valor, cpf_comprador, id_item)
VALUES
    ('2023-01-07 00:00:00', 10, '12345678901', 1);

