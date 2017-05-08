import Foundation


public class Character: Element {

    private var name : String
    private var height : Int
    private var strength : Int
    private var speed : Speed
    private var walking : Bool
    private var gettingObjectAt : Location?
    private var leftHand : ObjectType?
    private var rightHand : ObjectType?
    private var chatBalloon : ChatBalloon?
    private var isHighlighted : Bool

    public init(name : String, height : Int, strength : Int, speed : Speed, x : Int, y : Int){
        
        self.name = name
        self.height = height
        self.strength = strength
        self.speed = speed
        self.walking = false
        self.gettingObjectAt = nil
        self.leftHand = nil
        self.rightHand = nil
        self.chatBalloon = nil
        self.isHighlighted = false
        super.init(location: Location(x: x,y: y))
        self.chatBalloon = ChatBalloon(character: self)
        
    }
    
    public func addHighlight() {
        
        self.isHighlighted = true
        NotificationCenter.default.post(name: Notification.Name("ADD_HIGHLIGHT_CHARACTER"), object: nil, userInfo: ["character" : self])
        
        
    }
    
    public func removeHighlight(){
        
        self.isHighlighted = false
        NotificationCenter.default.post(name: Notification.Name("REMOVE_HIGHLIGHT_CHARACTER"), object: nil, userInfo: ["character" : self])
        
        
    }
    
    public func getChatBalloon() -> ChatBalloon{
        
        return chatBalloon!
        
    }
    
    public func gettingObjectLocation()-> Location?{
        
        return gettingObjectAt
        
    }
    
    public func startWalking() {
        
        self.walking = true
        
    }
    
    public func isWalking() -> Bool {
        
        return walking
        
    }
    
    public func stopWalking() {
        
        self.walking = false
        
    }
    
    public func getName() -> String{
        
        return name
        
    }
    
    public func getSpeed() -> Speed{
        
        return speed
        
    }
    
    public override func setLocation(_ location : Location){
        
        super.setLocation(location)
        
        
    }
    
    public func goTo(_ location : Location) -> Bool{
    
        if let path = Map.instance.buildPath(from: self.getLocation(), to: location){
            print("Encontrou caminho")
            self.startWalking()
            goThroughPath(path: path, index: 0)
            return true
            
        }
        else{
            
            print("The character \(name) can't go to location [\(location.getX()),\(location.getY())]: There is no path to follow")

            return false
        
        }

        
    }
    
    public func goTo(x: Int, y: Int) -> Bool{
        
        let location = Location(x:x,y:y)
        
        return goTo(location)
        
    }
    
    public func get(object: ObjectType, objectLocation: Location, nearLocation location: Location){
        
        print("getObject")
        if(location.getX() != self.getLocation().getX() || location.getY() != self.getLocation().getY()){
            
            goToThenGet(destineLocation: location, objectLocation: objectLocation)
            
        }else{
            
            getNearObject(objectLocation: objectLocation)
            gettingObjectAt = nil
            
        }
        
    }
    
    public func goToThenGet(destineLocation: Location, objectLocation: Location) -> Bool{

        if let path = Map.instance.buildPath(from: self.getLocation(), to: destineLocation){

            self.gettingObjectAt = objectLocation

            self.startWalking()
            goThroughPathThenGet(path: path, index: 0,objectLocation: objectLocation)
            return true
            
        }
        else{
            
            print("The character \(name) can't go to location [\(destineLocation.getX()),\(destineLocation.getY())]: There is no path to follow")
            return false
            
        }
        
        
    }
    
    public func dropNear(handEnum: Hand, nearLocation location: Location){
        
        if(location.getX() != self.getLocation().getX() || location.getY() != self.getLocation().getY()){
            
            goToThenDrop(handEnum: handEnum, destineLocation: location, objectDestineLocation: nil)
            
        }else{
            
            dropAtNearLocation(handEnum: handEnum)
            
        }
        
    }
    
    public func drop(handEnum: Hand, charNearDestineLocation: Location, objectDestineLocation: Location){
        
        if(charNearDestineLocation.getX() != self.getLocation().getX() || charNearDestineLocation.getY() != self.getLocation().getY()){
            
            goToThenDrop(handEnum: handEnum, destineLocation: charNearDestineLocation, objectDestineLocation: objectDestineLocation)
            
        }else{
            
            dropAtLocation(handEnum: handEnum, location: objectDestineLocation)
            
        }
        
    }
    
