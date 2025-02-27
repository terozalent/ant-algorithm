/// Represents an anthill containing multiple ants.
public struct Anthill {
    public let numberOfAnts: Int
    public var ants: [Ant]

    /// Initializes an anthill with a given number of ants.
    init(world: World, numberOfAnts: Int, pheromone: Double) {
        self.numberOfAnts = numberOfAnts
        self.ants = Array(repeating: Ant(world: world, pheromoneAmount: pheromone), count: numberOfAnts)
    }

    /// Checks if all ants have completed their path.
    public func areAllAntsSatiated() -> Bool {
        return ants.allSatisfy { !$0.pathLengths.isEmpty }
    }

    /// Moves all ants within the anthill.
    public mutating func move() {
        for i in 0..<numberOfAnts {
            ants[i].act()
        }
    }
}

