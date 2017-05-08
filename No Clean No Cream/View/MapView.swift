import Foundation
import SpriteKit

public class MapView : SKNode{
    
    var backgroundMap = Array<Array<Tile>>()
    var scenarioObjects = Array<Array<ScenarioObjectView?>>()
    var objects = Array<Array<ObjectView?>>()
    var characters = Array<Array<CharacterView?>>()
    let blockSize = CGSize(width: Config.BLOCK_WIDTH, height: Config.BLOCK_HEIGHT)
    var selectedCharacter : CharacterView?
    
    private var selectedDraggingGhostObject : ObjectView?
    private var selectedDraggingObject : ObjectView?
    
    public func userSelectedObject(objectView object : ObjectView){
    
        selectedDraggingObject = object
        
        selectedDraggingObject!.draw().alpha = 0.1
        
        selectedDraggingGhostObject = object.copy()
        selectedDraggingGhostObject!.draw().size.height = object.draw().size.height*1.5
        selectedDraggingGhostObject!.draw().size.width = object.draw().size.width*1.5
        selectedDraggingGhostObject!.draw().alpha = 0.5
        selectedDraggingGhostObject!.draw().zPosition = 6
        
    }
    
    public func dropDraggedObject(){
        selectedDraggingObject!.draw().alpha = 1
        selectedDraggingGhostObject!.draw().removeFromParent()
        selectedDraggingObject = nil
        selectedDraggingGhostObject = nil
        
    }
    
    public func userIsDraggingObject() -> Bool{
        
        if(selectedDraggingObject != nil && selectedDraggingObject != nil){
            
            return true
            
        }
        
        return false
        
    }
    
    public func getSelectedDraggingObject() -> ObjectView?{
        
        return selectedDraggingObject
        
    }
    
    public func getSelectedDraggingGhostObject() -> ObjectView?{
        
        return selectedDraggingGhostObject
        
    }
    
    public func userDeselectedObject(){
        
        selectedDraggingObject = nil
        selectedDraggingGhostObject = nil
        
    }
    
    public init(backgroundMap: Array<Array<TileType>>){
        
        super.init()
        self.addBackgroundMap(bgMap: backgroundMap)
        self.startEmptyScenarioObjectsMap()
        self.startEmptyObjectsMap()
        self.startEmptyCharactersMap()
    
    }
    
    private func startEmptyScenarioObjectsMap(){
        
        for y in 0 ..< Config.MAP_HEIGHT{
            
            scenarioObjects.append(Array<ScenarioObjectView?>())
            
            for _ in 0 ..< Config.MAP_WIDTH{
                
                scenarioObjects[y].append(nil)
                
            }
            
        }
        
    }
    
    private func startEmptyObjectsMap(){
        
        for y in 0 ..< Config.MAP_HEIGHT{
            
            objects.append(Array<ObjectView?>())
            
            for _ in 0 ..< Config.MAP_WIDTH{
                
                objects[y].append(nil)
                
            }
            
        }
        
    }
    
    private func startEmptyCharactersMap(){
        
        for y in 0 ..< Config.MAP_HEIGHT{
            
            characters.append(Array<CharacterView?>())
            
            for _ in 0 ..< Config.MAP_WIDTH{
        
                characters[y].append(nil)
                
            }
       
        }
        
    }
    
