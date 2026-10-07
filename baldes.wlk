class Balde {
  const pesoMaximo = 500
  const pesoUnitario
  var unidades = 0
  
  method agregarUnidades(cantidad) {
    self.validarPositividad(cantidad)
    self.validarIncremento(cantidad)
    unidades += cantidad
  }
  
  method validarPositividad(cantidad) {
    if (cantidad < 0) {
      throw new DomainException(
        message = "La cantidad que ingresaste debe ser positiva."
      )
    }
  }
  
  method validarIncremento(cantidad) {
    const pesoPotencial = self.pesoTotal() + (cantidad * pesoUnitario)
    if (pesoPotencial > pesoMaximo) {
      const unidadesDisponibles =
       ((pesoMaximo - self.pesoTotal()) / pesoUnitario).truncate(0)
      throw new DomainException(
        message = "Podés agregar solamente hasta " + unidadesDisponibles.toString() + " unidades más. Las " + cantidad.toString() + " unidades que querés agregar exceden el peso máximo de " + pesoMaximo.toString() + "."
      )
    }
  }
  
  method sacarUnidades(cantidad) {
    self.validarPositividad(cantidad)
    self.validarDecremento(cantidad)
    unidades -= cantidad
  }
  
  method validarDecremento(cantidad) {
    if (cantidad > unidades) {
      throw new DomainException(
        message = "Solamente puede sacar hasta " + unidades.toString() + " unidades. Las " + cantidad.toString() + " unidades exceden el límite."
      )
    }
  }
  
  method pesoTotal() = pesoUnitario * unidades
}

object termo {
  var lleno = false
  
  method llenar() {
    lleno = true
  }
  
  method vaciar() {
    lleno = false
  }
  
  method pesoTotal() = if (lleno) 1100 else 100
}

class Persona {
  const pesoPropio
  const inventario = []
  
  method pesoTotal() = pesoPropio + inventario.sum({ cosa => cosa.pesoTotal() })
  
  method agregarObjeto(cosa) {
    inventario.add(cosa)
  }
  
  method quitarObjeto(cosa) {
    inventario.remove(cosa)
  }
}

const juan = new Persona(
  pesoPropio = 70000,
  inventario = [new Balde(pesoUnitario = 40)]
)

const manu = new Persona(
  pesoPropio = 70000,
  inventario = [new Balde(pesoUnitario = 30)]
)

// Podríamos crear 100 baldes con:
// 100.times { _i => new Balde() }
// ...pero perdemos inmediatamente la referencia
// a ellos.
// ¿Cómo podemos hacer para generar baldes que nos
// permitan guardar otras cosas?
const baldeDeCuadernos = new Balde(
  pesoMaximo = 100,
  pesoUnitario = 10,
  unidades = 5
)

const baldeDeBotellas = new Balde(
  pesoUnitario = 15,
  unidades = 5,
  pesoMaximo = 200
)