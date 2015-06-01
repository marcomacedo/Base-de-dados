-- get dados encomendas
GO
Create Function historico_encomendas() returns TABLE

as
	return (SELECT * FROM Encomenda);



GO
Create Function getDadosEncomendasBYID(@id_disco int) returns TABLE
	
as
	return (SELECT DE.Data_expedicao, Ed.Nome, TE.TipoEncomenda, D.titulo FROM Encomenda As E 
				JOIN Discos_encomenda As DE On E.id_encomenda = DE.id_encomenda 
				JOIN Editora As Ed On DE.id_Editora = Ed.id_editora
				JOIN TipoEncomenda As TE On E.id_tipoEncomenda = TE.id_tipoEncomenda
				JOIN Discos As D On D.id_disco = DE.id_disco
				JOIN Cliente As C On C.NIF = E.NIF_Cliente
				Join Pagamento As Pg On E.id_pagamento = Pg.id_pagamento
				where DE.id_disco=@id_disco)
GO



-- get dados vendas

Create Function getDadosVendasByIDDisco(@id_disco int) returns TABLE

as
	return (SELECT V.Data, V.Hora, D.titulo from Venda As V 
			JOIN Discos As D ON V.id_disco=D.id_disco
			where V.id_disco =@id_disco)

GO





