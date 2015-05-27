

INSERT INTO Artista values (1, 'Rui Veloso');
INSERT INTO Artista values (2, 'Ana Moura');
INSERT INTO Artista values (3, 'Xutos');


INSERT INTO Genero values (1, 'Fado');
INSERT INTO Genero values (2, 'Pop Rock');
INSERT INTO Genero values (3, 'Rock');
INSERT INTO Genero values (4, 'Blues');
INSERT INTO Genero values (5, 'Metal');
INSERT INTO Genero values (6, 'Pop');
INSERT INTO Genero values (7, 'Clássica');


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

INSERT INTO TipoDiscos values (1, 'CD');
INSERT INTO TipoDiscos values (2, 'Vinil');
INSERT INTO TipoDiscos values (3, 'Digital');

INSERT INTO Pagamento values (1, 'Dinheiro');
INSERT INTO Pagamento values (2, 'Multibanco');
INSERT INTO Pagamento values (3, 'Paypal');
INSERT INTO Pagamento values (4, 'Tranferencia Bancaria');

INSERT INTO TipoEncomenda values (1,'Normal');
INSERT INTO TipoEncomenda values (2, 'Domicilio');
INSERT INTO TipoEncomenda values (3, 'Loja');
INSERT INTO TipoEncomenda values (4, 'Onlinde');
INSERT INTO TipoEncomenda values (5, 'Fornecedor');

INSERT INTO Encomenda values (1,213565552 , 2, 1);
INSERT INTO Encomenda values (2,458695566 , 4, 3);
INSERT INTO Encomenda values (3,458695566 , 5, 2);

INSERT INTO Promocao values (1,0);
INSERT INTO Promocao values (2,5);
INSERT INTO Promocao values (3,10);

INSERT INTO Discos values (1,'25',10, 'Desfado', 2012, 2,1,1,1,1, (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\desfado.jpg', Single_Blob) as img) );
INSERT INTO Discos values (2,'15',15,'Dizer não de vez', 1992,3,2,2,2,1, (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\Dizernao.jpg', Single_Blob) as img));
INSERT INTO Discos values (3,'20',20,'Ar de rock', 2001,1,3,3,3,3, (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\arderock.jpg', Single_Blob) as img)); 

UPDATE Discos set imagemDisco =  (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\desfado.jpg', Single_Blob) as img) WHERE id_disco=1 ;

UPDATE Discos set imagemDisco =  (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\Dizernao.jpg', Single_Blob) as img) WHERE id_disco=2 ;

UPDATE Discos set imagemDisco =  (SELECT BulkColumn 
FROM Openrowset( Bulk 'C:\Users\Marco Macedo\Desktop\Trabalho final\ImagensDiscos\arderock.jpg', Single_Blob) as img) WHERE id_disco=3 ;

INSERT INTO Editora values (1, 'Discantus', 235698743, 'discaunts@gmail.com');
INSERT INTO Editora values (2, 'Edisco',236587412, 'edisco@gmail.com');
INSERT INTO Editora values (3, 'EditoraMusical',236984544, 'em@gmail.com');

INSERT INTO Discos_encomenda values (1,1,'2015-02-23',1);
INSERT INTO Discos_encomenda values (2,2,'2015-02-21',3);
INSERT INTO Discos_encomenda values (3,3,'2015-02-09',2);


INSERT INTO Estado values (1, 'Atrasado', 10);
INSERT INTO Estado values (2, 'Normal', NULL);

INSERT INTO Funcionario values (154545566, '700',1, 5);
INSERT INTO Funcionario values (548565641, '700',2, 5);

INSERT INTO Mensalidade values (1, 25, 10, 1);

INSERT INTO PremiumCLiente values (213565552, 1, 1);

INSERT INTO StandardCliente values (458695566);

INSERT INTO Venda values (1, '2015-02-23', '10:30', 1,154545566,3);
INSERT INTO Venda values (2, '2015-02-13', '11:30', 2,548565641,2);
INSERT INTO Venda values (3, '2015-02-03','15:23', 2,548565641,2);