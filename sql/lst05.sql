INSERT INTO tcListadosGrupos
(idListadoGrupo, ListadoGrupo,bVisible)
VALUES
(4,'Clientes',1);


INSERT INTO tcListados
(idListado, NombreListado, refGrupo, refFormulario, RutaReporte, bVisible)
VALUES
(15,'Todos los clientes con cuit y monto de abono',4,1,'lstTodoCliAbono.lrf',1);
