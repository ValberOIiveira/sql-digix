SELECT 
    UR.id_unidade,
    UR.metragem_unidade,
    UR.num_quartos,
    UR.num_banheiros,
    P.nome AS nome_proprietario,
    E.endereco
FROM 
    Unidade_Residencial UR
JOIN 
    Pessoa P ON UR.id_proprietario = P.id_pessoa
JOIN 
    Edificacao E ON UR.id_edificacao = E.id_edificacao;