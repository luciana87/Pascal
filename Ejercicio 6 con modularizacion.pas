program microprocesadores;
type

	str20 = string[20];
	marcas = record
		marcaActual: str20;
		marcaMax1: str20;
		marcaMax2: str20;
	end;
	maximos = record
		max1: integer;
		max2: integer;
	end;
	procesador = record //Carga informacion de cada procesador.
		marca: str20;
		linea: str20;
		cores: integer;
		ghz: integer; //velocidad de reloj en Ghz.
		nm: integer; // Tamaño transistores medidos en nanómetros. 
	end;
procedure leerProcesador (var m: procesador);
	begin
		writeln ('Ingrese marca del procesador');
		readln (m.marca);
		writeln ('Ingrese linea del procesador');
		readln (m.linea);
		writeln ('Ingrese cantidad de cores del procesador');
		readln (m.cores);
		writeln ('Ingrese velocidad del reloj del procesador');
		readln (m.ghz);
		writeln ('Ingrese ingrese tamaño transistores del procesador en nm');
		readln (m.nm);
	end;
procedure procesador2cores (micPro: procesador);
	begin
		if (micPro.cores > 2) and (micPro.nm <= 22) then
			begin
				writeln ('La marca y linea del procesador con 2 o mas cores con transistores de a lo sumo 22nm es ', micPro.marca,' ', micPro.linea);
			end;
	end;
procedure marcasTransist14nm (micP: procesador;var max: maximos; var mar: marcas; var cant14: integer);
	begin
		if (micP.marca = mar.marcaActual) then
			begin
				if (micP.nm = 14) then
					cant14 := cant14 + 1;
			end
		else
			begin
				if(cant14 > max.max1) then
					begin
						max.max2 := max.max1;
						mar.marcaMax2 := mar.marcaMax1;
						max.max1 := cant14;
						mar.marcaMax1 := mar.marcaActual;
					end
				else if (cant14 > max.max2) then
					begin
						max.max2 := cant14;
						mar.marcaMax2 := mar.marcaActual;
					end;
				mar.marcaActual := micP.marca;
			end;
	end;
procedure multicores (micP: procesador; var cantM: integer);
	begin
		if (micP.cores >= 1) then
			if (micP.marca = 'AMD') or (micP.marca = 'intel') then
				if (micP.ghz >= 2) then
					cantM:= cantM + 1;
	end;
var
	cantProc14nmActual:integer;
	max: maximos;
	mar: marcas;
	cantMulticore: integer; 
	micPro: procesador;
begin
	// inicializo las variables del programa
	mar.marcaMax1:= 'xxx';
	mar.marcaMax2:= 'xxx';
	cantMulticore:= 0;
	max.max1:= -1;
	max.max2:= -1;
	leerProcesador (micPro);
	mar.marcaActual := micPro.marca;
	cantProc14nmActual := 0; 
	
	// proceso los procesos
	while (micPro.cores <> 0) do
		begin
			procesador2cores (micPro); // Item 1
			marcasTransist14nm (micPro,max,mar,cantProc14nmActual); // Item 2
			multicores (micPro,cantMulticore); // Item 3
			leerProcesador (micPro);
		end;
end.
