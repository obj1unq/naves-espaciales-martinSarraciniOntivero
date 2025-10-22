class Nave{
	var property velocidad = 0
	method recibirAmenaza(){
		
	}
	/*method propulsar(velkmseg){ //2 do: cambiar usando min()
		if(not (velocidad + velkmseg> 300000)){
		velocidad += velkmseg
		}else{
			velocidad += (300000-velocidad)
		}
	}*/
	method propulsar(velkmseg){
		velocidad = 300000.min(velocidad + velkmseg)
	}
	method prepararParaViajar(){
	}
	method encontrarseConEnemigo(){
		self.propulsar(20000)
		self.recibirAmenaza()
	}

}


class NaveDeCarga inherits Nave {

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}
class NaveCargaRadiactiva inherits NaveDeCarga {
	var property sellado = false 
	override method recibirAmenaza(){
		velocidad = 0
	}
	method sellarAlVacio(){
		sellado = true
	}
	override method prepararParaViajar(){
		self.propulsar(15000)
		self.sellarAlVacio()
	}

}

class NaveDePasajeros inherits Nave{

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
	override method prepararParaViajar(){
		self.propulsar(15000)
	}

}

class NaveDeCombate inherits Nave{
	
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
	override method prepararParaViajar(){
		self.propulsar(15000)
		modo.mensaje(self)
	}

}

object viajar{
	method viaje(modoNave){
		modoNave.mensaje(self)
	}
}
object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
	method mensaje(nave){
		nave.emitirMensaje("saliendo en mision")
		nave.modo(ataque)
	}


}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}
	method mensaje(nave){
		nave.emitirMensaje("volviendo a la base")
	}

}
