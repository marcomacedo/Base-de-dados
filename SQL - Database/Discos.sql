CREATE DATABASE LojaDiscos

CREATE TABLE Loja (
        Endereço		varchar(60) UNIQUE NOT NULL,
        ID_Loja         INT	UNIQUE NOT NULL,
        Nome            varchar(30) NOT NULL,
        Telefone        INT UNIQUE NOT NULL,
		
        PRIMARY KEY(ID_Loja)
        );
 
CREATE TABLE Pessoa(
        NIF             INT UNIQUE NOT NULL,
        Nome            varchar(30) NOT NULL,
        Sexo            char NOT NULL,
        Endereço		varchar(60) NOT NULL,
        Cod_postal		varchar(8) NOT NULL,
		Telefone		INT NOT NULL,
		data_nascimento	date NOT NULL,

        PRIMARY KEY(NIF)
		
		);
CREATE TABLE Admini(
			username varchar(30),
			passe varchar(30),
			ID_loja int REFERENCES Loja(ID_loja),
			NIF int REFERENCES Pessoa(NIF),
			PRIMARY KEY(passe)
			
			);

CREATE TABLE Funcionario(
        NIF             INT NOT NULL REFERENCES Pessoa(NIF),
        Salario         money NOT NULL,
        ID_Loja         INT NOT NULL REFERENCES Loja(ID_loja),
        Comissao        INT NOT NULL,
       
        PRIMARY KEY(NIF));
 
CREATE TABLE Cliente(
        NIF     INT NOT NULL REFERENCES Pessoa(NIF),
        ID_Loja INT NOT NULL REFERENCES Loja(ID_loja),
       
        PRIMARY KEY(NIF));

CREATE TABLE Estado(
	id_estado	INT IDENTITY(1,1),
	Estado		varchar(30) NOT NULL,
	Atraso		INT,

	PRIMARY KEY(id_estado)
);


CREATE TABLE Mensalidade(
	id_mensalidade	INT IDENTITY(1,1),
	Valor			money NOT NULL,
	Desconto		INT NOT NULL,
	id_estado		INT NOT NULL REFERENCES Estado(id_estado),

	PRIMARY KEY(id_mensalidade)

);

CREATE TABLE Promocao(
	id_promocao	INT IDENTITY(1,1),
	desconto	INT	NOT NULL,

	PRIMARY KEY(id_promocao)
);

CREATE TABLE PremiumCLiente(
		NIF		INT NOT NULL REFERENCES Cliente(NIF),
		id_mensalidade	INT NOT NULL REFERENCES Mensalidade(id_mensalidade),
		id_promocao		INT NOT NULL REFERENCES Promocao(id_promocao) ,

		PRIMARY KEY(NIF)
	);

CREATE TABLE StandardCliente(
		NIF		INT NOT NULL REFERENCES CLiente(NIF),

		PRIMARY KEY(NIF)
);


CREATE TABLE Artista(
	id_artista	INT IDENTITY(1,1) ,
	Nome		varchar(30) NOT NULL,

	PRIMARY KEY(id_artista)
	);

CREATE TABLE Genero(
	id_genero INT IDENTITY(1,1),
	Nome varchar(30) NOT NULL,

	PRIMARY KEY(id_genero)
);

CREATE TABLE TipoDiscos(
	id_tipo			INT IDENTITY(1,1),
	Nome			varchar(30) NOT NULL,

	PRIMARY KEY(id_tipo)
	);

CREATE TABLE TipoEncomenda(
	id_tipoEncomenda	INT IDENTITY(1,1),
	TipoEncomenda		varchar(30) NOT NULL,

	PRIMARY KEY(id_tipoEncomenda)
);

CREATE TABLE Pagamento(
	id_pagamento	INT IDENTITY(1,1),
	metodo			varchar(30) NOT NULL,

	PRIMARY KEY(id_pagamento)

);
CREATE TABLE Encomenda(
	id_encomenda	INT UNIQUE IDENTITY(1,1) ,
	NIF_Cliente		INT REFERENCES Cliente(NIF),
	id_tipoEncomenda INT NOT NULL REFERENCES TipoEncomenda(id_tipoEncomenda),
	id_pagamento	INT NOT NULL REFERENCES Pagamento(id_pagamento),

	PRIMARY KEY(id_encomenda)
	);

CREATE TABLE Discos(
		id_disco		INT UNIQUE NOT NULL,
		preço			money NOT NULL,
		stock			INT NOT NULL,
		titulo			varchar(30) NOT NULL,
		Ano				INT NOT NULL,
		id_artista		INT NOT NULL REFERENCES Artista(id_artista),
		id_genero		INT NOT NULL REFERENCES Genero(id_genero),
		id_tipo			INT NOT NULL REFERENCES TipoDiscos(id_tipo),
		id_promocao		INT  REFERENCES Promocao(id_promocao),
		id_Encomenda	INT  REFERENCES Encomenda(id_encomenda),
		imagemDisco		varbinary(max) NOT NULL,

		PRIMARY KEY(id_disco)
);

ALter TABLE Discos ALter column imagemDisco varbinary(max);

CREATE TABLE Artista_genero(
		id_artista	INT NOT NULL REFERENCES Artista(id_artista),
		id_genero	INT NOT NULL REFERENCES Genero(id_genero),

		PRIMARY KEY(id_artista, id_genero)
		);

CREATE TABLE Editora(
		id_editora	INT IDENTITY(1,1),
		Nome		varchar(30) UNIQUE NOT NULL,
		Telefone	INT UNIQUE NOT NULL,
		Email		varchar(20) UNIQUE NOT NULL,

		PRIMARY KEY(id_editora)
	);
CREATE TABLE Discos_encomenda(
	id_disco		INT NOT NULL REFERENCES Discos(id_disco),
	id_encomenda	INT NOT NULL REFERENCES Encomenda(id_encomenda),
	Data_expedicao	date NOT NULL,
	id_Editora		INT NOT NULL REFERENCES Editora(id_editora) ,

	PRIMARY KEY(id_disco)
);



CREATE TABLE Venda(
	id_venda		INT IDENTITY(1,1),
	Data			date NOT NULL ,
	Hora			time NOT NULL,
	id_loja			INT NOT NULL REFERENCES Loja(id_loja) ,
	NIF_Funcionario	INT NOT NULL REFERENCES Funcionario(NIF),
	id_disco		INT NOT NULL REFERENCES Discos(id_disco),

	PRIMARY KEY(id_venda)
);