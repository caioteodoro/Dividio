import UIKit

var linguica = 30.75;
var carne = 50.15;
var pao = 17.99;
var abobrinha = 12.34;
var cerveja = 33.10;
var refrigerante = 21.70;

var isabellapagou = 148.04;
var leopagou = 17.99;

var isabella: Double = 0;
var leo: Double = 0;
var igor: Double = 0;
var gabi: Double = 0;
var kadine: Double = 0;
var caio: Double = 0;
var rafaela: Double = 0;

var participantes = [isabella, leo, kadine, gabi, igor, caio]
var teste = [["Isabela",0.0,true],["Leo",0.0,false]]
var consumocarne = [true, true, false, false, true, true];
var consumorefrigerante = [true, true, true, true, true, true];
participantes.insert(rafaela, at: 0)

var totalpago = isabellapagou + leopagou

var comeramcarne: Double = 0;
var comeramrefri: Double = 0;

for i in 0..<consumocarne.count {
    if consumocarne[i] == true {
        comeramcarne+=1
    }
}

var pagarcarne = carne / comeramcarne;

for i in 0..<consumocarne.count {
    if consumocarne[i] == true {
        participantes[i] += pagarcarne;
    }
}

//refri

for i in 0..<consumorefrigerante.count {
    if consumorefrigerante[i] == true {
        comeramrefri+=1
    }
}

var pagarrefri = refrigerante / comeramrefri;

for i in 0..<consumorefrigerante.count {
    if consumorefrigerante[i] == true {
        participantes[i] += pagarrefri;
    }
}

//func generica

func Dividir(item: Double) {
    let item: Double = 0;
    isabella = item;
}

isabella = participantes[0]

//Com classes

class Participante {
    var nome: String;
    init() {
        nome = "Caio";
    }
}

class Item {
    var nome: String;
    var valor: Double;
    init() {
        nome = "Carne";
        valor = 10.00;
    }
}

var todos = [Item]();
var keepAdding = true;
while keepAdding == true {
    todos.append(Item())
    keepAdding = false;
}