    public func goToThenDrop(handEnum: Hand, destineLocation location: Location, objectDestineLocation: Location?) -> Bool{
        
        if let path = Map.instance.buildPath(from: self.getLocation(), to: location){
            
            self.startWalking()
            
            if(objectDestineLocation != nil){
            
                goThroughPathThenDrop(path: path, index: 0, handToDrop: handEnum, specificLocation: objectDestineLocation)
                
            }else{
               
                 goThroughPathThenDrop(path: path, index: 0, handToDrop: handEnum, specificLocation: nil)
                
            }

            return true
            
        }
        else{
            
            print("The character \(name) can't go to location [\(location.getX()),\(location.getY())]: There is no path to follow")
            return false
            
        }
        
        
    }
    
    
    public func organize(scenarioObject: ScenarioObject, charNearDestineLocation: Location){
        
        if(charNearDestineLocation != self.getLocation()){
            
            goToThenOrganize(scenarioObject: scenarioObject, destineLocation: charNearDestineLocation)
            
        }else{
            
            scenarioObject.organizeIt()
            
        }
        
    }
    
    public func goToThenOrganize(scenarioObject: ScenarioObject, destineLocation : Location) -> Bool{
    
        if let path = Map.instance.buildPath(from: self.getLocation(), to: destineLocation){
            
            self.startWalking()
            goThroughPathThenOrganize(path : path, index: 0, scenarioObject: scenarioObject)
            return true
            
        }
        else{
            
            print("The character \(name) can't go to location [\(destineLocation.getX()),\(destineLocation.getY())]: There is no path to follow")
            return false
            
        }
        
    }
    
    private func getNearObject(objectLocation: Location){
        print("getNearObject")

        if (leftHand != nil){
            
                    print("x1")
            let objectAtLocation = Map.instance.getObjectAtLocation(objectLocation)
            
            if(objectAtLocation == nil){
                
                return
                
            }
        
            let leftHandIsCleaner = Map.instance.isACleanerOf(cleanerObject: leftHand!, toBeCleanedObject: objectAtLocation!)
            
            if(leftHandIsCleaner){
                
                NotificationCenter.default.post(name: Notification.Name("SUM_POINTS_OBJECT"), object: nil, userInfo: ["object" : objectAtLocation!])
                
                
                Map.instance.removeObject(at: objectLocation)
            
                return
            }
            
        }
        
        if (rightHand != nil){
            
            
            let objectAtLocation = Map.instance.getObjectAtLocation(objectLocation)
            
            if(objectAtLocation == nil){
                
                return
                
            }
            
            let rightHandIsCleaner = Map.instance.isACleanerOf(cleanerObject: rightHand!, toBeCleanedObject: objectAtLocation!)
            
            if(rightHandIsCleaner){
                
                NotificationCenter.default.post(name: Notification.Name("SUM_POINTS_OBJECT"), object: nil, userInfo: ["object" : objectAtLocation])
                
                Map.instance.removeObject(at: objectLocation)
                return
                
            }
        }
        
        if (leftHand == nil) {
        
            leftHand = Map.instance.getObjectAtLocation(objectLocation)
            print("\(leftHand)")
            NotificationCenter.default.post(name: Notification.Name("OBJECT_TAKEN"), object: nil, userInfo: ["character" : self])
        
            Map.instance.removeObject(at: objectLocation)
        
        }
        else if (rightHand == nil) {
        
            rightHand = Map.instance.getObjectAtLocation(objectLocation)
            
            NotificationCenter.default.post(name: Notification.Name("OBJECT_TAKEN"), object: nil, userInfo: ["character" : self])
            
            Map.instance.removeObject(at: objectLocation)
            
        }
        else {
        
            print("[Error] Character can't get more objects")
        
        }
    
    }
    
    public func getLeftHand() -> ObjectType?{
        
        return leftHand
        
    }
    
    public func getRightHand() -> ObjectType?{
        
        return rightHand
        
    }

