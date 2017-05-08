import Foundation
import SpriteKit

public class Map {
    
    private struct LocationAStar{
        
        var location: Location
        var g,h: Int
        var f: Int
        var parent: Location
        
    }
    
    public static let instance = Map()
    private let xSize = Config.MAP_WIDTH
    private let ySize = Config.MAP_HEIGHT
    private var objects = Array<Array<ObjectType>>()
    private var characters = Array<Array<Character?>>()
    private var scenarioObjects = Array<Array<ScenarioObject?>>()
    private var scenarioObjectsTypeMap = Array<Array<SOType>>()
    private var isScenarioMapTypeUpToDate = false
    private var selectedCharacter : Character?
    private var selectedHand : Hand? = nil
    
    private var cleanRelations = Array<CleanRelation>()
    
    private var mapBackground = [[TileType.wall(SOPlace.upEdge),TileType.wall(SOPlace.upEdge),TileType.wall(SOPlace.upEdge),TileType.wall(SOPlace.upEdge),TileType.door(SOPlace.upperLeft),TileType.door(SOPlace.upperRight),TileType.wall(SOPlace.upEdge),TileType.wall(SOPlace.upEdge),TileType.wall(SOPlace.upEdge),TileType.wall(SOPlace.upEdge)],[TileType.wall(SOPlace.centerSprite),TileType.wall(SOPlace.centerSprite),TileType.wall(SOPlace.centerSprite),TileType.wall(SOPlace.centerSprite),TileType.door(SOPlace.leftEdge),TileType.door(SOPlace.rightEdge),TileType.wall(SOPlace.centerSprite),TileType.wall(SOPlace.centerSprite),TileType.wall(SOPlace.centerSprite),TileType.wall(SOPlace.centerSprite)],[TileType.wall(SOPlace.downEdge),TileType.wall(SOPlace.downEdge),TileType.wall(SOPlace.downEdge),TileType.wall(SOPlace.downEdge),TileType.door(SOPlace.lowerLeft),TileType.door(SOPlace.lowerRight),TileType.wall(SOPlace.downEdge),TileType.wall(SOPlace.downEdge),TileType.wall(SOPlace.downEdge),TileType.wall(SOPlace.downEdge)],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor],[TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor,TileType.floor]]
    
    private init(){
        
        for y in 0 ..< ySize {
            
            objects.append(Array<ObjectType>())
            characters.append(Array<Character?>())
            scenarioObjects.append(Array<ScenarioObject?>())
            scenarioObjectsTypeMap.append(Array<SOType>())
            
            for _ in 0 ..< xSize {
                
                objects[y].append(ObjectType.blank)
                characters[y].append(nil)
                scenarioObjects[y].append(nil)
                scenarioObjectsTypeMap[y].append(SOType.blank)
                
            }
        
        }
        
    }
    
    public func add(cleanRelation: CleanRelation){
        
        cleanRelations.append(cleanRelation)
        
    }
    
    public func getMapBackground() -> Array<Array<TileType>>{
        
        return mapBackground
        
    }
    
    public func getObjectsMap() -> Array<Array<ObjectType>>{
        
        return objects
        
    }
    
    private func isValidLocation(_ location : Location) -> Bool{
    
        if(location.getX() >= 0 && location.getX() < xSize && location.getY() >= 0 && location.getY() < ySize){
            
            return true

        }
        
        return false
    
    }
    
    public func getNearLocation(of: Location, beginningAt begin: Location) -> Location?{

        let bottom = Location(x: of.getX(),y: of.getY()+1)
        let left = Location(x: of.getX()-1,y: of.getY())
        let top = Location(x: of.getX(),y: of.getY()-1)
        let right = Location(x: of.getX()+1,y: of.getY())
        
        var nearLocations = [bottom,left,top,right]
        var nearValidLocations : Array<Location> = []
        
        var startIndex = 0
        
        for i in 0 ..< nearLocations.count{
            
            if(isValidLocation(nearLocations[i])){
                
                nearValidLocations.append(nearLocations[i])
                
            }
            
        }
        
        for i in 0 ..< nearValidLocations.count{
            
            if(nearValidLocations[i].getY() == begin.getY() && nearValidLocations[i].getX() == begin.getX()){
                
                startIndex = i
                break
                
            }
            
        }
        
        if(isMovableLocation(nearValidLocations[startIndex])){
            
            return nearValidLocations[startIndex]
            
        }
        
        for _ in 0 ..< nearValidLocations.count{

            if(isMovableLocation(nearValidLocations[startIndex])){

                return nearValidLocations[startIndex]
                
            }
            
            startIndex = (startIndex+1) % nearValidLocations.count
        
        }
        
            
            
        return nil
        
    }
    
    
    public func getNearLocationToDrop(of: Location, beginningAt begin: Location) -> Location?{
        
        let bottom = Location(x: of.getX(),y: of.getY()+1)
        let left = Location(x: of.getX()-1,y: of.getY())
        let top = Location(x: of.getX(),y: of.getY()-1)
        let right = Location(x: of.getX()+1,y: of.getY())
        
        var nearLocations = [bottom,left,top,right]
        var nearValidLocations : Array<Location> = []
        
        var startIndex = 0
        
        for i in 0 ..< nearLocations.count{
            
            if(isValidLocation(nearLocations[i])){
                
                nearValidLocations.append(nearLocations[i])
                
            }
            
        }
        
        for i in 0 ..< nearValidLocations.count{
            
            if(nearValidLocations[i].getY() == begin.getY() && nearValidLocations[i].getX() == begin.getX()){
                
                startIndex = i
                break
                
            }
            
        }
        
        if(isMovableLocation(nearValidLocations[startIndex])){
            
            return nearValidLocations[startIndex]
            
        }
        
        for _ in 0 ..< nearValidLocations.count{
            
            if(isMovableLocation(nearValidLocations[startIndex])){
                
                return nearValidLocations[startIndex]
                
            }
            
            startIndex = (startIndex+1) % nearValidLocations.count
            
        }
        
        
        
        return nil
        
    }

    
    public func isNearLocation(from: Location, to: Location) -> Bool{
        
        if(from.getX() - to.getX() == 0){
            
            if(from.getY() - to.getY() == 1 || from.getY() - to.getY() == -1){
                
                return true
                
            }
            
        }
        
        if(from.getY() - to.getY() == 0){
            
            if(from.getX() - to.getX() == 1 || from.getX() - to.getX() == -1){
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
    public func add(character char : Character, at location: Location){

        if(!isValidLocation(location)){
            print("[Error] Couldn't add character \(char) at location \(location): invalid location")
            return
            
        }
        
        if let charBool = thereIsACharacterAt(location){
            
            if(charBool == true){
                
                print("[Error] Couldn't add character \(char) at location \(location): there is already a character at this location")
                return
                
            }
    
        }

        char.setLocation(location)
        characters[location.getY()][location.getX()] = char
        
    }

    
    public func isMovableLocation(_ location: Location) -> Bool{
        
        
        if(isValidLocation(location) && !(thereIsAnObjectAt(location)!) && !(thereIsACharacterAt(location)!) && !(thereIsAScenarioObjectAt(location)!)){
            
            return true
            
        }

        return false
        
    }
    
    public func add(object obj : ObjectType, at location: Location){
        
        if(!isValidLocation(location)){
            
            print("[Error] Couldn't add object \(obj) at location \(location): invalid location")
            return
            
        }
        
        if let objBool = thereIsAnObjectAt(location){
            
            if(objBool == true){

                print("[Error] Couldn't add object \(obj) at location \(location): there is already an object at this location")
                return
            
            }
            
        }

        objects[location.getY()][location.getX()] = obj
        
    }
    
    public func add(scenarioObject obj : ScenarioObject, at location : Location){
        
        if(!isValidLocation(location)){
            
            print("[Error] Couldn't add scenario object \(obj) at location \(location) : invalid location")
            return
            
        }
        
        if let scenObjBool = thereIsAScenarioObjectAt(location){
            
            if(scenObjBool == true){

                print("[Error]1 Couldn't add scenario object \(obj) at location \(location) : there is already a ScenarioObject at this location")
                return
            
            }
            
        }
        
        var locationsToBeOccupied = Array<Location>()
        
        obj.setLocation(location)
        
        for x in location.getX() ..< (location.getX()+obj.getWidth()){

            for y in location.getY() ..< (location.getY()+obj.getHeight()){
                
                let locationBeingVerified = Location(x: x, y: y)
                
                if(!isValidLocation(locationBeingVerified)){
                    
                    print("[Error] Couldn't add scenario object \(obj) at location \(location) : invalid location")
                    return
                    
                }
                
                locationsToBeOccupied.append(locationBeingVerified)
                
            }
            
        }

        scenarioObjects[location.getY()][location.getX()] = obj
        isScenarioMapTypeUpToDate = false
        
    }
    
    
    public func getObjectAtLocation(_ location : Location) -> ObjectType?{
        
        if(!isValidLocation(location)){
            
            print("[Error] Couldn't get object from location \(location) : invalid location")
            return nil
            
        }
        
        return objects[location.getY()][location.getX()]
        
    }
    
    public func thereIsAnObjectAt(_ location : Location) -> Bool?{
        
        if(!isValidLocation(location)){
            
            print("[Error] Couldn't verifies location \(location) : invalid location")
            return nil
            
        }
        
        if(objects[location.getY()][location.getX()] != ObjectType.blank){
            
            return true
            
        }
        
        return false
    }
    
    public func thereIsACharacterAt(_ location : Location) -> Bool?{
        
        if(!isValidLocation(location)){
            
            print("[Error] Couldn't verifies location \(location) : invalid location")
            return nil
            
        }
        
        if(characters[location.getY()][location.getX()] != nil){
            
            return true
            
        }
        
        return false
    }
    
    public func thereIsAScenarioObjectAt(_ location : Location) -> Bool?{
        
        if(!isValidLocation(location)){
            
            return nil
            
        }
    
        let scenObjTypeMap = scenarioObjectsTypeMap[location.getY()][location.getX()]
        if(scenObjTypeMap != SOType.blank){
            return true
            
        }

        return false
        
    }
    
    public func getObjectMap() -> Array<Array<ObjectType>>{
        
        return objects
        
    }
    
    
    public func getScenarioObjectMap() -> Array<Array<SOType>>{
        
        if(isScenarioMapTypeUpToDate == true){
            
            return scenarioObjectsTypeMap
            
        }
        
        var scenObjTypeMap = Array<Array<SOType>>()
        
        //build Map
        for y in 0 ..< Config.MAP_HEIGHT{
            
            scenObjTypeMap.append(Array<SOType>())
            
            for _ in 0 ..< Config.MAP_WIDTH{
                scenObjTypeMap[y].append(SOType.blank)
                
            }
            
            
        }
        
        //iterate through map lines
        for y in 0 ..< Config.MAP_HEIGHT{

            //iterate through map columns
            for x in 0 ..< Config.MAP_WIDTH{
            
                //if there is an object at the location
                if(scenarioObjects[y][x] == nil){
                    continue;
                }
                
                let scenObj = scenarioObjects[y][x]
                
                for scenObjPieces in scenObj!.getOccupiedLocations(){
                    
                    let xLocation = scenObjPieces.key.getX()
                    let yLocation = (Config.MAP_HEIGHT-1)-scenObjPieces.key.getY()
                    
                    scenObjTypeMap[yLocation][xLocation] = scenObjPieces.value
                    
                }
            
            }
        }
        
        scenarioObjectsTypeMap = scenObjTypeMap
        isScenarioMapTypeUpToDate = true
        return scenarioObjectsTypeMap
        
    }
    
    //A* Algorithm
    public func buildPath(from: Location, to: Location) -> Array<Location>? {
        
        var path = Array<Location>()
        var thereIsAPath = false
        var closedList = Array<LocationAStar>()
        var openList = Array<LocationAStar>()
        openList.append(LocationAStar(location: from, g: 0, h: 0, f: 0, parent: from))
        
        repeat{
            
            let index = getIndexLocationWithLowestFScore(openList)
            let currentSquare = openList[index] // get the square with the lowest F Score
            
            closedList.append(currentSquare)
            openList.remove(at: index)
            
            if(containsLocation(closedList,location: to)){ //if added the destination to the closed list, we`ve found a path
                
                thereIsAPath = true
                break
                
            }
            
            var adjacentSquares = getWalkableAdjacentsSquares(square: currentSquare, destination: to)
            
            for i in 0 ..< adjacentSquares.count{
                
                if(containsLocation(closedList, location: adjacentSquares[i].location)){

                    continue
                    
                }
                
                if(!containsLocation(openList, location: adjacentSquares[i].location)){
                    
                    openList.append(adjacentSquares[i])
                    
                }else{
                    
                    // test if using the current G score make the aSquare F score lower, if yes update the parent because it means its a better path
                    let index = getIndexLocation(openList, location:adjacentSquares[i].location)!;
                    
                    if(openList[index].f > adjacentSquares[i].f){
                        
                        openList[index].parent = currentSquare.location;
                        
                    }
                    
                }
                
            }
            
        }while(!(openList.count == 0))
    
        
        if(thereIsAPath){
            
            let destIndex = getIndexLocation(closedList, location: to)

            var currentLocation = closedList[destIndex!]
            
            var reachedStartLocation = false
            
            while(!reachedStartLocation){
                
                if(currentLocation.location.getX() == currentLocation.parent.getX() && currentLocation.location.getY() == currentLocation.parent.getY()){
                    reachedStartLocation = true
                    continue
                }
                
                path.append(currentLocation.location)
                
                let i = getIndexLocation(closedList, location: currentLocation.parent)!
                currentLocation = closedList[i]
            
            }
            
            return path.reversed()
            
        }
        
        return nil
        
    }
    
    
    private func getIndexLocation(_ list: Array<LocationAStar>, location: Location) -> Int?{
        
        for i in 0 ..< list.count{
            
            if(list[i].location.getX() == location.getX() && list[i].location.getY() == location.getY()){
                
                return i
                
            }
            
        }
        
        return nil
        
    }
    
    private func getWalkableAdjacentsSquares(square: LocationAStar,destination: Location) -> Array<LocationAStar>{
        
        var adjacentsSquares = Array<LocationAStar>()
        
        let localX = square.location.getX()
        let localY = square.location.getY()
        
        if(isWalkable(x: localX+1,y: localY) || destination == Location(x: localX+1, y: localY)){
            let location = Location(x: localX+1,y: localY)
            let h = getDistance(from: location, to: destination)
            adjacentsSquares.append(LocationAStar(location: location, g: square.g+1, h: h, f: square.g+1+h, parent: square.location))
            
        }
        
        if(isWalkable(x: localX-1,y: localY) || destination == Location(x: localX-1, y: localY)){
            let location = Location(x: localX-1,y: localY)
            let h = getDistance(from: location, to: destination)
            adjacentsSquares.append(LocationAStar(location: location, g: square.g+1, h: h, f: square.g+1+h, parent: square.location))
            
        }
        
        if(isWalkable(x: localX,y: localY+1) || destination == Location(x: localX, y: localY+1)){
            let location = Location(x: localX,y: localY+1)
            let h = getDistance(from: location, to: destination)
            adjacentsSquares.append(LocationAStar(location: location, g: square.g+1, h: h, f: square.g+1+h, parent: square.location))
            
        }
        
        if(isWalkable(x: localX,y: localY-1) || destination == Location(x: localX, y: localY-1)){
            let location = Location(x: localX,y: localY-1)
            let h = getDistance(from: location, to: destination)
            adjacentsSquares.append(LocationAStar(location: location, g: square.g+1, h: h, f: square.g+1+h, parent: square.location))
            
        }
        
        return adjacentsSquares
        
    }
    
    private func getDistance(from: Location, to: Location) -> Int{
    
        var xDistance : Int
        var yDistance : Int
    
        if(from.getX() > to.getX()){
            
            xDistance = from.getX() - to.getX()
        }else{
            
            xDistance = to.getX() - from.getX()
            
        }
        
        if(from.getY() > to.getY()){
            
            yDistance = from.getY() - to.getY()
            
        }else{
            
            yDistance = to.getY() - from.getY()
            
        }
        
        return xDistance+yDistance
        
    }
    
    private func isWalkable(x: Int, y: Int) -> Bool{
        
        let occupiedLocal = thereIsAScenarioObjectAt(Location(x: x, y: y))
        
        if(occupiedLocal == nil || occupiedLocal! == false){
        
            if( isValidLocation(Location(x: x, y: y)) &&
                objects[y][x] == ObjectType.blank &&
                characters[y][x] == nil && mapBackground[y][x] == TileType.floor){
                
                return true
                
            }
 
        }
        return false
        
    }
    
    private func containsLocation(_ list: Array<LocationAStar>, location: Location) -> Bool {
        
        for i in 0 ..< list.count{
            
            if(list[i].location.getX() == location.getX() && list[i].location.getY() == location.getY()){
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
    private func getIndexLocationWithLowestFScore(_ locationAStarList: Array<LocationAStar>) -> Int{
        
        var indexReturned = 0
        for i in 1 ..< locationAStarList.count{
            
            if (locationAStarList[i].f < locationAStarList[indexReturned].f){
                
                indexReturned = i
                
            }
            
        }
        
        return indexReturned
        
        
    }
    
    public func tileTouched(_ tile : Location) {
        
        let x = tile.getX()
        let y = tile.getY()
        
        if(selectedCharacter == nil){
            
            if(characters[y][x] != nil){
                
                //selected a character
                selectedCharacter = characters[y][x]
                selectedCharacter!.addHighlight()
                print("[Modelo] clicou no personagem")
                return
                
            }

        }else{

            if(characters[y][x] != nil){
                
                print("[Modelo] selecionou o mesmo/outro personagem")
                //selected a different character
                selectedCharacter!.removeHighlight()
                selectedCharacter = characters[y][x]
                selectedCharacter!.addHighlight()
                
                return
            }
            
            
            //Told character to get object
            if(objects[y][x] != ObjectType.blank){
                print("[Modelo] mandou personagem pegar o objeto")

                let selectedObject = objects[y][x]
                
                if(!selectedCharacter!.isWalking()){

                    let oldY = selectedCharacter!.getLocation().getY()
                    let oldX = selectedCharacter!.getLocation().getX()
                    
                    if(!someoneIsGettingObjectAt(location: Location(x: x, y: y))){

                        let objectLocation = Location(x: x, y: y)
                        
                        let destLocation = selectedCharacter!.getNearLocation(objectLocation)
                        
                        if(destLocation == nil){
                            
                            return
                            
                        }
                        
                        //if object at location needs cleaner
                        if(objects[y][x] != ObjectType.blank && objectNeedCleaner(cleanedObject: objects[y][x]) == true){

                            let objAtLeftHandIsCleaner : Bool = (selectedCharacter!.getLeftHand() != nil && isACleanerOf(cleanerObject: selectedCharacter!.getLeftHand()!, toBeCleanedObject: selectedObject))
                            
                            let objAtRightHandIsCleaner : Bool = (selectedCharacter!.getRightHand() != nil && isACleanerOf(cleanerObject: selectedCharacter!.getRightHand()!, toBeCleanedObject: selectedObject))
                            
                            if(objAtLeftHandIsCleaner || objAtRightHandIsCleaner){

                                //can clean the object. Go there and clean
                                selectedCharacter!.get(object: objects[y][x], objectLocation: objectLocation, nearLocation: destLocation!)
                                
                                characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                                characters[oldY][oldX] = nil
                                
                                return
                                
                            }
                            
                            var cleanerObject = getNeededCleaner(cleanedObject: objects[y][x])
                            
                            if(cleanerObject != nil){
                            
                                selectedCharacter!.getChatBalloon().showMessage(objectType: cleanerObject!)
                            
                            }
                            
                            return
                            
                        }
                        
                        //if objectAtLocation is cleaner of an object at hand, must just go and drop hand object
                        let objIsCleanerOfLeftHand : Bool = (selectedCharacter!.getLeftHand() != nil && isACleanerOf(cleanerObject: selectedObject, toBeCleanedObject: selectedCharacter!.getLeftHand()!))
                        
                        let objIsCleanerOfRightHand : Bool = (selectedCharacter!.getRightHand() != nil && isACleanerOf(cleanerObject: selectedObject, toBeCleanedObject: selectedCharacter!.getRightHand()!))
                        
                        if(selectedHand != nil || objIsCleanerOfLeftHand || objIsCleanerOfRightHand){

                            if(selectedHand != nil && selectedHand! == Hand.left && objIsCleanerOfLeftHand){
                                
                                selectedCharacter!.dropNear(handEnum: Hand.left, nearLocation: destLocation!)
                                characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                                characters[oldY][oldX] = nil
                                
                            } else if(selectedHand != nil && selectedHand! == Hand.right && objIsCleanerOfRightHand){
                                
                                selectedCharacter!.dropNear(handEnum: Hand.right, nearLocation: destLocation!)
                                characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                                characters[oldY][oldX] = nil
                                
                            }
                            
                            return
                        }
                        
                        
                        if(selectedHand == nil){
                            //if objectAtLocation isn't cleaner. Must go then get this object

                            selectedCharacter!.get(object: objects[y][x], objectLocation: objectLocation, nearLocation: destLocation!)
                            
                            characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                            characters[oldY][oldX] = nil
                           
                        }
                        
                    
                    }else{
                        
                        print("Someone is getting the object!!!!")
                        
                    }
                    
                }
                return
            }
            
            if(thereIsAScenarioObjectAt(Location(x: x, y: y)) == true){
                
                if(!selectedCharacter!.isWalking()){
                
                    if(selectedHand == nil){
                    
                        if(scenarioObjectsTypeMap[y][x] != SOType.blank){
                            
                            for y in 0 ..< scenarioObjects.count {
                                
                                for x in 0 ..< scenarioObjects[y].count{
                                    
                                    if(scenarioObjects[y][x] != nil){
                                        for location in scenarioObjects[y][x]!.getLocations() {
                                
                                            if(location == tile){
                                            
                                                //if scenarioObject is not organized, go to near and organize it
                                                if(!scenarioObjects[y][x]!.isOrganized()){
                                                    
                                                    let locations = scenarioObjects[y][x]!.getLocations()
                                                    
                                                    let oldY = selectedCharacter!.getLocation().getY()
                                                    let oldX = selectedCharacter!.getLocation().getX()
                                                    let destLocation = selectedCharacter!.getNearLocation(locations)
                                                    
                                                    if(destLocation != nil){
                                                    
                                                        let boolMove = selectedCharacter!.goToThenOrganize(scenarioObject: scenarioObjects[y][x]!, destineLocation: destLocation!)
                                                        if(boolMove){
                                                            characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                                                            characters[oldY][oldX] = nil
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            
                        }

                    } else if(selectedHand != nil){
                        
                        let oldY = selectedCharacter!.getLocation().getY()
                        let oldX = selectedCharacter!.getLocation().getX()
                        
                        let scenarioObjectLocation = Location(x: x, y: y)
                        let destLocation = selectedCharacter!.getNearLocation(scenarioObjectLocation)
                        
                        if(destLocation == nil){
                            
                            return
                            
                        }
                        //if scenarioObject is cleaner, go to and clean it
                        if(selectedHand == Hand.left && isACleanerOf(cleanerScenarioObject: scenarioObjectsTypeMap[y][x], toBeCleanedObject: selectedCharacter!.getLeftHand()!)){
                            
                            selectedCharacter!.dropNear(handEnum: Hand.left, nearLocation: destLocation!)
                            characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                            characters[oldY][oldX] = nil
                            
                        }else if(selectedHand == Hand.right && isACleanerOf(cleanerScenarioObject: scenarioObjectsTypeMap[y][x], toBeCleanedObject: selectedCharacter!.getRightHand()!)){
                            
                            selectedCharacter!.dropNear(handEnum: Hand.right, nearLocation: destLocation!)
                            characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                            characters[oldY][oldX] = nil
                            
                        }else if(isDroppableScenarioObjectType(scenarioObjectsTypeMap[y][x])){
                            
                            if(isValidLocation(scenarioObjectLocation)){
                                
                                selectedCharacter!.drop(handEnum: selectedHand!, charNearDestineLocation: destLocation!, objectDestineLocation: scenarioObjectLocation)
                                
                                characters[destLocation!.getY()][destLocation!.getX()] = selectedCharacter
                                characters[oldY][oldX] = nil
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                return
            
            }
        
            if(mapBackground[y][x] == TileType.wall(SOPlace.downEdge) || mapBackground[y][x] == TileType.wall(SOPlace.centerSprite) || mapBackground[y][x] == TileType.wall(SOPlace.upEdge)){
                
                return
                
            }
            
            if(selectedHand != nil){
                
                let selectedLocation = Location(x: x, y: y)

                let oldY = selectedCharacter!.getLocation().getY()
                let oldX = selectedCharacter!.getLocation().getX()
                let characterDestLocation = selectedCharacter!.getNearLocation(selectedLocation)
                
                if(isValidLocation(selectedLocation)){
                    
                    selectedCharacter!.drop(handEnum: selectedHand!, charNearDestineLocation: characterDestLocation!, objectDestineLocation: selectedLocation)
                    
                    characters[characterDestLocation!.getY()][characterDestLocation!.getX()] = selectedCharacter
                    characters[oldY][oldX] = nil

                
                }
                
            }
            
            if(!selectedCharacter!.isWalking() && selectedHand == nil){
               
                let oldY = selectedCharacter!.getLocation().getY()
                let oldX = selectedCharacter!.getLocation().getX()
                let moved = selectedCharacter!.goTo(x:x,y:y)
                if(moved){
                
                    characters[y][x] = selectedCharacter
                    characters[oldY][oldX] = nil
                
                }
            
            }

            
        }
        
    }
    
    public func objectNeedCleaner(cleanedObject: ObjectType) -> Bool{
        
        for relation in cleanRelations{
            
            if(relation.objectToBeCleaned == cleanedObject && relation.needCleaner){
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
    public func getNeededCleaner(cleanedObject: ObjectType) -> ObjectType?{
        
        for relation in cleanRelations{
            
            if(relation.objectToBeCleaned == cleanedObject && relation.needCleaner){
                
                if(relation.objectCleaner != nil){
                    return relation.objectCleaner!
                }
                
            }
            
        }
        
        return nil
        
    }
    
    public func isDroppableScenarioObjectType(_ soType : SOType) -> Bool{
        
        
        //SOPlace.downEdge is ignored on comparing (parameters are ignored)
        if(soType == SOType.bed(SOPlace.upperLeft) || soType == SOType.bed(SOPlace.upEdge) || soType == SOType.bed(SOPlace.upperRight) || soType == SOType.desk(SOPlace.upperRight) || soType == SOType.desk(SOPlace.rightEdge) || soType == SOType.desk(SOPlace.lowerRight)){
            
            return true
            
        }
    
        return false
        
    }
    
    public func setSelectedCharacterTo(character: Character){
        
        self.selectedCharacter = character
        
    }
    
    public func removeObject(at : Location){

        objects[at.getY()][at.getX()] = ObjectType.blank
        print("[Model] object removed from map")
        NotificationCenter.default.post(name: Notification.Name("OBJECT_REMOVED_FROM"), object: nil, userInfo: ["location" : at])
    }

    
    public func someoneIsGettingObjectAt(location: Location) -> Bool{

        for y in 0 ..< characters.count{
            
            for x in 0 ..< characters[y].count{
                
                if(characters[y][x] != nil){
                    
                    
                    if(characters[y][x]!.gettingObjectLocation() != nil){
                        
                        if(characters[y][x]!.gettingObjectLocation()!.getX() == location.getX() && characters[y][x]!.gettingObjectLocation()!.getY() == location.getY()){
                    
                            return true
                        
                        }
                        
                    }
                    
                }
            }
            
        }
        
        return false
        
    }
    
    public func isThereACleanerAround(location: Location, forObject object: ObjectType) -> Bool{
        
        let bottom = Location(x: location.getX(),y: location.getY()+1)
        let bottomLeft = Location(x: location.getX()-1, y: location.getY()+1)
        let left = Location(x: location.getX()-1,y: location.getY())
        let topLeft = Location(x: location.getX()-1,y: location.getY()-1)
        let top = Location(x: location.getX(),y: location.getY()-1)
        let topRight = Location(x: location.getX()+1,y: location.getY()-1)
        let right = Location(x: location.getX()+1,y: location.getY())
        let bottomRight = Location(x: location.getX()+1, y: location.getY()+1)
        
        let nearLocations = [bottom,bottomLeft,left,topLeft,top,topRight,right,bottomRight]
        var nearValidLocations = Array<Location>()
        var objectCleanRelations = Array<CleanRelation>()
        
        //get valid locations
        for location in nearLocations{
            
            if(isValidLocation(location)){
                
                nearValidLocations.append(location)
                
            }
            
        }
        
        for relation in cleanRelations{
            
            if (relation.objectToBeCleaned == object){
                
                objectCleanRelations.append(relation)
                
            }
            
        }
        
        for location in nearValidLocations{
            
            for relation in objectCleanRelations{
            
                
                if(relation.scenarioObjectCleaner != nil && exists(scenarioObjectType: relation.scenarioObjectCleaner!, at: location)){
                
                    return true
                
                }
                
                if(relation.objectCleaner != nil && exists(objectType: relation.objectCleaner!, at: location)){
                    
                    return true
                    
                }
            
            }
            
        }
        
        return false
        
    }
    
    public func setSelectedHand(handEnum : Hand){
        
        selectedHand = handEnum
        
    }
    
    public func removeSelectedHand(){
        
        selectedHand = nil
        
    }
    
    public func isACleanerOf(cleanerObject cleaner: ObjectType, toBeCleanedObject cleaned: ObjectType) -> Bool{
        
        for relation in cleanRelations{
    
            if (relation.objectCleaner != nil && relation.objectToBeCleaned == cleaned && relation.objectCleaner! == cleaner){
                return true
            }
            
        }
        
        return false
        
    }
    
    public func isACleanerOf(cleanerScenarioObject cleaner: SOType, toBeCleanedObject cleaned: ObjectType) -> Bool{
        
        for relation in cleanRelations{
            
            if (relation.scenarioObjectCleaner != nil && relation.objectToBeCleaned == cleaned && relation.scenarioObjectCleaner! == cleaner){
                return true
            }
            
        }
        
        return false
        
    }

    public func exists(scenarioObjectType : SOType, at: Location) -> Bool{
        
        
        if(scenarioObjectsTypeMap[at.getY()][at.getX()] == scenarioObjectType){
            
            return true
            
        }

        return false
        
    }
    
    public func exists(objectType : ObjectType, at: Location) -> Bool{
        
        
        if(objects[at.getY()][at.getX()] == objectType){
            
            return true
            
        }
        
        return false
        
    }

}
