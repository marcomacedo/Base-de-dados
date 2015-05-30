--login
CREATE PROCEDURE CheckPassword
    @username VARCHAR(30),
    @password varchar(30)
AS
BEGIN

SET NOCOUNT ON

IF EXISTS(SELECT * FROM Admini WHERE username = @username AND passe = @password)
    SELECT 'true' AS UserExists
ELSE
    SELECT 'false' AS UserExists

END



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
Where @genero =G.Nome


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
       @Nome						   VARCHAR(30),
	   @id_artista						int OUT
AS
BEGIN
	SET NOCOUNT ON 
	INSERT INTO Artista(Nome) Values (@Nome)
	SET @id_artista = SCOPE_IDENTITY()
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
     SET NOCOUNT ON 
	 declare @id_art int;
	 exec pesquisarArtista @artista, @id_art
	 if @id_art is null
		begin
			exec InserirArtista @artista
			exec pesquisarArtista @artista, @id_art
		end

	 declare @id_gen int;
	 exec pesquisarGenero @tipo, @id_gen

	 declare @id_tipo int;
	 exec pesquisartipo @tipo, @id_tipo

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

