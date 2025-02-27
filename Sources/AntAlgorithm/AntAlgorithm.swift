import Foundation

@main
struct AntAlgorithm {
   static func main() {
    var dlugosc_sciezek: [[Int]] = []
    print("| pheromone decay | srednia_dlugosc_sciezki |")
    print("| :---: | :---: |")
    for _ in 0...100 {
      for _ in 1...100 {
        let swiat = Swiat(
          "a", "g", 2, 0)
        var anthill = Mrowisko(swiat, 24, 2)
        while !anthill.wszystkieMrowkiSyte() {
          swiat.pheromoneReset()
          anthill.move()
        }
        dlugosc_sciezek.append(anthill.mrowki.map { $0.dlugosc_sciezek }.flatMap { $0 })
      }
      let splaszczone_dlugosci_sciezek = dlugosc_sciezek.flatMap { $0 }
      let srednia_dlugosc_sciezki =
        dlugosc_sciezek.isEmpty
        ? 0
        : Double(splaszczone_dlugosci_sciezek.reduce(0, +)) / Double(splaszczone_dlugosci_sciezek.count)
      print("| 0% | \(srednia_dlugosc_sciezki) |")
    }
   }
}
