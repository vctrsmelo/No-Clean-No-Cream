import Foundation

public class ScenarioObject : Element{
    
    private var points: Int
    private var type : SOType
    private var height,width : Int
    private var organized : Bool
    private var occupiedLocations = [Location:SOType]()
    
    
    public init(type: SOType, width : Int, height : Int, anchorLocation : Location, points : Int){
        
        self.type = type
        self.width = width
        self.height = height
        self.organized = false
        self.points = points

        switch (type){

        case SOType.bed(SOPlace.lowerLeft):
            
            for y in anchorLocation.getY() ..< (anchorLocation.getY()+height){

                //iterate through object columns
                for x in anchorLocation.getX() ..< (anchorLocation.getX()+width){

                    let firstLine = anchorLocation.getY()
                    let firstColumn = anchorLocation.getX()
                    let lastLine = (anchorLocation.getY()+height)-1
                    let lastColumn = (anchorLocation.getX()+width)-1

                    if y == firstLine { //if it is the first line
                        if x == firstColumn { //if it is the first column

                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.lowerLeft)
                            continue

                        } else if x == lastColumn {

                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.lowerRight)
                            continue

                        } else {

                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.downEdge)
                            continue

                        }

                    } else if y == lastLine {

                        if x == firstColumn { //if it is the first column

                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.upperLeft)
                            continue

                        } else if x == lastColumn {

                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.upperRight)
                            continue

                        } else {

                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.upEdge)
                            continue

                        }

                    } else {

                        if x == firstColumn { //if it is the first column

                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.leftEdge)
                            continue

                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.rightEdge)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.bed(SOPlace.centerSprite)
                            continue
                            
                        }
                        
                    }
                    
                }
                
                
            }
            break
        
        case SOType.closet(SOPlace.lowerLeft):
            
            for y in anchorLocation.getY() ..< (anchorLocation.getY()+height){
                
                //iterate through object columns
                for x in anchorLocation.getX() ..< (anchorLocation.getX()+width){
                    
                    let firstLine = anchorLocation.getY()
                    let firstColumn = anchorLocation.getX()
                    let lastLine = (anchorLocation.getY()+height)-1
                    let lastColumn = (anchorLocation.getX()+width)-1
                    
                    if y == firstLine { //if it is the first line
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.lowerLeft)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.lowerRight)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.downEdge)
                            continue
                            
                        }
                        
                    } else if y == lastLine {
                        
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.upperLeft)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.upperRight)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.upEdge)
                            continue
                            
                        }
                        
                    } else {
                        
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.leftEdge)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.rightEdge)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.closet(SOPlace.centerSprite)
                            continue
                            
                        }
                        
                    }
                    
                }
                
            }
            break
        
        case SOType.desk(SOPlace.lowerLeft):
            
            for y in anchorLocation.getY() ..< (anchorLocation.getY()+height){
                
                //iterate through object columns
                for x in anchorLocation.getX() ..< (anchorLocation.getX()+width){
                    
                    let firstLine = anchorLocation.getY()
                    let firstColumn = anchorLocation.getX()
                    let lastLine = (anchorLocation.getY()+height)-1
                    let lastColumn = (anchorLocation.getX()+width)-1
                    
                    if y == firstLine { //if it is the first line
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.lowerLeft)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.lowerRight)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.downEdge)
                            continue
                            
                        }
                        
                    } else if y == lastLine {
                        
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.upperLeft)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.upperRight)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.upEdge)
                            continue
                            
                        }
                        
                    } else {
                        
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.leftEdge)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.rightEdge)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.desk(SOPlace.centerSprite)
                            continue
                            
                        }
                        
                    }
                    
                }
                
            }
            break
            
        case SOType.toyBox(SOPlace.lowerLeft):
            self.organized = true
            for y in anchorLocation.getY() ..< (anchorLocation.getY()+height){
                
                //iterate through object columns
                for x in anchorLocation.getX() ..< (anchorLocation.getX()+width){
                    
                    let firstLine = anchorLocation.getY()
                    let firstColumn = anchorLocation.getX()
                    let lastLine = (anchorLocation.getY()+height)-1
                    let lastColumn = (anchorLocation.getX()+width)-1
                    
                    if y == firstLine { //if it is the first line
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.lowerLeft)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.lowerRight)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.downEdge)
                            continue
                            
                        }
                        
                    } else if y == lastLine {
                        
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.upperLeft)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.upperRight)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.upEdge)
                            continue
                            
                        }
                        
                    } else {
                        
                        if x == firstColumn { //if it is the first column
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.leftEdge)
                            continue
                            
                        } else if x == lastColumn {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.rightEdge)
                            continue
                            
                        } else {
                            
                            occupiedLocations[Location(x: x, y: y)] = SOType.toyBox(SOPlace.centerSprite)
                            continue
                            
                        }
                        
                    }
                    
                }
                
            }
            break
            
        default:
            print("[Error] ScenarioObject.init: undefined scenarioObject type")
            break
            
        }
    
        super.init(location: anchorLocation)
        
    }
    
    
    public func getPoints() -> Int {
        
        return self.points
        
    }
    
    public func getHeight() -> Int {
        
        return self.height
        
    }
    
    public func getWidth() -> Int {
        
        return self.width
        
    }
    
    public func getType() -> SOType{
        
        return self.type
        
    }
    
    public func getOccupiedLocations() -> [Location:SOType]{
    
        return occupiedLocations
    
    }
    
    public func canBeOrganized() -> Bool {
    
        let x1 = self.getLocation().getX()
        let y1 = self.getLocation().getY()
        let xn = self.getLocation().getX()+self.width-1
        let yn = self.getLocation().getY()+self.height-1

        for x in x1 ... xn {
            
            for y in y1 ... yn {

                if let bool = Map.instance.thereIsAnObjectAt(Location(x : x,y : y)){

                    if bool == true{
                        return false
                    }
            
                }
            
            }
            
        }
        
        return true
    
    }
    
    public func isOrganized() -> Bool{
        
        return organized
        
    }
    
    public func getLocations() -> Array<Location>{
        
        var locations = Array<Location>()
        
        for location in self.occupiedLocations.keys{
            
            locations.append(Location(x:location.getX(),y:(Config.MAP_HEIGHT-1)-location.getY()))
            
        }
        
        return locations
        
    }
    
    public func organizeIt(){
        
        print("ORGANIZOU!!!")
        NotificationCenter.default.post(name: Notification.Name("SCENARIO_OBJECT_ORGANIZED"), object: nil, userInfo: ["scenarioObject" : self])
        
        organized = true
        
    }
    
}