    public func getNearLocation(_ location : Location) -> Location?{
        
        var isOnTop = false
        var isOnLeft = false
        
        var xDest : Int
        var yDest : Int
        
        if(Map.instance.isNearLocation(from: self.getLocation(), to: location)){
            
            return self.getLocation()
            
        }
        
        if(location.getY() < self.getLocation().getY()){
            
            isOnTop = true
            
        }
        
        if(location.getX() < self.getLocation().getX()){
            
            isOnLeft = true
            
        }
        
        var destLocation : Location?
        
        if(isOnTop){
            
                destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX(),y: location.getY()+1))
            
        }else if(isOnLeft){
            
            destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX()+1,y: location.getY()))
            
        }else{
            
            destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX()-1,y: location.getY()))
        
        }
        
        
        if(destLocation == nil){
            
            
            print("[Error] No free near location to get the object")
            
        }
        
        return destLocation
        
        
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
    
    
    public func getNearLocation(_ locations : Array<Location>) -> Location?{
        print("kk1")
        var isOnTop = false
        var isOnLeft = false
        
        var xDest : Int
        var yDest : Int
        
        var nearestLocation : Location?
        var actualDistance = 0
        print("kk2")
            for location in locations{
                print("kk3l6")
                print("locations size: \(locations.count)")
                if(Map.instance.isNearLocation(from: self.getLocation(), to: location)){
                    
                    return self.getLocation()
                    
                }
                
                if(location.getY() < self.getLocation().getY()){
                    
                    isOnTop = true
                    
                }
                
                if(location.getX() < self.getLocation().getX()){
                    
                    isOnLeft = true
                    
                }
                
                var destLocation : Location?
                
                if(isOnTop){
                    
                    destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX(),y: location.getY()+1))
                    
                }else if(isOnLeft){
                    
                    destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX()+1,y: location.getY()))
                    
                }else{
                    
                    destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX()-1,y: location.getY()))
                    
                }
                
                if(destLocation != nil){
                    
                    print("kk4")
                    if(nearestLocation == nil){
                        
                        print("kk5")
                        nearestLocation = destLocation
                        actualDistance = getDistance(from: self.getLocation(), to: nearestLocation!)
                        
                    }else{
                        
                        print("kk6")
                        var distanceBeingVerified = getDistance(from: self.getLocation(), to: location)
            
                        if(distanceBeingVerified < actualDistance){
            
                            nearestLocation = location
                            actualDistance = distanceBeingVerified
                            
                        }
                        
                    }
                    
                }
            }
        
        
        if(nearestLocation == nil){
            
            
            print("[Error] No free near location to get the object")
            
        }
    
        return nearestLocation!
        
        
    }
    
    public func getNearLocationToDrop(_ locations : Array<Location>) -> Array<Location?>{
        print("kk1")
        var isOnTop = false
        var isOnLeft = false
        
        var xDest : Int
        var yDest : Int
        
        var objectLocation : Location?
        var nearestLocation : Location?
        var actualDistance = 0
        print("kk2")
        for location in locations{
            print("kk3l6")
            print("locations size: \(locations.count)")
            if(Map.instance.isNearLocation(from: self.getLocation(), to: location)){
                
                var returnArray = Array<Location?>()
                returnArray.append(location)
                returnArray.append(self.getLocation())
                return returnArray
                
            }
            
            if(location.getY() < self.getLocation().getY()){
                
                isOnTop = true
                
            }
            
            if(location.getX() < self.getLocation().getX()){
                
                isOnLeft = true
                
            }
            
            var destLocation : Location?
            
            if(isOnTop){
                
                destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX(),y: location.getY()+1))
                
            }else if(isOnLeft){
                
                destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX()+1,y: location.getY()))
                
            }else{
                
                destLocation = Map.instance.getNearLocation(of: location, beginningAt: Location(x: location.getX()-1,y: location.getY()))
                
            }
            
            if(destLocation != nil){
                
                print("kk4")
                if(nearestLocation == nil){
                    
                    objectLocation = location
                    nearestLocation = destLocation
                    actualDistance = getDistance(from: self.getLocation(), to: nearestLocation!)
                    
                }else{
                    
                    var distanceBeingVerified = getDistance(from: self.getLocation(), to: location)
                    
                    if(distanceBeingVerified < actualDistance){
                        
                        objectLocation = location
                        nearestLocation = location
                        actualDistance = distanceBeingVerified
                        
                    }
                    
                }
                
            }
        }
        
        
        if(nearestLocation == nil){
            
            
            print("[Error] No free near location to get the object")
            
        }
        
        
        var returnArray = Array<Location?>()
        returnArray.append(objectLocation)
        returnArray.append(nearestLocation)
        return returnArray
        
        
    }

    private func goThroughPath(path : Array<Location>,index i: Int){
    
        let actualX = self.getLocation().getX()
        let actualY = self.getLocation().getY()
    
        if(i == path.count){
            self.stopWalking()
            return
        }
        
        self.setLocation(Location(x: path[i].getX(),y: path[i].getY()))
        
        self.stopWalking()

        NotificationCenter.default.post(name: Notification.Name("CHARACTER_MOVED"), object: nil, userInfo: ["character" : self])
        self.startWalking()
        
        var when = DispatchTime.now()
        
        switch speed{
            
        case .slow:
            when =  DispatchTime.now() + 1.5
            
        case .medium:
            when =  DispatchTime.now() + 1
            
        case .fast:
            when =  DispatchTime.now() + 0.5
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.goThroughPath(path: path, index: i+1)
        
        }
        
        
    }
    
    private func goThroughPathThenGet(path : Array<Location>,index i: Int,objectLocation: Location){
        
        let actualX = self.getLocation().getX()
        let actualY = self.getLocation().getY()
        
        print("Char position: [\(actualX),\(actualY)]")
        
        if(i == path.count){
            self.stopWalking()
            getNearObject(objectLocation: objectLocation)
            gettingObjectAt = nil
            return
        }
        
        self.setLocation(Location(x: path[i].getX(),y: path[i].getY()))
        
        self.stopWalking()

        NotificationCenter.default.post(name: Notification.Name("CHARACTER_MOVED"), object: nil, userInfo: ["character" : self])
        self.startWalking()
        
        var when = DispatchTime.now()
        
        switch speed{
            
        case .slow:
            when =  DispatchTime.now() + 1.5
            
        case .medium:
            when =  DispatchTime.now() + 1
            
        case .fast:
            when =  DispatchTime.now() + 0.5
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.goThroughPathThenGet(path: path, index: i+1, objectLocation: objectLocation)
            
        }
        
        
        
    }
    
    public func goThroughPathThenDrop(path : Array<Location>,index i: Int,handToDrop: Hand, specificLocation: Location?){
        
        let actualX = self.getLocation().getX()
        let actualY = self.getLocation().getY()
        
        if(i == path.count){
            self.stopWalking()
            
            if(leftHand != nil && handToDrop == Hand.left){
                
                if(specificLocation != nil){
                    
                    dropAtLocation(handEnum: Hand.left, location: specificLocation!)
                    
                }else{
                    
                    dropAtNearLocation(handEnum: Hand.left)
                
                }
            }else if(rightHand != nil && handToDrop == Hand.right){
                
                if(specificLocation != nil){
                    
                    dropAtLocation(handEnum: Hand.right, location: specificLocation!)
                    
                }else{
                    
                    dropAtNearLocation(handEnum: Hand.right)
                
                }
            }
            
            gettingObjectAt = nil
            return
        }
        
        self.setLocation(Location(x: path[i].getX(),y: path[i].getY()))
        
        self.stopWalking()
        NotificationCenter.default.post(name: Notification.Name("CHARACTER_MOVED"), object: nil, userInfo: ["character" : self])
        self.startWalking()
        
        var when = DispatchTime.now()
        
        switch speed{
            
        case .slow:
            when =  DispatchTime.now() + 1.5
            
        case .medium:
            when =  DispatchTime.now() + 1
            
        case .fast:
            when =  DispatchTime.now() + 0.5
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.goThroughPathThenDrop(path: path, index: i+1, handToDrop: handToDrop, specificLocation: specificLocation)
            
        }
        
        
        
    }
    
    private func goThroughPathThenOrganize(path : Array<Location>,index i: Int, scenarioObject: ScenarioObject){
        
        let actualX = self.getLocation().getX()
        let actualY = self.getLocation().getY()
        
        if(i == path.count){
            self.stopWalking()
            print("v2")
            scenarioObject.organizeIt()
            gettingObjectAt = nil
            
            NotificationCenter.default.post(name: Notification.Name("SUM_POINTS_SCENARIO_OBJECT"), object: nil, userInfo: ["scenarioObject" : scenarioObject])
            
            return
        }
        
        self.setLocation(Location(x: path[i].getX(),y: path[i].getY()))
        
        self.stopWalking()
        
        NotificationCenter.default.post(name: Notification.Name("CHARACTER_MOVED"), object: nil, userInfo: ["character" : self])
        self.startWalking()
        
        var when = DispatchTime.now()
        
        switch speed{
            
        case .slow:
            when =  DispatchTime.now() + 1.5
            
        case .medium:
            when =  DispatchTime.now() + 1
            
        case .fast:
            when =  DispatchTime.now() + 0.5
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.goThroughPathThenOrganize(path: path, index: i+1, scenarioObject: scenarioObject)
            
        }
        
        
        
    }

    
    private func organize(scenarioObject obj : ScenarioObject){
        
        if(obj.canBeOrganized()){
            
            obj.organizeIt()
            
        }
        
    }
    
    public func dropAtNearLocation(handEnum: Hand){
        
        if(handEnum == Hand.left && self.getLeftHand() != nil){
            
            if(Map.instance.isThereACleanerAround(location: self.getLocation(), forObject: self.getLeftHand()!)){
                
                print("deixou o objeto no limpador próximo (SOMOU PONTOS)")
                NotificationCenter.default.post(name: Notification.Name("SUM_POINTS_OBJECT"), object: nil, userInfo: ["object" : self.getLeftHand()!])
                
                NotificationCenter.default.post(name: Notification.Name("DROP_LEFT_HAND"), object: nil, userInfo: ["character" : self])
                
                leftHand = nil
                
                return
            }
            
            let leftLocation = Location(x : self.getLocation().getX()+1,y: self.getLocation().getY())
            let locationToDrop = Map.instance.getNearLocation(of: self.getLocation(), beginningAt: leftLocation)
            
            if(locationToDrop != nil){
                if(leftHand == nil){
                    
                    print("[Error] at Character.drop: There is no leftHand object")
                    return
                }
            
                let objectStruct = ObjectStruct(type: leftHand!, location: locationToDrop!)
                NotificationCenter.default.post(name: Notification.Name("OBJECT_DROPPED_AT"), object: nil, userInfo: ["objectStruct" : objectStruct])

                NotificationCenter.default.post(name: Notification.Name("DROP_LEFT_HAND"), object: nil, userInfo: ["character" : self])
                
                leftHand = nil
                
            }else{
                
                print("[Error] at Character.drop: there is no free near location to drop the object")
                
            }
            
        }else if(handEnum == Hand.right && self.getRightHand() != nil){
            
            if(Map.instance.isThereACleanerAround(location: self.getLocation(), forObject: self.getRightHand()!)){
                
                print("deixou o objeto no limpador próximo (SOMOU PONTOS)")
                NotificationCenter.default.post(name: Notification.Name("SUM_POINTS_OBJECT"), object: nil, userInfo: ["object" : self.getRightHand()!])
                
                NotificationCenter.default.post(name: Notification.Name("DROP_RIGHT_HAND"), object: nil, userInfo: ["character" : self])
                
                rightHand = nil
                
                return
                
            }
            
            let rightLocation = Location(x : self.getLocation().getX()-1,y: self.getLocation().getY())
            let locationToDrop = Map.instance.getNearLocation(of: self.getLocation(), beginningAt: rightLocation)
            
            if(locationToDrop != nil){
                if(rightHand == nil){
                    
                    print("[Error] at Character.drop: There is no rightHand object")
                    return
                }
                
                let objectStruct = ObjectStruct(type: rightHand!, location: locationToDrop!)
                NotificationCenter.default.post(name: Notification.Name("OBJECT_DROPPED_AT"), object: nil, userInfo: ["objectStruct" : objectStruct])
                
                NotificationCenter.default.post(name: Notification.Name("DROP_RIGHT_HAND"), object: nil, userInfo: ["character" : self])
                
                rightHand = nil
                
            }else{
                
                print("[Error] at Character.drop: there is no free near location to drop the object")
                
            }
            
        }
        
    }
    
    
    public func dropAtLocation(handEnum: Hand, location: Location){
        
        if(handEnum == Hand.left && self.getLeftHand() != nil){

            
            print("location to drop object = x: \(location.getX()) y: \(location.getY())")
            
            let objectStruct = ObjectStruct(type: leftHand!, location: location)
            NotificationCenter.default.post(name: Notification.Name("OBJECT_DROPPED_AT"), object: nil, userInfo: ["objectStruct" : objectStruct])
            
            NotificationCenter.default.post(name: Notification.Name("DROP_LEFT_HAND"), object: nil, userInfo: ["character" : self])
            
            leftHand = nil
        
        }else if(handEnum == Hand.right && self.getRightHand() != nil){
            
            let objectStruct = ObjectStruct(type: rightHand!, location: location)
            NotificationCenter.default.post(name: Notification.Name("OBJECT_DROPPED_AT"), object: nil, userInfo: ["objectStruct" : objectStruct])
            
            NotificationCenter.default.post(name: Notification.Name("DROP_RIGHT_HAND"), object: nil, userInfo: ["character" : self])
            
            rightHand = nil
        
        }

    }


}
