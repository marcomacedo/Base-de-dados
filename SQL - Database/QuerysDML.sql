SELECT titulo
FROM DISCOS
WHERE Ano = 2001

SELECT ALL Nome
FROM Editora 

SELECT titulo 
FROM DISCOS 
GROUP BY titulo, Ano 

SELECT titulo, Nome
FROM DISCOS AS D JOIN Artista AS A ON D.id_artista = A.id_artista 
GROUP BY titulo, Nome

SELECT E.id_encomenda, P.Nome
FROM Encomenda As E JOIN Cliente As Cl ON E.NIF_Cliente = Cl.NIF JOIN Pessoa As P ON Cl.NIF = P.NIF
WHERE id_tipoEncomenda = 5


 SELECT Nome
 FROM Pessoa As P JOIN PremiumCliente As C ON P.nif=C.nif


SELECT DATA, Hora, COUNT(F.NIF)
 From Venda As V JOIN Funcionario As F ON F.nif = V.NIF_funcionario
 GROUP BY DATA, Hora