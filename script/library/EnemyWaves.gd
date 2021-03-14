class Wave:
    var count: int
    var frequency: float
    var speed: float
    var health: float

func get_all_waves() -> Array:
    var waves = []

    var new_wave = Wave.new()
    new_wave.count = 3
    new_wave.frequency = 0.5
    new_wave.speed = 40
    new_wave.health = 10
    waves.append(new_wave)
    
    new_wave = Wave.new()
    new_wave.count = 2
    new_wave.frequency = 0.7
    new_wave.speed = 50
    new_wave.health = 20
    waves.append(new_wave)
    
    new_wave = Wave.new()
    new_wave.count = 2
    new_wave.frequency = 1.2
    new_wave.speed = 100
    new_wave.health = 10
    waves.append(new_wave)
    
    new_wave = Wave.new()
    new_wave.count = 5
    new_wave.frequency = 0.9
    new_wave.speed = 60
    new_wave.health = 15
    waves.append(new_wave)
    
    new_wave = Wave.new()
    new_wave.count = 1
    new_wave.frequency = 0.2
    new_wave.speed = 70
    new_wave.health = 40
    waves.append(new_wave)

    return waves

