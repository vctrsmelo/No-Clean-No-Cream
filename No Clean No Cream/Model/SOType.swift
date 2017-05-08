import Foundation

public enum SOType{
    
    case bed(SOPlace)
    case desk(SOPlace)
    case closet(SOPlace)
    case toyBox(SOPlace)
    case blank

}

func ==(a: SOType, b: SOType) -> Bool {
    switch (a, b) {
    case (.bed(_), .bed(_)): return true
    case (.desk(_), .desk(_)): return true
    case (.closet(_), .closet(_)): return true
    case (.toyBox(_), .toyBox(_)): return true
        case (.blank, .blank): return true
        default: return false
    }
}

func !=(a: SOType, b: SOType) -> Bool {
    switch (a, b) {
    case (.bed(_), .bed(_)): return false
    case (.desk(_), .desk(_)): return false
    case (.closet(_), .closet(_)): return false
    case (.toyBox(_), .toyBox(_)): return false
    case (.blank, .blank): return false
    default: return true
    }
}
