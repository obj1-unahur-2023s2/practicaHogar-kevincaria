import habitaciones.*

class Persona{
    var property edad
    var habilidadesDeCocina = false
    var habitacionActual 

    method habilidadesDeCocina() = habilidadesDeCocina

    method habitacionActual() = habitacionActual

    method cambiarDeHabitacion(unaHabitacion){
        if(not unaHabitacion.puedeEntrar(self)){
            throw new Exception(message="La persona no puede entrar en la habitacion")
        }
        habitacionActual.salir(self)
        habitacionActual = unaHabitacion
        unaHabitacion.entrar(self)
    }

    method aprenderHabilidadesDeCocina(){
        habilidadesDeCocina = true
    }

    method puntosDeConfortQueDa(unaHabitacion) = unaHabitacion.nivelDeConfort(self)

    method estaAGusto(casa, integrantes){
        return casa.any({habitacion => habitacion.puedeEntrar(self)}) and self.estaAGustoParticular(casa, integrantes)
    }

    method estaAGustoParticular(casa, integrantes)
}

class Obsesivo inherits Persona{
    override method estaAGustoParticular(casa, integrantes){
        return casa.all({habitacion => habitacion.ocupantes().size() <= 2})
    }
}

class Goloso inherits Persona{
    override method estaAGustoParticular(casa, integrantes){
        return integrantes.any({integrante => integrante.habilidadesDeCocina()})
    }
}

class Sencillo inherits Persona{
    override method estaAGustoParticular(casa, integrantes){
        return casa.size() > integrantes.size()
    }
}

class Familia{
    const integrantes = []
    const casa = []

    method habitacionesOcupadas() = casa.filter({habitacion => habitacion.estaOcupada()})

    method responsablesDeLaCasa() = casa.max({integrante => integrante.edad()})

    method nivelDeConfortPromedio() = self.nivelDeConfortAcumulado() / self.cantidadDeIntegrantes()

    method cantidadDeIntegrantes(){
        if(integrantes.isEmpty()){
            throw new Exception(message="No hay integrantes en la familia")
        }
        return integrantes.size() 
    }

    method nivelDeConfortAcumulado() = integrantes.sum({ integrante => self.nivelDeConfortAcumuladoPorIntegrante(integrante)})

    method nivelDeConfortAcumuladoPorIntegrante(unIntegrante) = casa.sum({habitacion => habitacion.nivelDeConfort(unIntegrante)})

    method estaAGusto(){
        return self.nivelDeConfortPromedio() > 40 and integrantes.all({integrante => integrante.estaAGusto(casa, integrantes)})
    }
}