import Foundation

public struct Mrowka {
  let MAX = 1e6
  public var swiat: Swiat
  public var polozenie: Character
  public var ilosc_wydzielanego_feromonu: Double
  var dlugosc_sciezek: [Int] = []
  var sciezka: String
  var syta = false

  init(_ swiat: Swiat, _ ilosc_wydzielanego_feromonu: Double) {
    self.swiat = swiat
    self.polozenie = swiat.dom
    self.ilosc_wydzielanego_feromonu = ilosc_wydzielanego_feromonu
    self.sciezka = String(swiat.dom)
  }

  private func obliczOdleglosc() {
    let polozenie = Int(polozenie.asciiValue! - Character("a").asciiValue!)
    let dom = Int(swiat.dom.asciiValue! - Character("a").asciiValue!)
    var dx: Int
    var dy: Int
    for i in 0..<swiat.punkty.count {
      if i == dom || i == polozenie || sciezka.contains(swiat.punkty[i].nazwa) {
        swiat.aux[i].stosunek = MAX
      } else {
        dx =
          swiat.punkty[
            polozenie
          ].x - swiat.punkty[i].x
        dy =
          swiat.punkty[
            polozenie
          ].y - swiat.punkty[i].y
        swiat.aux[i].stosunek = sqrt(Double(dx * dx + dy * dy))
      }
    }
  }

  private func sortujTablicePomocnicza() {
    for i in 0..<swiat.punkty.count {
      swiat.aux[i].stosunek = (swiat.punkty[i].ilosc_feromonu + 1) / swiat.aux[i].stosunek
    }
    swiat.aux.sort(by: { $0.stosunek >= $1.stosunek })
  }

  private func losuj() -> Int {
    return (Int.random(in: 0..<swiat.punkty_do_wyboru))
  }

  private func ruletka() -> Int {
    var pomocnicza = [Double](repeating: 0.0, count: swiat.punkty_do_wyboru)
    var suma = 0.0
    for i in 0..<swiat.punkty_do_wyboru {
      suma += swiat.aux[i].stosunek
    }
    for i in 0..<swiat.punkty_do_wyboru {
      pomocnicza[i] = swiat.aux[i].stosunek / suma
    }
    var i = 0
    let random = Double.random(in: 0.0..<1.0)
    suma = pomocnicza[i]
    while random > suma {
      i += 1
      suma += pomocnicza[i]
    }
    return i
  }

  public func wybierzPunkt() -> Int {
    for i in 0..<swiat.punkty.count {
      swiat.aux[i].nazwa = swiat.punkty[i].nazwa
    }
    obliczOdleglosc()
    sortujTablicePomocnicza()
    var wybor: Int
    var zly_wybor: Bool
    repeat {
      wybor = ruletka()
      zly_wybor = sciezka.contains(swiat.aux[wybor].nazwa)
    } while zly_wybor
    return wybor
  }

  func polejSciezke() {
    for Punkt in sciezka {
      if Punkt != swiat.dom {
        swiat.punkty[
          Int(
            Punkt
              .asciiValue! - Character("a").asciiValue!)
        ].ilosc_feromonu +=
          ilosc_wydzielanego_feromonu
      }
    }
  }

  mutating public func dzialaj() {
    let i = wybierzPunkt()
    if swiat.aux[i].nazwa != swiat.pokarm {
      polozenie = swiat.aux[i].nazwa
      sciezka += String(polozenie)
    } else {
      syta = true
      polozenie = swiat.pokarm
      sciezka += String(polozenie)
      polejSciezke()
      dlugosc_sciezek.append(sciezka.count - 1)
      sciezka = "a"
    }
  }
}