    private func addBackgroundMap(bgMap: Array<Array<TileType>>){
        
        for y in 0 ..< bgMap.count{
            
            backgroundMap.append(Array<Tile>())
            
            for x in 0 ..< bgMap[y].count{
                var tile : Tile?
                
                switch(bgMap[y][x]){
                    
                case .floor:
                    tile = Floor()
                    
                    
                case .wall(let aPlace):
                    tile = Wall(place: aPlace)
                 
                case .door(let aPlace):
                    tile = Door(place: aPlace)

                    
                }
                
                if(tile == nil){
                    
                    print("[Error] MapView.addBackgroundMap: undefined tile")
                    
                }else{
                
                    backgroundMap[y].append(tile!)
                
                }
            }
            
        }
        
        
        for y in 0 ..< bgMap.count{
            
            for x in 0 ..< bgMap[y].count{
                
                let yInverted = (bgMap.count-1)-y
                addBlockAt(spriteNode: backgroundMap[y][x].draw(), x: x, y: yInverted, zPosition: 0)
                
            }
            
        }
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{

            let locationTileTouched = getTileAtLocation(viewX: touch.location(in: self).x, viewY: touch.location(in: self).y)
            let x = locationTileTouched!.getX()
            let y = locationTileTouched!.getY()
            
            highlightTile(x: x, y: y)
            
            if(selectedCharacter == nil){
                
                let yInverted = Config.MAP_HEIGHT-1-y
                if(characters[yInverted][x] != nil){
                    
                    //selected a character
                    selectedCharacter = characters[yInverted][x]
                    
                    return
                    
                }

                
            }else{
                
                let yInverted = Config.MAP_HEIGHT-1-y
                if(characters[yInverted][x] != nil){
                    
                    print("[View] selecionou o mesmo/outro personagem")
                    //selected a different character
                    selectedCharacter = characters[yInverted][x]
                    
                    return
                }
                
                if(objects[y][x] != nil){
                    print("[View] mandou personagem pegar o objeto")
                    //character must get the object
                    return
                }
                
                if(scenarioObjects[y][x] != nil){
                    print("[View] mandou personagem interagir com objeto de cenário")
                    
                    return
                    
                }
                
                
            }
            
            
        }
        
    }
    
    public func getTileAtLocation(viewX: CGFloat, viewY: CGFloat)-> Location?{
        
        
        
        for y in 0 ..< backgroundMap.count{
            
            
            for x in 0 ..< backgroundMap[y].count{
                
                if(backgroundMap[y][x].draw().contains(CGPoint(x: viewX, y: viewY))){
                    
                    return Location(x: x, y: y)
                
                }

            }
        }
        
        return nil
        
    }
    
    private func highlightTile(x: Int, y: Int){
        
        let seq = SKAction.sequence([SKAction.colorize(withColorBlendFactor: 0.3, duration: 0.4),SKAction.colorize(withColorBlendFactor: 0, duration: 0.4)])
        backgroundMap[y][x].draw().run(seq)
        
    }
    
