public class Location: Hashable{
    
    public var hashValue: Int


    
    public static func ==(lhs: Location, rhs: Location) -> Bool {
        
        if(lhs.getX() == rhs.getX() && lhs.getY() == rhs.getY()){
            return true
        }
        
        return false
    }

    
    private var x : Int
    private var y : Int
        
    public init(x : Int,y : Int){
        self.x = x
        self.y = y
        
        hashValue = 0
        
    }
    
    public func update(x : Int, y : Int){
        
        self.x = x
        self.y = y
        
    }
    
    public func getX() -> Int { return x }
    public func getY() -> Int { return y }
    
}
