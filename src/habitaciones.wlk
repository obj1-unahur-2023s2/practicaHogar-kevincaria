import personas.*

class Habitacion{
    const ocupantes = []

    method nivelDeConfort(unaPersona) = 10

    method puedeEntrar(unaPersona) = true

    method entrar(unaPersona){
        ocupantes.add(unaPersona)
    }

    method salir(unaPersona){
        ocupantes.remove(unaPersona)
    }

    method ocupantes() = ocupantes

    method estaOcupada() = not ocupantes.isEmpty()
}

class Banio inherits Habitacion{

    override method nivelDeConfort(unaPersona){
        var confortAdicional = if(unaPersona.edad()<=4){2}else{4}
        return super() + confortAdicional
    }

    override method puedeEntrar(unaPersona){
        return ocupantes.any({ocupante => ocupante.edad()<=4})
    }
}

class Dormitorio inherits Habitacion{
    const residentes = []

    override method nivelDeConfort(unaPersona){
        var confortAdicional = if(residentes.contains(unaPersona)){10/residentes.size()}else{0}
        return super() + confortAdicional
    }

    override method puedeEntrar(unaPersona){
        return residentes.contains(unaPersona) or residentes.all({residente => ocupantes.contains(residente)})
    }
}

class Cocina inherits Habitacion{
    var property m2

    override method nivelDeConfort(unaPersona){
        return super() + self.calcularValorPorcentaje(porcentajeConfort.unidades(),m2)
    }

    method calcularValorPorcentaje(porcentaje, valorTotal) {
        return (porcentaje/100) * valorTotal
    }

    override method puedeEntrar(unaPersona){
        return (not unaPersona.habilidadesDeCocina()) or ocupantes.all({ocupante => not ocupante.habilidadesDeCocina()})
    }

}

object porcentajeConfort{

    method unidades() = 10
}