/// ###Ant algorithm research performed by Szymon Gniado at AEH

/// Starts a simulation, by creating the `World` and the `Anthill`, and looping until all the ants are satisfied.
/// - Parameters:
///     - pointsToChoose: The number of `Point`s an `Ant` can choose to go to.
///     - pheromoneDecay: The ratio of `pheromone` decay speed.
///     - numberOfAnts: The number of the `Ant`s in the `Anthill`.
///     - pheromone: The amount of `pheromone` is produced by the `Ant`s after finding the `food`.
public func start(pointsToChoose: Int, pheromoneDecay: Double, numberOfAnts: Int, pheromone: Double) {
    let world =  World(home: "a", food: "g", pointsToChoose: pointsToChoose, pheromoneDecay: pheromoneDecay)
    var anthill = Anthill(world: world, numberOfAnts: numberOfAnts, pheromone: pheromone)
    while !anthill.areAllAntsSatiated() {
        world.resetPheromone()
        anthill.move()
    }
}
