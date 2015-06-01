

-- login func

GO
Create procedure loginFunc
@NIF_Func int
AS
declare @nif_f int
SELECT @nif_f=NIF FROM Funcionario where NIF=@NIF_Func
if @NIF_Func is null
return -1
else if @NIF_Func=@nif_f
return 1
else
return -2

--login admin
GO
CREATE PROCEDURE logincheck
(
@u varchar(50),
@p varchar(100)
)
as
declare @ap varchar(50)
select @ap=passe from Admini where username=@u
if @ap is null
return -1
else
if @ap=@p
return 1
else
return -2

--Pesqusiar Clientes premium

Go
Create procedure pesquisaClientesPR
@pesquisa int,
@Nome varchar(30) OUTPUT,
@data_nascimento date OUTPUT,
@Telefone int OUTPUT,
@Endereço varchar(30) OUTPUT,
@cod_postal varchar(30) OUTPUT,
@Mensalidade money OUTPUT,
@Estado		varchar(30) OUTPUT
as
select @Nome=P.Nome, @data_nascimento=P.data_nascimento, @Telefone=P.Telefone, @Endereço=P.Endereço, @cod_postal=P.Cod_postal,
		@Mensalidade=M.Valor, @Estado=E.Estado
from Pessoa As P JOIN Cliente AS C ON P.NIF = C.NIF 
		JOIN PremiumCLiente As PC On C.NIF=PC.NIF
		JOIN Mensalidade as M on M.id_mensalidade=PC.id_mensalidade JOIN Estado as E on E.id_estado=M.id_estado
where P.NIF = @pesquisa


--Pesquisar Funcionario
Go
Create procedure pesquisaFuncionario
@pesquisa int,
@Nome varchar(30) OUTPUT,
@data_nascimento date OUTPUT,
@Telefone int OUTPUT,
@Endereço varchar(30) OUTPUT,
@cod_postal varchar(30) OUTPUT,
@comissao int OUTPUT,
@Salario money OUTPUT,
@Loja	varchar(30) OUTPUT,
@vendas1	int OUTPUT,
@vendas2 money OUTPUT
as
select @Nome=P.Nome, @data_nascimento=P.data_nascimento, @Telefone=P.Telefone, @Endereço=P.Endereço, @cod_postal=P.Cod_postal,
		@comissao=F.comissao, @Salario=F.Salario, @Loja = L.Nome, @vendas1 = count(V.NIF_Funcionario), @vendas2=sum(D.preço)
from Pessoa As P JOIN Funcionario AS F ON P.NIF = F.NIF JOIN Loja As L On L.ID_Loja = F.ID_Loja JOIN Venda As V ON F.NIF = V.NIF_Funcionario JOIN Discos As D ON V.id_disco=D.id_disco 
where P.NIF = @pesquisa
group by P.Nome,P.data_nascimento,P.Telefone, P.Endereço, P.Cod_postal,
		F.comissao, F.Salario,L.Nome


--Pesquisar Clientes Standard
Go
Create procedure pesquisaClientesSt
@pesquisa1 int,
@Nome1 varchar(30) OUTPUT,
@data_nascimento1 date OUTPUT,
@Telefone1 int OUTPUT,
@Endereço1 varchar(30) OUTPUT,
@cod_postal1 varchar(30) OUTPUT

as
select @Nome1=P.Nome, @data_nascimento1=P.data_nascimento, @Telefone1=P.Telefone, @Endereço1=P.Endereço, @cod_postal1=P.Cod_postal
from Pessoa As P JOIN Cliente AS C ON P.NIF = C.NIF 
where P.NIF = @pesquisa1


-- pesquisar loja
GO
Create Procedure pesquisarLoja
	@Nome		varchar(30),
	@id_loja	int OUTPUT

AS
	SELECT @id_loja = L.ID_Loja from Loja As L WHERE @Nome = L.Nome

-- Pesquisar por Disco
Go
Create procedure pesquisaDiscos
@pesquisa int,
@preço money OUTPUT,
@titulo varchar(30) OUTPUT,
@Ano int OUTPUT,
@NomeArtista varchar(30) OUTPUT,
@Genero varchar(30) OUTPUT
as
select @preço=preço, @titulo=titulo,@Ano=Ano, @NomeARtista=A.Nome, @Genero=G.Nome
from Discos As D JOIN Artista AS A ON D.id_artista=A.id_artista JOIN Genero As G ON D.id_genero=G.id_genero
where id_disco = @pesquisa


--pesquisar genero
GO
create procedure pesquisarGenero
@genero varchar(30),
@id_genero int OUTPUT
as
select @id_genero=id_genero from Genero as G
Where @genero=G.Nome


