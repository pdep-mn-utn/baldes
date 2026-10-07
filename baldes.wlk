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
      throw new UserException(message="No se pueden agregar " + cantidad +
                                      " unidades, ya que superaría el peso máximo")
    }
  }

  method sacarUnidades(cantidad) {
    self.validarSacar(cantidad)
    unidades -= cantidad
  }

  method validarSacar(cantidad) {
    if (cantidad > unidades) {
      throw new UserException(message="No es posible sacar " + cantidad +
                                      "unidades. El balde posee menos.")
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

  method cambiarBalde() {
    balde = new Balde(pesoUnitario = 40)
    balde.agregarUnidades(4)
  }

  method cambiarBaldePorUnString() {
    balde = "soy un balde"
    // la instancia de Balde es
    // eliminada por el Garbage Collector
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
