import Foundation

/// Represents an individual ant in the simulation.
public struct Ant {
    private let max = 1e6
    public var world: World
    public var position: Character
    public var pheromoneAmount: Double
    public var pathLengths: [Int] = []
    private var path: String
    private var satiated = false

    /// Initializes a new ant within the given world.
    /// - Parameters:
    ///   - world: The world in which the ant exists.
    ///   - pheromoneAmount: The amount of pheromone the ant deposits.
    init(world: World, pheromoneAmount: Double) {
        self.world = world
        self.position = world.home
        self.pheromoneAmount = pheromoneAmount
        self.path = String(world.home)
    }

    /// Calculates the distances to all available points in the world.
    private func calculateDistance() {
        let positionIndex = Int(position.asciiValue! - Character("a").asciiValue!)
        let homeIndex = Int(world.home.asciiValue! - Character("a").asciiValue!)
        
        for i in 0..<world.points.count {
            if i == homeIndex || i == positionIndex || path.contains(world.points[i].name) {
                world.auxiliary[i].ratio = max
            } else {
                let dx = world.points[positionIndex].x - world.points[i].x
                let dy = world.points[positionIndex].y - world.points[i].y
                world.auxiliary[i].ratio = sqrt(Double(dx * dx + dy * dy))
            }
        }
    }

    /// Sorts the auxiliary array based on pheromone influence.
    private func sortAuxiliaryArray() {
        for i in 0..<world.points.count {
            world.auxiliary[i].ratio = (world.points[i].pheromoneAmount + 1) / world.auxiliary[i].ratio
        }
        world.auxiliary.sort { $0.ratio >= $1.ratio }
    }

    /// Selects a random point index.
    private func randomChoice() -> Int {
        return Int.random(in: 0..<world.pointsToChoose)
    }

    /// Implements a roulette selection process for movement.
    private func roulette() -> Int {
        var auxiliaryArray = [Double](repeating: 0.0, count: world.pointsToChoose)
        var sum = world.auxiliary.prefix(world.pointsToChoose).reduce(0) { $0 + $1.ratio }
        
        for i in 0..<world.pointsToChoose {
            auxiliaryArray[i] = world.auxiliary[i].ratio / sum
        }
        
        var i = 0
        let random = Double.random(in: 0.0..<1.0)
        sum = auxiliaryArray[i]
        while random > sum {
            i += 1
            sum += auxiliaryArray[i]
        }
        return i
    }

    /// Determines the next movement of the ant.
    public mutating func act() {
        let choice = choosePoint()
        if world.auxiliary[choice].name != world.food {
            position = world.auxiliary[choice].name
            path.append(position)
        } else {
            satiated = true
            position = world.food
            path.append(position)
            markPath()
            pathLengths.append(path.count - 1)
            path = "a"
        }
    }

    /// Chooses the next point for the ant to move to.
    private func choosePoint() -> Int {
        for i in 0..<world.points.count {
            world.auxiliary[i].name = world.points[i].name
        }
        calculateDistance()
        sortAuxiliaryArray()
        var choice: Int
        repeat {
            choice = roulette()
        } while path.contains(world.auxiliary[choice].name)
        return choice
    }

    /// Deposits pheromone along the traveled path.
    private func markPath() {
        for point in path where point != world.home {
            world.points[Int(point.asciiValue! - Character("a").asciiValue!)].pheromoneAmount += pheromoneAmount
        }
    }
}

