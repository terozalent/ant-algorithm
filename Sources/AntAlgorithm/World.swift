/// Represents the world in which ants navigate.
public class World {
    public var points: [Point]
    public var auxiliary: [Auxiliary]
    public var home: Character
    public var food: Character
    public var pointsToChoose: Int
    public var pheromoneDecay: Double
    
    private let graph: [(Character, Int, Int)] = [
        ("a", 6, 1), ("b", 13, 1), ("c", 4, 3), ("d", 4, 5), ("e", 8, 5),
        ("f", 6, 8), ("g", 10, 8)
    ]

    /// Initializes the world with given parameters.
    init(home: Character, food: Character, pointsToChoose: Int, pheromoneDecay: Double) {
        self.home = home
        self.food = food
        self.pointsToChoose = pointsToChoose
        self.pheromoneDecay = pheromoneDecay
        self.points = graph.map { Point(name: $0.0, x: $0.1, y: $0.2, pheromoneAmount: 0.0) }
        self.auxiliary = Array(repeating: Auxiliary(name: "\0", ratio: 0.0), count: graph.count)
    }

    /// Reduces the pheromone level over time.
    public func resetPheromone() {
        for i in 0..<points.count {
            points[i].pheromoneAmount -= points[i].pheromoneAmount * pheromoneDecay
        }
    }
}

