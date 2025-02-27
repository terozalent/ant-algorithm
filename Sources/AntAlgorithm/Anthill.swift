public struct Mrowisko {
  public let LICZBA_MROWEK: Int
  public var mrowki: [Mrowka]

  init(_ swiat: Swiat, _ liczba_mrowek: Int, _ pheromone: Double) {
    self.LICZBA_MROWEK = liczba_mrowek
    self.mrowki = Array(repeating: Mrowka(swiat, pheromone), count: LICZBA_MROWEK)
  }

  public func wszystkieMrowkiSyte() -> Bool {
    var bool = true
    for mrowka in mrowki {
      bool = bool && !mrowka.dlugosc_sciezek.isEmpty
    }
    return bool
  }

  mutating public func move() {
    for i in 0..<LICZBA_MROWEK {
      mrowki[i].dzialaj()
    }
  }
}