    public func add(scenarioObjectsMap scenObjectsMap: Array<Array<SOType>>){
    
      
        
        for y in 0 ..< scenObjectsMap.count{
            
            scenarioObjects.append(Array<ScenarioObjectView?>())
            
            for x in 0 ..< scenObjectsMap[y].count{
                
                if(scenarioObjects[y][x] != nil){
                    
                    scenarioObjects[y][x]!.draw().removeFromParent()
                    scenarioObjects[y][x] = nil
                    
                }
                
                var scenObj : ScenarioObjectView?
                
                switch(scenObjectsMap[y][x]){
                    
                case .blank:                        scenObj = nil
                    
                case .bed(SOPlace.centerSprite):    scenObj = Bed(isOrganized: false, place: SOPlace.centerSprite)
                case .bed(SOPlace.downEdge):        scenObj = Bed(isOrganized: false, place: SOPlace.downEdge)
                case .bed(SOPlace.leftEdge):        scenObj = Bed(isOrganized: false, place: SOPlace.leftEdge)
                case .bed(SOPlace.lowerLeft):       scenObj = Bed(isOrganized: false, place: SOPlace.lowerLeft)
                case .bed(SOPlace.lowerRight):      scenObj = Bed(isOrganized: false, place: SOPlace.lowerRight)
                case .bed(SOPlace.rightEdge):       scenObj = Bed(isOrganized: false, place: SOPlace.rightEdge)
                case .bed(SOPlace.upEdge):          scenObj = Bed(isOrganized: false, place: SOPlace.upEdge)
                case .bed(SOPlace.upperLeft):       scenObj = Bed(isOrganized: false, place: SOPlace.upperLeft)
                case .bed(SOPlace.upperRight):      scenObj = Bed(isOrganized: false, place: SOPlace.upperRight)
                    
                    
                case .desk(SOPlace.centerSprite):    scenObj = Desk(isOrganized: false, place: SOPlace.centerSprite)
                case .desk(SOPlace.downEdge):        scenObj = Desk(isOrganized: false, place: SOPlace.downEdge)
                case .desk(SOPlace.leftEdge):        scenObj = Desk(isOrganized: false, place: SOPlace.leftEdge)
                case .desk(SOPlace.lowerLeft):       scenObj = Desk(isOrganized: false, place: SOPlace.lowerLeft)
                case .desk(SOPlace.lowerRight):      scenObj = Desk(isOrganized: false, place: SOPlace.lowerRight)
                case .desk(SOPlace.rightEdge):       scenObj = Desk(isOrganized: false, place: SOPlace.rightEdge)
                case .desk(SOPlace.upEdge):          scenObj = Desk(isOrganized: false, place: SOPlace.upEdge)
                case .desk(SOPlace.upperLeft):       scenObj = Desk(isOrganized: false, place: SOPlace.upperLeft)
                case .desk(SOPlace.upperRight):      scenObj = Desk(isOrganized: false, place: SOPlace.upperRight)
                    
                    
                case .closet(SOPlace.centerSprite):    scenObj = Closet(isOrganized: false, place: SOPlace.centerSprite)
                case .closet(SOPlace.downEdge):        scenObj = Closet(isOrganized: false, place: SOPlace.downEdge)
                case .closet(SOPlace.leftEdge):        scenObj = Closet(isOrganized: false, place: SOPlace.leftEdge)
                case .closet(SOPlace.lowerLeft):       scenObj = Closet(isOrganized: false, place: SOPlace.lowerLeft)
                case .closet(SOPlace.lowerRight):      scenObj = Closet(isOrganized: false, place: SOPlace.lowerRight)
                case .closet(SOPlace.rightEdge):       scenObj = Closet(isOrganized: false, place: SOPlace.rightEdge)
                case .closet(SOPlace.upEdge):          scenObj = Closet(isOrganized: false, place: SOPlace.upEdge)
                case .closet(SOPlace.upperLeft):       scenObj = Closet(isOrganized: false, place: SOPlace.upperLeft)
                case .closet(SOPlace.upperRight):      scenObj = Closet(isOrganized: false, place: SOPlace.upperRight)
                    
                    
                case .toyBox(SOPlace.centerSprite):    scenObj = ToyBox(isOrganized: true, place: SOPlace.centerSprite)
                case .toyBox(SOPlace.downEdge):        scenObj = ToyBox(isOrganized: true, place: SOPlace.downEdge)
                case .toyBox(SOPlace.leftEdge):        scenObj = ToyBox(isOrganized: true, place: SOPlace.leftEdge)
                case .toyBox(SOPlace.lowerLeft):       scenObj = ToyBox(isOrganized: true, place: SOPlace.lowerLeft)
                case .toyBox(SOPlace.lowerRight):      scenObj = ToyBox(isOrganized: true, place: SOPlace.lowerRight)
                case .toyBox(SOPlace.rightEdge):       scenObj = ToyBox(isOrganized: true, place: SOPlace.rightEdge)
                case .toyBox(SOPlace.upEdge):          scenObj = ToyBox(isOrganized: true, place: SOPlace.upEdge)
                case .toyBox(SOPlace.upperLeft):       scenObj = ToyBox(isOrganized: true, place: SOPlace.upperLeft)
                case .toyBox(SOPlace.upperRight):      scenObj = ToyBox(isOrganized: true, place: SOPlace.upperRight)
                    
                }
                
                if (scenObj != nil){
            
                    scenarioObjects[y][x] = scenObj!

                }else{
                    scenarioObjects[y][x] = nil
                }
                
                
            }
            
        }
        
        for y in 0 ..< scenarioObjects.count{
            
            for x in 0 ..< scenarioObjects[y].count{
                
                if(scenarioObjects[y][x] != nil){
                    
                    let yInverted = (scenObjectsMap.count-1)-y
                    addBlockAt(spriteNode: scenarioObjects[y][x]!.draw(), x: x, y: yInverted, zPosition: 1)
                    
                }
                
            }
            
        }
        
    }
    
    public func createObjectViewFrom(objectType: ObjectType) -> ObjectView?{
    
        switch(objectType){
            case .ball: return Ball()
            case .dump: return Dump()
            case .clothing: return Clothing()
            case .dirt: return Dirt()
            case .broomStick: return BroomStick()
            case .toy: return Toy()
        default: return nil
        }
    }
    
