import Foundation

@main
struct AntAlgorithm {
   static func main() {
    var pathLengths: [[Int]] = []
    print("| pheromone decay | average path length |")
    print("| :---: | :---: |")
    for _ in 0...100 {
      for _ in 1...100 {
        let world = World(
          home: "a", food: "g",pointsToChoose: 2,pheromoneDecay: 0)
        var anthill = Anthill(world: world, numberOfAnts: 24,pheromone: 2)
        while !anthill.areAllAntsSatiated(){
          world.resetPheromone()
          anthill.move()
        }
        pathLengths.append(anthill.ants.map { $0.pathLengths }.flatMap { $0 })
      }
      let flatPathLengths = pathLengths.flatMap { $0 }
      let averagePathLength =
        pathLengths.isEmpty
        ? 0
        : Double(flatPathLengths.reduce(0, +)) / Double(flatPathLengths.count)
      print("| 0% | \(averagePathLength) |")
    }
   }
}
