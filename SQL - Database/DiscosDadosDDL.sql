

INSERT INTO Artista (Nome) values ('Rui Veloso');
INSERT INTO Artista (Nome) values ('Ana Moura');
INSERT INTO Artista (Nome) values ('Xutos');


INSERT INTO Genero (Nome) values ('Fado');
INSERT INTO Genero (Nome) values ('Pop Rock');
INSERT INTO Genero (Nome) values ('Rock');
INSERT INTO Genero (Nome) values ('Blues');
INSERT INTO Genero (Nome) values ('Metal');
INSERT INTO Genero (Nome) values ('Pop');
INSERT INTO Genero (Nome) values ('Clássica');


INSERT INTO Artista_Genero values (1,3);
INSERT INTO Artista_Genero values (2,1);
INSERT INTO Artista_genero values (3,2);

INSERT INTO Pessoa values (213565552, 'Marco Macedo', 'M', 'Porto', '4640-230', 912610186,'1974-02-12');
INSERT INTO Pessoa values (154545566, 'Rui Espinha', 'M', 'Aveiro','4640-230',963544855,'1985-10-04');
INSERT INTO Pessoa values (458695566, 'Josefina', 'F', 'Coimbra', '4640-100', 936589874,'1990-05-12');
INSERT INTO Pessoa values (548565641, 'Joaquim', 'M', 'Faro', '4640-200', 936587874,'1960-07-25');

INSERT INTO Loja values ('Porto', 1, 'Discos Store', 936585885);
INSERT INTO Loja values ('Aveiro', 2, 'Music2you', 912598469);
INSERT INTO Loja values ('Lisboa', 3, 'LoveMusic', 965444455);


INSERT INTO Admini values ('admin1', 'passe1',1,548565641);

INSERT INTO Cliente values (213565552, 1);
INSERT INTO Cliente values (458695566, 2);

INSERT INTO TipoDiscos (Nome) values ('CD');
INSERT INTO TipoDiscos (Nome)  values ('Vinil');
INSERT INTO TipoDiscos (Nome) values ('Digital');

INSERT INTO Pagamento (metodo) values ('Dinheiro');
INSERT INTO Pagamento (metodo) values ('Multibanco');
INSERT INTO Pagamento (metodo) values ('Paypal');
INSERT INTO Pagamento (metodo) values ('Tranferencia Bancaria');

INSERT INTO TipoEncomenda (TipoEncomenda) values ('Normal');
INSERT INTO TipoEncomenda (TipoEncomenda) values ('Domicilio');
INSERT INTO TipoEncomenda (TipoEncomenda) values ('Loja');
INSERT INTO TipoEncomenda (TipoEncomenda) values ('Onlinde');
INSERT INTO TipoEncomenda (TipoEncomenda)values ('Fornecedor');

INSERT INTO Encomenda (NIF_Cliente, id_tipoEncomenda, id_pagamento) values (213565552 , 2, 1);
INSERT INTO Encomenda (NIF_Cliente, id_tipoEncomenda, id_pagamento) values (458695566 , 4, 3);
INSERT INTO Encomenda (NIF_Cliente, id_tipoEncomenda, id_pagamento) values (458695566 , 5, 2);

INSERT INTO Promocao (desconto) values (0);
INSERT INTO Promocao (desconto) values (5);
INSERT INTO Promocao (desconto) values (10);

INSERT INTO Discos values (1,'25',10, 'Desfado', 2012, 2,1,1,1,4, (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\desfado.jpg', Single_Blob) as img) );
INSERT INTO Discos values (2,'15',15,'Dizer não de vez', 1992,3,2,2,2,4, (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\Dizernao.jpg', Single_Blob) as img));
INSERT INTO Discos values (3,'20',20,'Ar de rock', 2001,1,3,3,3,6, (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\arderock.jpg', Single_Blob) as img)); 

UPDATE Discos set imagemDisco =  (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\desfado.jpg', Single_Blob) as img) WHERE id_disco=1 ;

UPDATE Discos set imagemDisco =  (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\Dizernao.jpg', Single_Blob) as img) WHERE id_disco=2 ;

UPDATE Discos set imagemDisco =  (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\arderock.jpg', Single_Blob) as img) WHERE id_disco=3 ;

INSERT INTO Editora (Nome, Telefone, Email) values ('Discantus', 235698743, 'discaunts@gmail.com');
INSERT INTO Editora (Nome, Telefone, Email) values ('Edisco',236587412, 'edisco@gmail.com');
INSERT INTO Editora (Nome, Telefone, Email) values ('EditoraMusical',236984544, 'em@gmail.com');

INSERT INTO Discos_encomenda  values (1,4,'2015-02-23',1);
INSERT INTO Discos_encomenda values (2,5,'2015-02-21',3);
INSERT INTO Discos_encomenda values (3,6,'2015-02-09',2);


INSERT INTO Estado (Estado, Atraso) values ('Atrasado', 10);
INSERT INTO Estado (Estado, Atraso) values ('Normal', NULL);

INSERT INTO Funcionario values (154545566, '700',1, 5);
INSERT INTO Funcionario values (548565641, '700',2, 5);

INSERT INTO Mensalidade (Valor, Desconto, id_estado) values ( 25, 10, 1);

INSERT INTO PremiumCLiente values (213565552, 1, 1);

INSERT INTO StandardCliente values (458695566);

INSERT INTO Venda (Data, Hora, id_loja, NIF_Funcionario, id_disco,Nif_cliente) values ('2015-02-23', '10:30', 1,154545566,3,897897);
INSERT INTO Venda (Data, Hora, id_loja, NIF_Funcionario, id_disco, Nif_cliente) values ('2015-02-13', '11:30', 2,548565641,2,213565552);
INSERT INTO Venda (Data, Hora, id_loja, NIF_Funcionario, id_disco, Nif_cliente) values ('2015-02-03','15:23', 2,548565641,2,458695566);