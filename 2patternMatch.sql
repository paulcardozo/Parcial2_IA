create or replace function busqueda(cadena varchar)
	returns table(nombrecia char,
	nombrecontacto char,
	direccioncli char)
	language plpgsql
as
$$
begin
	RETURN QUERY
	select cl.nombrecia,cl.nombrecontacto,cl.direccioncli
	from clientes as cl
	where upper(cl.nombrecia) like concat('%',upper(cadena),'%')
	or upper(cl.nombrecontacto) like concat('%',upper(cadena),'%')
	or upper(cl.direccioncli) like concat('%',upper(cadena),'%');
end;
$$