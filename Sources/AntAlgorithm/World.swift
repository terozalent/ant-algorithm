public class Swiat {
  public var punkty: [Punkt]
  public var aux: [Auxil]
  public var dom: Character
  public var pokarm: Character
  public var punkty_do_wyboru: Int
  public var zanik_feromonu: Double
  let graf: [(Character, Int, Int)] = [
    ("a", 6, 1), ("b", 13, 1), ("c", 4, 3), ("d", 4, 5), ("e", 8, 5),
    ("f", 6, 8), ("g", 10, 8),
  ]

  init(
    _ dom: Character, _ pokarm: Character, _ punkty_do_wyboru: Int, _ zanik_feromonu: Double
  ) {
    self.dom = dom
    self.pokarm = pokarm
    self.punkty_do_wyboru = punkty_do_wyboru
    self.zanik_feromonu = zanik_feromonu
    self.punkty =
      graf
      .map { (nazwa, x, y) in
        Punkt(nazwa: nazwa, x: x, y: y, ilosc_feromonu: 0.0)
      }
    self.aux = Array(repeating: Auxil(nazwa: "\0", stosunek: 0.0), count: graf.count)
  }

  func pheromoneReset() {
    for i in 0..<punkty.count {
      punkty[i].ilosc_feromonu -= punkty[i].ilosc_feromonu * zanik_feromonu
    }
  }
}
