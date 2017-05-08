public enum TileType{
    
    case floor
    case wall(SOPlace)
    case door(SOPlace)
    
}

func ==(a: TileType, b: TileType) -> Bool {
    switch (a, b) {
    case (.floor(_), .floor(_)): return true
    case (.wall(_), .wall(_)): return true
    case (.door(_), .door(_)): return true
    default: return false
    }
}

func !=(a: TileType, b: TileType) -> Bool {
    switch (a, b) {
    case (.floor(_), .floor(_)): return false
    case (.wall(_), .wall(_)): return false
    case (.door(_), .door(_)): return false
    default: return true
    }
}
