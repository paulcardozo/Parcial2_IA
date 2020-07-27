create or replace function busqueda(cadena1 varchar,cadena2 varchar)
returns float
as
$$
declare
	beginSql varchar(100);
	longitud_cadena1 int;
	longitud_cadena2 int;
	contador int;
	contador2 int;
	contadorRes int;
	letra varchar(20);
	sql varchar(4000);
	sql2 varchar(4000);
	nombre varchar[];
	aux varchar;
	resultado float;
begin
	beginSql:='drop table nombre';
	execute beginSql;
	contador:=1;
	select char_length(cadena1) into longitud_cadena1;
	select char_length(cadena2) into longitud_cadena2;
	sql:='create table nombre (';
	loop 
		exit when contador>longitud_cadena1;
		letra:= concat(LEFT(cadena1,1),contador,' int,');
		cadena1:= RIGHT(cadena1,char_length(cadena1)-1);
		sql:=concat(sql,letra);
		contador:=contador+1;
	end loop;
	sql:= concat(LEFT(sql,char_length(sql)-1),')');
	execute sql;
	contador:=1;
	letra:='';
	nombre := ARRAY(SELECT COLUMN_NAME::varchar
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'nombre'
		ORDER BY ORDINAL_POSITION);
	contador2:=1;
	contadorRes:=0;
	loop
		exit when contador > longitud_cadena2;
		letra:= LEFT(cadena2,1);
		cadena2:=RIGHT(cadena2,char_length(cadena2)-1);
		contador:=contador+1;
		sql2:='insert into nombre(';
		loop
			exit when contador2 > array_length(nombre,1);
			aux:=nombre[contador2]::varchar;
			aux:=LEFT(aux,1);
			if aux=letra then
				sql2:=concat(sql2,nombre[contador2],') values(1)');
				execute sql2;
				contador2:=contador2+1;
				contadorRes:=contadorRes+1;
				exit;
			end if;
			contador2:=contador2+1;
		end loop;
	end loop;
	resultado:=contadorRes::float / longitud_cadena1::float;
	return resultado;
end;
$$
LANGUAGE plpgsql