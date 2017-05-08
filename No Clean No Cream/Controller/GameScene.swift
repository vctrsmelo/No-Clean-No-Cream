import Foundation
import SpriteKit
import AVFoundation


public struct CharacterStruct{
    
    var name : String
    var model : Character
    var view : CharacterView
    
}

public struct ObjectStruct{
    
    var type: ObjectType
    var location: Location

}

public class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let mapModel = Map.instance
    var mapView : MapView
    var charactersStruct = Array<CharacterStruct>()
    var objectsStruct = Array<ObjectStruct>()
    var pointsPerObject = Dictionary<ObjectType,Int>()
    var points : Int
    var pointsView : PointsView
    var timerModel : Timer
    var timerView : TimerView
    var firstTouched = false
    var motherModel : Mother
    var motherView : MotherView
    public var audioPlayer = AVAudioPlayer()

    public override init(size: CGSize){
        
        mapView = MapView(backgroundMap: Map.instance.getMapBackground())

        timerView = TimerView()
        timerModel = Timer()
        
        pointsView = PointsView()
        self.points = 0
        
        motherModel = Mother()
        motherView = MotherView()
        
        super.init(size: size)
        
        playSound()
        self.scaleMode = .aspectFit
        self.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.5333333333, blue: 0.568627451, alpha: 1)
        
        
        self.addChild(timerView.draw())
        self.addChild(pointsView.draw())
        self.addChild(motherView.draw())
        
        buildMap()
        self.addChild(mapView)

        NotificationCenter.default.addObserver(self, selector: #selector(self.characterMoved(notification:)), name: Notification.Name("CHARACTER_MOVED"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.objectRemovedFrom(notification:)), name: Notification.Name("OBJECT_REMOVED_FROM"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.objectTaken(notification:)), name: Notification.Name("OBJECT_TAKEN"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.sumPointsObject(notification:)), name: Notification.Name("SUM_POINTS_OBJECT"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.sumPointsScenarioObject(notification:)), name: Notification.Name("SUM_POINTS_SCENARIO_OBJECT"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.characterDroppedLeftHand(notification:)), name: Notification.Name("DROP_LEFT_HAND"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.characterDroppedRightHand(notification:)), name: Notification.Name("DROP_RIGHT_HAND"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addHighlightCharacter(notification:)), name: Notification.Name("ADD_HIGHLIGHT_CHARACTER"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.removeHighlightCharacter(notification:)), name: Notification.Name("REMOVE_HIGHLIGHT_CHARACTER"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addObjectToMap(notification:)), name: Notification.Name("OBJECT_DROPPED_AT"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.scenarioObjectOrganized(notification:)), name: Notification.Name("SCENARIO_OBJECT_ORGANIZED"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showMessageIcon(notification:)), name: Notification.Name("SHOW_CHAT_BALLOON_ICON"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.nextTime(notification:)), name: Notification.Name("NEXT_TIME"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.motherSays(notification:)), name: Notification.Name("MOTHER_MESSAGE"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.motherSaysSomething(notification:)), name: Notification.Name("MOTHER_MESSAGE_SOMETHING"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.gameOver(notification:)), name: Notification.Name("GAME_OVER"), object: nil)
        
    }
    
    public func playSound() {
        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!))