--pesquisar todos genero
GO
create procedure getAllGenero
as
select Nome from Genero as G

 
--pesquisar tipo disco
GO
create procedure pesquisartipo
@tipo varchar(30),
@id_tipo int OUTPUT
as
select @id_tipo=id_tipo from TipoDiscos as T
Where @tipo =T.Nome


-- inserir Artista
GO
CREATE PROCEDURE InserirArtista
       @Nome						   VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON 
	INSERT INTO Artista(Nome) Values (@Nome)

END



--pesqusiar Artista
GO
Create procedure pesquisarArtista
@nomeArtista varchar(30),
@id_artista int OUTPUT
as
select @id_artista=id_artista from Artista As A
where @nomeArtista = A.Nome


--inserir Funcionário
GO 
CREATE PROCEDURE InserirFuncionario
	@NIFF			int,
	@Nome			varchar(30),
	@Sexo			char(1),
	@Addr			varchar(60),
	@CP				varchar(8),
	@Tele			int,
	@Data			date,
	@Wage			Money,
	@Loja			varchar(30),
	@comissao		int
AS
BEGIN
	declare @id_loja int
	exec pesquisarLoja @Loja, @id_loja OUTPUT

	INSERT INTO Pessoa (
		NIF,
		Nome,
		Sexo,
		Endereço,
		Cod_postal,
		Telefone,
		data_nascimento) VALUES(

			@NIFF,
			@Nome,
			@Sexo,
			@Addr,
			@CP,
			@Tele,
			@Data)

		INSERT INTO Funcionario(
			NIF,
			Salario,
			ID_Loja,
			Comissao) VALUES (
			@NIFF,
			@Wage,
			@id_loja,
			@comissao)
END

--Inserir Disco
GO
CREATE PROCEDURE InserirDisco
       @id_disco	                   INT, 
       @titulo						   VARCHAR(30), 
       @preço						   money , 
       @artista                        VARCHAR(30), 
       @ano                            int, 
       @unidades	                   int,
	   @genero						   varchar(30),
	   @tipo						   varchar(30)              
AS 
BEGIN 
    
	 declare @id_art int
	 SET @id_art = SCOPE_IDENTITY()
	 exec pesquisarArtista @artista, @id_art
	 if @id_art is null
		begin
			exec InserirArtista @artista
			exec pesquisarArtista @artista, @id_art OUTPUT
		end

	 declare @id_gen int
	 --SET @id_gen = SCOPE_IDENTITY()
	 exec pesquisarGenero @genero, @id_gen OUTPUT

	 declare @id_tipo int
	 --SET @id_tipo = SCOPE_IDENTITY()
	 exec pesquisartipo @tipo, @id_tipo OUTPUT

	 INSERT INTO Discos
          ( 
            id_disco                   ,
            titulo                     ,
            preço                      ,
            Ano                        ,
			stock						,
			id_artista					,
			id_genero					,
			id_tipo						

          ) 
     VALUES 
          ( 
            @id_disco                  ,
            @titulo                    ,
            @preço                     ,
            @ano                       ,
            @unidades                  	,
			@id_art						,
			@id_gen					,
			@id_tipo		   
          ) 

END 


-- inserir cliente standard

GO 
CREATE PROCEDURE InserirClienteSt
	@NIFF			int,
	@Nome			varchar(30),
	@Sexo			char(1),
	@Addr			varchar(60),
	@CP				varchar(8),
	@Tele			int,
	@Data			date,
	@Loja			varchar(30)
AS
BEGIN
	declare @id_loja int
	exec pesquisarLoja @Loja, @id_loja OUTPUT

	INSERT INTO Pessoa (
		NIF,
		Nome,
		Sexo,
		Endereço,
		Cod_postal,
		Telefone,
		data_nascimento) VALUES(

			@NIFF,
			@Nome,
			@Sexo,
			@Addr,
			@CP,
			@Tele,
			@Data)

		INSERT INTO Cliente(
			NIF,
			ID_Loja
			) VALUES (
			@NIFF,
			@id_loja
		)

END

-- inserir cliente premium

GO 
CREATE PROCEDURE InserirClientePr
	@NIFF			int,
	@Nome			varchar(30),
	@Sexo			char(1),
	@Addr			varchar(60),
	@CP				varchar(8),
	@Tele			int,
	@Data			date,
	@Loja			varchar(30),
	@mensalidade	int
