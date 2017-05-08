public class Element{
    
    private var location : Location

    init(location : Location){
        
        self.location = location
        
    }

    public func getLocation() -> Location{
        
        return location
    
    }
    
    public func setLocation(_ location : Location){
        
        self.location = location
        
    }
    
}