//            audioPlayer.prepareToPlay()
//            audioPlayer.numberOfLoops = -1
//            audioPlayer.volume = 0.4
//            audioPlayer.play()
//        } catch let error {
//            print(error.localizedDescription)
//        }
    }

    private func buildMap(){
        
        
        //define Characters
        
        
        //character 1
            let char1Model = Character(name: "Character 1", height: 2, strength: 2, speed: Speed.fast, x: 5, y: 8)
            let char1View = CharacterView(spriteImage: "char1", name: char1Model.getName())
            
            let char1 = CharacterStruct(name: char1Model.getName(), model: char1Model, view: char1View)

            //character 2
            let char2Model = Character(name: "Character 2", height: 2, strength: 2, speed: Speed.fast, x: 4, y: 8)
            let char2View = CharacterView(spriteImage: "char2", name: char2Model.getName())
            
            let char2 = CharacterStruct(name: char2Model.getName(), model: char2Model, view: char2View)
        
            //character 3
            let char3Model = Character(name: "Character 3", height: 2, strength: 2, speed: Speed.fast, x: 3, y: 8)
            let char3View = CharacterView(spriteImage: "char3", name: char2Model.getName())
            
            let char3 = CharacterStruct(name: char3Model.getName(), model: char3Model, view: char3View)
            
        
        //Define objects
            let ball = ObjectStruct(type: ObjectType.ball, location: Location(x: 3, y: 3))
            let ball2 = ObjectStruct(type: ObjectType.ball, location: Location(x: 8, y: 8))
            let ball3 = ObjectStruct(type: ObjectType.ball, location: Location(x: 0, y: 8))
            let broomStick = ObjectStruct(type: ObjectType.broomStick, location: Location(x: 5, y: 7))
            let dirt1 = ObjectStruct(type: ObjectType.dirt, location: Location(x: 2, y: 11))
            let dirt2 = ObjectStruct(type: ObjectType.dirt, location: Location(x: 6, y: 6))
            let dirt3 = ObjectStruct(type: ObjectType.dirt, location: Location(x: 2, y: 10))
            let dirt4 = ObjectStruct(type: ObjectType.dirt, location: Location(x: 7, y: 10))
            let dirt5 = ObjectStruct(type: ObjectType.dirt, location: Location(x: 5, y: 4))
            let toy1 = ObjectStruct(type: ObjectType.toy, location: Location(x: 4, y: 5))
            let toy2 = ObjectStruct(type: ObjectType.toy, location: Location(x: 9, y: 13))
            let toy3 = ObjectStruct(type: ObjectType.toy, location: Location(x: 4, y: 13))
            let toy4 = ObjectStruct(type: ObjectType.toy, location: Location(x: 8, y: 6))
            let clothing1 = ObjectStruct(type: ObjectType.clothing, location: Location(x: 9, y: 11))
            let clothing2 = ObjectStruct(type: ObjectType.clothing, location: Location(x: 6, y: 12))
            let clothing3 = ObjectStruct(type: ObjectType.clothing, location: Location(x: 9, y: 3))
            let clothing4 = ObjectStruct(type: ObjectType.clothing, location: Location(x: 0, y: 13))
        
        
        //set points per objects
            pointsPerObject[ObjectType.ball] = 10
            pointsPerObject[ObjectType.dirt] = 15
            pointsPerObject[ObjectType.toy] = 10
            pointsPerObject[ObjectType.clothing] = 10
            
        //define ScenarioObjects
            let bed1 = ScenarioObject(type: SOType.bed(SOPlace.lowerLeft), width: 3, height: 2, anchorLocation: Location(x: 7, y: 1),points: 10)

            let bed2 = ScenarioObject(type: SOType.bed(SOPlace.lowerLeft), width: 3, height: 2, anchorLocation: Location(x: 7, y: 4),points: 10)
          
            let bed3 = ScenarioObject(type: SOType.bed(SOPlace.lowerLeft), width: 3, height: 2, anchorLocation: Location(x: 7, y: 7),points: 10)
            
            let closet = ScenarioObject(type: SOType.closet(SOPlace.lowerLeft), width: 2, height: 3, anchorLocation: Location(x:1, y:9), points: 10)
            
            let desk = ScenarioObject(type: SOType.desk(SOPlace.lowerLeft), width: 2, height: 3, anchorLocation: Location(x:0, y:2), points: 10)

            let toyBox = ScenarioObject(type: SOType.toyBox(SOPlace.lowerLeft), width: 2, height: 2, anchorLocation: Location(x:0, y:6), points: 10)
            
        //add Characters to the Map
            mapAdd(character: char1, at: char1.model.getLocation())
            mapAdd(character: char2, at: char2.model.getLocation())
            mapAdd(character: char3, at: char3.model.getLocation())

        
        //add Objects to the Map
            mapAdd(object: ball)
            mapAdd(object: ball2)
            mapAdd(object: ball3)
            mapAdd(object: broomStick)
            mapAdd(object: dirt1)
            mapAdd(object: dirt2)
            mapAdd(object: dirt3)
            mapAdd(object: dirt4)
            mapAdd(object: dirt5)
            mapAdd(object: toy1)
            mapAdd(object: toy2)
            mapAdd(object: toy3)
            mapAdd(object: toy4)
            mapAdd(object: clothing1)
            mapAdd(object: clothing2)
            mapAdd(object: clothing3)
            mapAdd(object: clothing4)
        
        //add ScenarioObjects to the Map
        
            mapAdd(scenarioObject: bed1, at: bed1.getLocation())
            mapAdd(scenarioObject: bed2, at: bed2.getLocation())
            mapAdd(scenarioObject: bed3, at: bed3.getLocation())
            mapAdd(scenarioObject: closet, at: closet.getLocation())
            mapAdd(scenarioObject: desk, at: desk.getLocation())
            mapAdd(scenarioObject: toyBox, at: toyBox.getLocation())
        
        //add CleanRelations
        
            mapModel.add(cleanRelation: CleanRelation(scenarioObjectCleaner: SOType.toyBox(SOPlace.lowerLeft), objectCleaner: nil, objectToBeCleaned: ObjectType.ball, needCleaner: false))
        
            mapModel.add(cleanRelation: CleanRelation(scenarioObjectCleaner: SOType.toyBox(SOPlace.lowerLeft), objectCleaner: nil, objectToBeCleaned: ObjectType.toy, needCleaner: false))
        
            mapModel.add(cleanRelation: CleanRelation(scenarioObjectCleaner: nil, objectCleaner: broomStick.type, objectToBeCleaned: ObjectType.dirt, needCleaner: true))

            mapModel.add(cleanRelation: CleanRelation(scenarioObjectCleaner: SOType.closet(SOPlace.lowerLeft), objectCleaner: nil, objectToBeCleaned: ObjectType.clothing, needCleaner: false))
        
    }
    
    private func mapAdd(character : CharacterStruct, at location : Location){
        
        mapModel.add(character: character.model, at: location)
        mapView.add(character: character.view, location: character.model.getLocation())
        charactersStruct.append(character)

    }
    
    private func mapAdd(object : ObjectStruct){
        
        mapModel.add(object: object.type, at: object.location)
        mapView.add(object: object.type, at: object.location)
        objectsStruct.append(object)
        
    }
    
    private func mapAdd(scenarioObject scenObj: ScenarioObject, at location: Location){
        
        mapModel.add(scenarioObject: scenObj, at: location)
        mapView.add(scenarioObjectsMap: mapModel.getScenarioObjectMap())
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(firstTouched == false){
         
            firstTouched = true
            timerModel.start()
            motherModel.sayStartMessage()
            
        }
        
        for touch in touches{
            
            let location = touch.location(in: self)

            if mapView.contains(location){

                for char in charactersStruct{
                    
                    if(char.model.getLeftHand() != nil){

                        if(char.view.getLeftHand()!.draw() === mapView.nodes(at: location)[0]){
                            
                            mapModel.setSelectedCharacterTo(character: char.model)
                            mapModel.setSelectedHand(handEnum: Hand.left)
                            mapView.userSelectedObject(objectView: char.view.getLeftHand()!)
                            
                            let objGhost = mapView.getSelectedDraggingGhostObject()
                            
                            let x = char.view.draw().position.x + char.view.getLeftHand()!.draw().position.x
                            let y = char.view.draw().position.y + char.view.getLeftHand()!.draw().position.y
                            let positionObjGhost : CGPoint = CGPoint(x: x, y: y)
                            objGhost!.draw().position = positionObjGhost
                            self.addChild(objGhost!.draw())
                            
                            return
                            
                        }
                        
                    }
                    
                    if(char.model.getRightHand() != nil){
                        
                        if(char.view.getRightHand()!.draw() === mapView.nodes(at: location)[0]){
                            
                            mapModel.setSelectedCharacterTo(character: char.model)
                            mapModel.setSelectedHand(handEnum: Hand.right)
                            mapView.userSelectedObject(objectView: char.view.getRightHand()!)
                            
                            let objGhost = mapView.getSelectedDraggingGhostObject()
                            
                            let x = char.view.draw().position.x + char.view.getRightHand()!.draw().position.x
                            let y = char.view.draw().position.y + char.view.getRightHand()!.draw().position.y
                            let positionObjGhost : CGPoint = CGPoint(x: x, y: y)
                            objGhost!.draw().position = positionObjGhost
                            self.addChild(objGhost!.draw())
                            
                            return
                            
                        }
                        
                    }
                }
                
                mapView.touchesBegan(touches, with: event)
                
                let tile = mapView.getTileAtLocation(viewX: touch.location(in: self).x, viewY: touch.location(in: self).y)
                
                mapModel.tileTouched(tile!)

            }
            
        }
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if(mapView.userIsDraggingObject()){
                let ghostSprite = mapView.getSelectedDraggingGhostObject()!.draw()
                ghostSprite.position = location
                
            }
            
            
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if(mapView.userIsDraggingObject() && mapView.getSelectedDraggingObject()!.draw() === mapView.nodes(at: location)[0]){
                
                let draggedObjectViewSprite = mapView.getSelectedDraggingObject()!.draw()
                for char in charactersStruct{

                    if(char.view.getLeftHand() != nil && draggedObjectViewSprite === char.view.getLeftHand()!.draw()){

                        mapView.dropDraggedObject()
                        char.model.dropAtNearLocation(handEnum: Hand.left)
                        mapModel.removeSelectedHand()
                        
                    }else if(char.view.getRightHand() != nil && draggedObjectViewSprite === char.view.getRightHand()!.draw()){
                        
                        mapView.dropDraggedObject()
                        char.model.dropAtNearLocation(handEnum: Hand.right)
                        mapModel.removeSelectedHand()
                        
                    }
                }
            }
            
            if(mapView.userIsDraggingObject()){
                
                let tileSelected = mapView.getTileAtLocation(viewX: location.x, viewY: location.y)
                if(tileSelected != nil){
                
                    mapModel.tileTouched(tileSelected!)
                    mapView.dropDraggedObject()
                    mapModel.removeSelectedHand()
                
                }

            }
            
        }

    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if(mapView.userIsDraggingObject() && mapView.getSelectedDraggingObject()!.draw() === mapView.nodes(at: location)[0]){
                
                let draggedObjectViewSprite = mapView.getSelectedDraggingObject()!.draw()
                for char in charactersStruct{
                    
                    if(char.view.getLeftHand() != nil && draggedObjectViewSprite === char.view.getLeftHand()!.draw()){
                        
                        mapView.dropDraggedObject()
                        char.model.dropAtNearLocation(handEnum: Hand.left)
                        mapModel.removeSelectedHand()
                        
                    }else if(char.view.getRightHand() != nil && draggedObjectViewSprite === char.view.getRightHand()!.draw()){
                        
                        mapView.dropDraggedObject()
                        char.model.dropAtNearLocation(handEnum: Hand.right)
                        mapModel.removeSelectedHand()
                        
                    }
                }
            }
            
            if(mapView.userIsDraggingObject()){
                
                let tileSelected = mapView.getTileAtLocation(viewX: location.x, viewY: location.y)
                if(tileSelected != nil){
                    
                    mapModel.tileTouched(tileSelected!)
                    mapView.dropDraggedObject()
                    mapModel.removeSelectedHand()
                    
                }
                
            }
            
        }        
    }
    
    @objc public func characterMoved(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,Character> {
            if let character = info["character"] {
                
                let tileX = character.getLocation().getX()
                let tileYMatrix = character.getLocation().getY()

                let tileYView = (Config.MAP_HEIGHT-1)-character.getLocation().getY()
                
                let sceneX = CGFloat(tileX*Config.BLOCK_WIDTH)+CGFloat(mapView.position.x+CGFloat(Config.BLOCK_WIDTH/2))
                let sceneY = CGFloat(tileYView*Config.BLOCK_HEIGHT)+CGFloat(mapView.position.y+CGFloat(Config.BLOCK_HEIGHT/2))
    
                let newPosition = CGPoint(x: sceneX, y: sceneY)
                
                var charView : CharacterView
                
                var foundCharacterStruct = true
                for char in charactersStruct{
                    
                    if(char.name == character.getName()){

                        foundCharacterStruct = true
                        charView = char.view
                        
                        charSelectedMoveTo(character : charView, point : newPosition, tile: Location(x: tileX, y: tileYMatrix), speed: character.getSpeed())
                        break
                    
                    }
                    
                }
                
                if(!foundCharacterStruct){
                    
                    print("[Error] at GameScene.objectTaken: characterStruct not inserted into characters array")
                    
                }
                
            }
            else {
                print("[Error] at GameScene.characterMoved: no value for `character` key\n")
            }
        }
        
    }
    
    @objc public func addHighlightCharacter(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,Character> {

            if let character = info["character"] {
                
                for char in charactersStruct{
                    
                    if(char.name == character.getName()){
                        
                        
                        char.view.addHighlight()
                        break
                        
                    }
                    
                }
                
            }
            else {
                print("[Error] at GameScene.addHighlightCharacter: no value for `character` key\n")
            }
        }
        
    }
    
    @objc public func removeHighlightCharacter(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,Character> {

            if let character = info["character"] {
                
                for char in charactersStruct{
                    
                    if(char.name == character.getName()){
                        
                        
                        char.view.removeHighlight()
                        break
                        
                    }
                    
                }
                
            }
            else {
                print("[Error] at GameScene.removeHighlightCharacter: no value for `character` key\n")
            }
        }
        
    }
    
    @objc public func objectRemovedFrom(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,Location> {

            if let location = info["location"] {
             
                mapView.removeObjectFrom(location: location)
                
            }
        }
        
    }
    
    @objc public func motherSays(notification : Notification){
        
        if let info = notification.userInfo as? Dictionary<String,String> {

            if let messageString = info["messageString"] {
        
                motherView.say(text: messageString)
                
            }
        }
        
    }
    
    @objc public func motherSaysSomething(notification : Notification){
        
        motherModel.saySomething()
        
    }
    
    @objc public func showMessageIcon(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,ChatBalloon> {

            if let chatBalloon = info["chatBalloon"] {
                
                for char in charactersStruct{
                    
                    if(char.name == chatBalloon.getCharacter().getName()){
                        
                        char.view.showMessage(imageNamed: chatBalloon.getImageName(), seconds: 2)
                        
                    }
                    
                }
            }
        }
        
    }
    
    @objc public func objectTaken(notification : Notification){
        
        if let info = notification.userInfo as? Dictionary<String,Character> {
        
            if let character : Character = info["character"] {
                
                var foundCharacterStruct = false
                
                for char in charactersStruct{
                    
                    
                    if(char.name == character.getName()){
                        foundCharacterStruct = true
                        
                        if (char.view.getLeftHand() == nil && character.getLeftHand() != nil){
                            
                            char.view.getWithLeftHand(object: character.getLeftHand()!)
                            
                        }else if (char.view.getRightHand() == nil && character.getLeftHand() != nil){
                            
                            char.view.getWithRightHand(object: character.getRightHand()!)
                            
                        }else{
                            
                            print("[Error] at GameScene.objectTaken: character can't get more objects")

                            
                        }
                        
                        
                    }
                    
                }
                
                if(!foundCharacterStruct){
                    
                    print("[Error] at GameScene.objectTaken: characterStruct not inserted into characters array")
                    
                }
                
            }
        }
        
    }
    
    @objc public func sumPointsObject(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,ObjectType> {

            if let objType = info["object"] {
                
                
                for objStruct in objectsStruct{

                    if(objStruct.type == objType){
                        
                        if(pointsPerObject[objStruct.type] == nil){
                            
                            print("[Error] at GameScene.sumPoints: There is no points associated for the object \(objStruct.type). Need to add it to pointsPerObject dictionary")
                            
                        }
                        
                        points += pointsPerObject[objStruct.type]!
                        pointsView.sum(newPoints: pointsPerObject[objStruct.type]!)
                        print("Somou os pontos na GameScene: Atualmente com \(self.points) pontos")
                        
                        
                        break
                        
                    }
                    
                
                }
            }
        }
        
    }
    
    @objc public func sumPointsScenarioObject(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,ScenarioObject> {

            if let scenObject = info["scenarioObject"] {
                
                        points += scenObject.getPoints()
                        pointsView.sum(newPoints: scenObject.getPoints())
                
                        print("Somou os pontos na GameScene: Atualmente com \(self.points) pontos")

            }
        }
        
    }
    
    @objc public func nextTime(notification : Notification){

        timerView.nextTime()
        
    }
    
    @objc public func characterDroppedLeftHand(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,Character> {

            if let character = info["character"] {
                
                
                var foundCharacterStruct = true
                for char in charactersStruct{
                    
                    if(char.name == character.getName()){
                        
                        foundCharacterStruct = true
                        let charView = char.view
                        
                        if(charView.getLeftHand() == nil){
                            
                            print("[Error] at GameScene.characterDroppedLeftHand: charView has no leftHand object")
                            return
                            
                        }
                        
                        charView.getLeftHand()!.draw().removeFromParent()
                        charView.setLeftHand(nil)
                        
                        break
                        
                    }
                    
                }
                
                if(!foundCharacterStruct){
                    
                    print("[Error] at GameScene.characterDroppedLeftHand: characterStruct not inserted into characters array")
                    
                }


            }
        }
        
    }
    
    @objc public func characterDroppedRightHand(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,Character> {

            if let character = info["character"] {
                
                
                var foundCharacterStruct = true
                for char in charactersStruct{
                    
                    if(char.name == character.getName()){
                        
                        foundCharacterStruct = true
                        let charView = char.view
                        
                        if(charView.getRightHand() == nil){
                            
                            print("[Error] at GameScene.characterDroppedLeftHand: charView has no leftHand object")
                            return
                            
                        }
                        
                        charView.getRightHand()!.draw().removeFromParent()
                        charView.setRightHand(nil)
                        
                        break
                        
                    }
                    
                }
                
                if(!foundCharacterStruct){
                    
                    print("[Error] at GameScene.characterDroppedLeftHand: characterStruct not inserted into characters array")
                    
                }
                
                
            }
        }
        
    }
    
    @objc public func scenarioObjectOrganized(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,ScenarioObject> {

            if let scenarioObject = info["scenarioObject"] {
                
                mapView.organize(scenarioObject: scenarioObject)
                
            }
        }
        
    }

    @objc public func addObjectToMap(notification : Notification){
        
        
        if let info = notification.userInfo as? Dictionary<String,ObjectStruct> {

            if let objStruct = info["objectStruct"] {
                
                mapAdd(object: objStruct)
                
                
            }
            

        }
        
    }
    
    @objc public func gameOver(notification : Notification){
        
        var mainText,descriptionText: String
        if(points >= motherModel.getRage()){
            
            mainText = "Congratulations!"
            descriptionText = "You helped the boys to clean the room enough. They will enjoy a delicious ice cream :)"
            
        }else{
            
            mainText = "Ohhh!"
            descriptionText = "You did not clean enough the room this time. No clean, no ice cream :("
            
        }
        
        self.view?.presentScene(GameOverScene(size: self.size, textMain: mainText, textDescription: descriptionText))
        
    }

    
    func charSelectedMoveTo(character: CharacterView, point: CGPoint, tile : Location, speed: Speed){
        
        var duration : Double
        
        switch(speed){
            
        case .fast:
            duration = 0.5
            
        case .medium:
            duration = 1
            
        case .slow:
            duration = 1.5
            
        }
        
        mapView.selectedCharacter = character
        mapView.updateCharacterLocation(fromTile: character.getLocation(), toTile: tile)

        character.goTo(cgPoint: point, tileX: tile.getX(), tileY: tile.getY(), duration: duration)
    }
    
}