AS
BEGIN
	declare @id_loja int
	exec pesquisarLoja @Loja, @id_loja OUTPUT
	
	INSERT INTO Pessoa (
		NIF,
		Nome,
		Sexo,
		Endereço,
		Cod_postal,
		Telefone,
		data_nascimento) VALUES(

			@NIFF,
			@Nome,
			@Sexo,
			@Addr,
			@CP,
			@Tele,
			@Data)

		INSERT INTO PremiumCliente(
			NIF
			) VALUES (
			@NIFF
		
			
		)

		INSERT INTO Cliente(
			NIF,
			ID_Loja
			) VALUES (
			@NIFF,
			@id_loja
		)


END


--historico_vendas

GO
Create Procedure historico_vendas
	@pesquisaID int,
	@Data		date OUTPUT,
	@Hora		time OUTPUT,
	@titulo		varchar(30) OUTPUT

AS
SELECT @Data = V.Data, @Hora =V.Hora, @titulo=D.titulo from Venda As V JOIN Discos As D ON V.id_disco=D.id_disco
WHERE V.id_disco=@pesquisaID



--validar nif cliente
Create procedure ClientePRExists
@Nif_Cliente int
AS 
Select @Nif_Cliente=C.NIF From Cliente As C JOIN PremiumCliente AS PC ON C.NIF = PC.NIF
where PC.NIF=@Nif_Cliente 


---registar Vendas
GO
Create procedure registarVenda
	--@id_venda int,
	@Data	date,
	@Hora	time,
	@id_loja  int,
	@NIF_Funcionario int,
	@id_disco int,
	@Nif_cliente int

AS
BEGIN
	
	INSERT INTO Venda (--id_venda,
					   Data,
					   Hora,
					   id_loja,
					   NIF_Funcionario,
					   id_disco, 
					   Nif_cliente
					   )
	VALUES (--@id_venda,
			@Data,
			@Hora,
			@id_loja,
			@NIF_Funcionario,
			@id_disco,
			@Nif_cliente)
	END

--- Encomendas

GO
create procedure encomendas
@id_disco int
as
	select * from getDadosEncomendasBYID(@id_disco)

---vendas

GO
create procedure getVendas
@id_disco int
as
	select * from getDadosVendasByIDDisco(@id_disco)





-- pesquisar tipo encomenda
GO
Create Procedure pesquisarTipoEncomenda
	@TipoEncomenda	varchar(30),
	@id_tipo	int OUTPUT

AS
	SELECT @id_tipo = T.id_tipoEncomenda from TipoEncomenda As T WHERE @TipoEncomenda = T.TipoEncomenda



-- pesquisar tipo pagamento
GO
Create Procedure pesquisarTipoPagamento
	@metodo	varchar(30),
	@id_pagamento	int OUTPUT

AS
	SELECT @id_pagamento = P.id_pagamento from Pagamento As P WHERE @metodo = P.metodo

-- pesquisar editora
GO
Create Procedure pesquisarEditora
	@Nome	varchar(30),
	@id_edito	int OUTPUT

AS
	SELECT @id_edito = E.id_editora from Editora As E WHERE @Nome = E.Nome

-- inserir id no discos_encomenda
Go
create procedure getIdDiscos_encomenda
@id_disco int,
@id_encomenda int OUTPUT
as
select @id_encomenda = E.id_encomenda+1 FROM Encomenda As E JOIN Discos_encomenda AS DE ON E.id_encomenda=DE.id_encomenda
where @id_disco = DE.id_disco


-- nova encomenda

GO 
CREATE PROCEDURE InserirEncomenda

	@tipoEncomenda		varchar(30),
	@pagamento		    varchar(30),
	@id_disco			int,
	@Data_expedicao		date,
	@editora			varchar(30)
	
AS
BEGIN
	declare @id_tipoEncomenda int
	exec pesquisarTipoEncomenda @tipoEncomenda, @id_tipoEncomenda OUTPUT

	declare @id_pagamento int
	exec pesquisarTipoPagamento @pagamento, @id_pagamento OUTPUT

	declare @id_editora int
	exec pesquisarEditora @editora, @id_editora OUTPUT
	
	declare @id_enc int
	exec getIdDiscos_encomenda @id_disco, @id_enc OUTPUT

	INSERT INTO Encomenda(
		id_tipoEncomenda,
		id_pagamento) 
		
		VALUES(
			@id_tipoEncomenda,
			@id_pagamento)

		INSERT INTO Discos_encomenda(
		id_disco,
			id_encomenda,
			Data_expedicao,
			id_Editora
			) VALUES (
			@id_disco,
			@id_enc,
			@Data_expedicao,
			@id_editora
		)

END

-- promoçao do premium
go
Create Procedure promoçaoDePremium
	@NIFF		int,
	@discount	int output
as

select @discount = P.desconto FROM Promocao As P 
JOIN PremiumCLiente As PC ON P.id_promocao = PC.id_promocao
WHERE @NIFF = PC.NIF