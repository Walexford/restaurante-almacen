Algoritmo SistemaGestionAlmacenUnificado
	// 1. DECLARACIÓN DE ARREGLOS Y VARIABLES
	Definir nombres, categorias, unidades Como Cadena
	Definir cantidades Como Real
	Definir caducidades Como Entero
	Dimensionar nombres(100), categorias(100), cantidades(100), unidades(100), caducidades(100)
	Definir histUsuario, histProducto Como Cadena
	Definir histCantidad Como Real
	Dimensionar histUsuario(100), histProducto(100), histCantidad(100)
	Definir totalProd, totalHist, opcion, limiteMax, fechaHoy, intentos, i, indiceEnc, contStock, contCad Como Entero
	Definir cantIng, cadIng, stockAct, espacioDisp Como Real
	Definir usuario, clave, nomIng, catIng, uniIng, confirmar Como Cadena
	Definir acceso Como Lógico
	limiteMax <- 250
	fechaHoy <- FechaActual()
	acceso <- Falso
	intentos <- 3
	// 2. INICIO DE SESIÓN
	Mientras intentos>0 Y  NO acceso Hacer
		Limpiar Pantalla
		Escribir '=== ACCESO AL ALMACÉN (admin / 1234) ==='
		Escribir 'Usuario: 'Sin Saltar
		Leer usuario
		Escribir 'Clave: 'Sin Saltar
		Leer clave
		Esperar 1 Segundos
		Si (usuario='admin' Y clave='1234') O (usuario='almacen' Y clave='almacen2026') Entonces
			acceso <- Verdadero
		SiNo
			intentos <- intentos-1
			Escribir 'Datos incorrectos. Intentos: ', intentos
			Esperar 1 Segundos
		FinSi
	FinMientras
	// 3. FLUJO PRINCIPAL DEL SISTEMA
	Si acceso Entonces
		// Carga de datos iniciales (Caducidad 20 Dic 2026)
		totalProd <- 6
		totalHist <- 0
		nombres[1] <- 'Carne de Res'
		categorias[1] <- 'Carne'
		cantidades[1] <- 12
		unidades[1] <- 'kg'
		caducidades[1] <- 20261220
		nombres[2] <- 'Pechuga de Pollo'
		categorias[2] <- 'Carne'
		cantidades[2] <- 4
		unidades[2] <- 'kg'
		caducidades[2] <- 20261220
		nombres[3] <- 'Lechuga'
		categorias[3] <- 'Verdura'
		cantidades[3] <- 2
		unidades[3] <- 'unidades'
		caducidades[3] <- 20261118
		nombres[4] <- 'Tomate'
		categorias[4] <- 'Verdura'
		cantidades[4] <- 8
		unidades[4] <- 'kg'
		caducidades[4] <- 20261220
		nombres[5] <- 'Crema de Aji'
		categorias[5] <- 'Crema'
		cantidades[5] <- 3
		unidades[5] <- 'frascos'
		caducidades[5] <- 20261220
		nombres[6] <- 'Mayonesa Casera'
		categorias[6] <- 'Crema'
		cantidades[6] <- 1
		unidades[6] <- 'frascos'
		caducidades[6] <- 20261220
		Repetir
			Limpiar Pantalla
			contStock <- 0
			contCad <- 0
			// Evaluación de Alertas Persistentes
			Escribir '=== ALERTAS ACTIVAS (Fecha: ', fechaHoy, ') ==='
			Para i<-1 Hasta totalProd Hacer
				Si cantidades[i]<5 Entonces
					contStock <- contStock+1
					Escribir '[STOCK BAJO] ', nombres[i], ': ', cantidades[i], ' ', unidades[i]
				FinSi
				Si caducidades[i]<=(fechaHoy+3) Entonces
					contCad <- contCad+1
					Escribir '[CADUCIDAD] ', nombres[i], ' vence el ', caducidades[i]
				FinSi
			FinPara
			Si contStock=0 Y contCad=0 Entonces
				Escribir '[OK] Sin alertas críticas.'
			FinSi
			// Menú Principal
			Escribir ''
			Escribir '--- MENÚ ALMACÉN (', usuario, ') ---'
			Escribir '1. Ver Inventario General'
			Escribir '2. Añadir / Reponer Producto'
			Escribir '3. Ver Historial de Ingresos'
			Escribir '4. Reiniciar Datos de Prueba'
			Escribir '5. Salir'
			Escribir 'Opción: 'Sin Saltar
			Leer opcion
			Según opcion Hacer
				1:
					Limpiar Pantalla // VER INVENTARIO
					Escribir '=== INVENTARIO GENERAL ==='
					Para i<-1 Hasta totalProd Hacer
						Escribir i, '. ', nombres[i], ' (', categorias[i], ') - ', cantidades[i], ' ', unidades[i], ' | Cad: ', caducidades[i]
					FinPara
					Esperar Tecla
				2:
					Limpiar Pantalla // AÑADIR O REPONER PRODUCTO CON LÍMITE
					Escribir '=== AÑADIR PRODUCTO (Máx: ', limiteMax, ') ==='
					Escribir 'Nombre: 'Sin Saltar
					Leer nomIng
					indiceEnc <- 0
					Para i<-1 Hasta totalProd Hacer
						Si Minusculas(nombres[i])=Minusculas(nomIng) Entonces
							indiceEnc <- i
						FinSi
					FinPara
					Si indiceEnc>0 Entonces
						stockAct <- cantidades[indiceEnc]
					SiNo
						stockAct <- 0
					FinSi
					espacioDisp <- limiteMax-stockAct
					Si espacioDisp<=0 Entonces
						Escribir 'Límite máximo alcanzado para este producto.'
					SiNo
						Repetir
							Escribir 'Cantidad (1 - ', espacioDisp, '): 'Sin Saltar
							Leer cantIng
						Hasta Que cantIng>0 Y cantIng<=espacioDisp
						Si indiceEnc>0 Entonces
							cantidades[indiceEnc] <- cantidades[indiceEnc]+cantIng
							uniIng <- unidades[indiceEnc]
						SiNo
							totalProd <- totalProd+1
							Escribir 'Categoría: 'Sin Saltar
							Leer catIng
							Escribir 'Unidad (kg/unidades/frascos): 'Sin Saltar
							Leer uniIng
							Escribir 'Caducidad AAAAMMDD (0 = 20261220): 'Sin Saltar
							Leer cadIng
							Si cadIng<=0 Entonces
								cadIng <- 20261220
							FinSi
							nombres[totalProd] <- nomIng
							categorias[totalProd] <- catIng
							cantidades[totalProd] <- cantIng
							unidades[totalProd] <- uniIng
							caducidades[totalProd] <- cadIng
						FinSi
						// Registrar en Historial
						totalHist <- totalHist+1
						histUsuario[totalHist] <- usuario
						histProducto[totalHist] <- nomIng
						histCantidad[totalHist] <- cantIng
						Escribir 'Producto guardado con éxito.'
					FinSi
					Esperar 1 Segundos
				3:
					Limpiar Pantalla // VER HISTORIAL
					Escribir '=== HISTORIAL DE INGRESOS ==='
					Si totalHist=0 Entonces
						Escribir 'Sin registros aún.'
					SiNo
						Para i<-1 Hasta totalHist Hacer
							Escribir i, '. [', histUsuario[i], '] +', histCantidad[i], ' de ', histProducto[i]
						FinPara
					FinSi
					Esperar Tecla
				4:
					Escribir '¿Borrar pruebas y reiniciar? (s/n): 'Sin Saltar // REINICIAR DATOS DE PRUEBA
					Leer confirmar
					Si Minusculas(confirmar)='s' Entonces
						totalProd <- 6
						totalHist <- 0
						cantidades[1] <- 12
						cantidades[2] <- 4
						cantidades[3] <- 2
						cantidades[4] <- 8
						cantidades[5] <- 3
						cantidades[6] <- 1
						Escribir 'Sistema reiniciado.'
						Esperar 1 Segundos
					FinSi
				5:
					Escribir 'Cerrando sistema...' // SALIR
					Esperar 1 Segundos
				De Otro Modo:
					Escribir 'Opción inválida.'
					Esperar 1 Segundos
			FinSegún
		Hasta Que opcion=5
	SiNo
		Escribir 'Acceso bloqueado.'
	FinSi
FinAlgoritmo