    public func add(object: ObjectType, at: Location){
    
        if(objects[at.getY()][at.getX()] == nil){
            
            let obj = createObjectViewFrom(objectType: object)
                
            if (obj != nil){
            
                objects[at.getY()][at.getX()] = obj!
                let yInverted = (objects.count-1)-at.getY()
                addBlockAt(spriteNode: objects[at.getY()][at.getX()]!.draw(), x: at.getX(), y: yInverted, zPosition: 2)
            
            }else{
                
                objects[at.getY()][at.getX()] = nil
                
            }
            
        }else{
            
            print("[Error] Can't add object type \(object) to place X: \(at.getX()) Y: \(at.getY()). Location already occupied")

        }
        
    }
    
    private func add(objectsMap: Array<Array<ObjectType>>){
        
        for y in 0 ..< objectsMap.count{
            
            objects.append(Array<ObjectView?>())
            
            for x in 0 ..< objectsMap[y].count{
                var obj : ObjectView?
                
                switch(objectsMap[y][x]){
                    
                case .blank: obj = nil
                case .ball: obj = Ball()
                case .dump: obj = Dump()
                case .clothing: obj = Clothing()
                case .dirt: obj = Dirt()
                case .broomStick: obj = BroomStick()
                case .toy: obj = Toy()
                default: obj = nil
                }
                
                if (obj != nil){
                    objects[y][x] = obj!
                }else{
                    objects[y][x] = nil
                }
                
                
            }
            
        }
        
        for y in 0 ..< objectsMap.count{
            
            for x in 0 ..< objectsMap[y].count{
                
                if(objects[y][x] != nil){
                    
                    let yInverted = (objectsMap.count-1)-y
                    addBlockAt(spriteNode: objects[y][x]!.draw(), x: x, y: yInverted, zPosition: 2)
                    
                }
            }
            
        }
        
    }
    
    public func add(character: CharacterView, location : Location){
        
        let x = location.getX()
        let y = Config.MAP_HEIGHT - location.getY() - 1
        
        characters[y][x] = character
        addBlockAt(spriteNode: character.draw(), x: x, y: y,  zPosition: 3)
        character.setLocation(Location(x: x, y: y))
        
        
    }

    
    private func addBlockAt(spriteNode : SKSpriteNode, x: Int, y: Int, zPosition: Int){

        let sceneX = CGFloat(x*Config.BLOCK_WIDTH)+CGFloat(self.position.x+CGFloat(Config.BLOCK_WIDTH/2))
        let sceneY = CGFloat(y*Config.BLOCK_HEIGHT)+CGFloat(self.position.y+CGFloat(Config.BLOCK_HEIGHT/2))

        spriteNode.size = CGSize(width: Config.BLOCK_WIDTH, height: Config.BLOCK_HEIGHT)
        spriteNode.position = CGPoint(x: sceneX, y: sceneY)
        spriteNode.zPosition = CGFloat(zPosition)
        self.addChild(spriteNode)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCharacterLocation(fromTile: Location, toTile: Location){
        
        
        characters[toTile.getY()][toTile.getX()] = characters[fromTile.getY()][fromTile.getX()]
        characters[fromTile.getY()][fromTile.getX()] = nil
        
    }

    public func removeObjectFrom(location: Location){
        
        let objRemoved = objects[location.getY()][location.getX()]
        objects[location.getY()][location.getX()] = nil
        
        objRemoved!.draw().removeFromParent()
        
    }
    
    public func addDraggingGhost(object: ObjectType){
        
        let obj = createObjectViewFrom(objectType: object)
        
    }
    
    public func organize(scenarioObject: ScenarioObject){
        
        for tile in scenarioObject.getOccupiedLocations(){

            let y = Config.MAP_HEIGHT-tile.key.getY()-1
            let x = tile.key.getX()
            
            if(scenarioObjects[y][x] != nil){
                
                let scenarioObjectView = scenarioObjects[y][x]!
                scenarioObjectView.organizeIt()
                
            }
            
        }
        
    }
    
}
