import UIKit
// ITEM   VALOR CNSM PAGOU
// carne  R$9   3    charlie
// alface R$10  2    javi
// casa   R$15  3    caio

var carne = 3.0
var alface = 5.0
var casa = 5.0

var charlie = 9.0
var javi = 10.0
var caio = 15.0

var charliePaga = (carne + casa) - charlie
var javiPaga = (carne + alface + casa) - javi
var caioPaga = (carne + alface + casa) - caio

var recebem = [charliePaga, caioPaga]

for i in 0...recebem.count-1 {
    if javiPaga + recebem[i] >= 0 {
        print("javi recebe " + String(recebem[i] * -1) + " de xxxx")
        javiPaga += recebem[i]
        recebem[i] = 0
    }
}
