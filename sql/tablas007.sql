
CREATE TABLE tbClientesPotenciales
(
  idClientePotencial "guid" 
 ,cCodigo 		     varchar (20)	 
 ,cRazonSocial       varchar(1500)
 ,cTelefono          varchar(200)
 ,cDomicilio	     varchar(3000)
 ,cMail			     varchar(200)
 ,txNotas            varchar(3000)
 ,fAlta			     date
 ,bVisible           smallint   DEFAULT 1 
);