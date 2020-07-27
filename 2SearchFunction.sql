create or replace function busquedaTabla(cadena varchar)
	returns table(nombre varchar)
	language plpgsql
as
$$
begin
	return query
	select alumno.nombre
	from alumno
	where busqueda(alumno.nombre,cadena)>=0.3;
end;
$$

select *
from busquedaTabla('carlitos')