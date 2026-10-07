class UserException inherits Exception {}

class Balde {
  const pesoMaximo = 500
  const pesoUnitario
  var unidades = 0

  method agregarUnidades(cantidad) {
    self.validarAgregar(cantidad)
    unidades += cantidad

  }

  method validarAgregar(cantidad) {
    const pesoPotencial = self.pesoAlmacenado() + cantidad * pesoUnitario
    if (pesoPotencial > pesoMaximo) {
      const unidadesDisponibles = ((pesoMaximo - self.pesoAlmacenado()) / pesoUnitario).truncate(0)
      throw new UserException(message="Podés agregar solamente hasta " + unidadesDisponibles.toString() +
                                      " unidades más. Las " + cantidad.toString() +
                                      " unidades que querés agregar exceden el peso máximo de " + pesoMaximo.toString() + ".")
    }
  }

  method sacarUnidades(cantidad) {
    self.validarSacar(cantidad)
    unidades -= cantidad
  }

  method validarSacar(cantidad) {
    if (cantidad > unidades) {
      throw new UserException(message="Solamente puede sacar hasta "+ unidades.toString() + " unidades. Las " + cantidad.toString() +
                                      " unidades exceden el límite.")
    }
  }

  method pesoAlmacenado() {
    return pesoUnitario * unidades
  }
}

object juan {
  var balde = new Balde(pesoUnitario = 40)

  method pesoTotal() {
    return 70 + balde.pesoAlmacenado()
  }

  method cambiarPor(otroBalde) {
    balde = otroBalde
  }
}

object manu {
  const balde = new Balde(pesoUnitario = 30)

  method pesoTotal() {
    return 70 + balde.pesoAlmacenado()
  }

  method agregarAutitosASuBalde(cantidad) {
    balde.agregarUnidades(cantidad)
  }
}

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
