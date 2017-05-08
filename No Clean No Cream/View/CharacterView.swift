import Foundation
import SpriteKit

public class CharacterView: Drawable{

    private var name : String
    private var spriteImage : String
    private var location: Location?
    private var spriteNode : SKSpriteNode?
    private var leftHand : ObjectView?
    private var rightHand : ObjectView?
    private var chatBalloon : ChatBalloonView?
    private var highlightAction: SKAction
    
    public init(spriteImage: String, name : String){

        self.name = name
        self.spriteImage = spriteImage
        self.location = nil
        self.spriteNode = nil
        self.leftHand = nil
        self.rightHand = nil
        self.chatBalloon = nil
        
        let pulseUp = SKAction.scale(to: 1.2, duration: 0.6)
        let pulseDown = SKAction.scale(to: 0.8, duration: 0.6)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        self.highlightAction = SKAction.repeatForever(pulse)
        
        self.chatBalloon = ChatBalloonView(characterView: self)
        
    }
    
    public init(spriteImage: String, location: Location, name : String){
        
        self.name = name
        self.spriteImage = spriteImage
        self.location = location
        self.spriteNode = nil
        self.leftHand = nil
        self.rightHand = nil
        self.chatBalloon = nil

        let pulseUp = SKAction.scale(to: 1.2, duration: 0.6)
        let pulseDown = SKAction.scale(to: 0.8, duration: 0.6)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        self.highlightAction = SKAction.repeatForever(pulse)
        
        self.chatBalloon = ChatBalloonView(characterView: self)
        
    }
    
    public func addHighlight() {
        
        print("veio aqui")
        
        if(spriteNode != nil){

            print("veio aqui2")
            spriteNode!.run(highlightAction, withKey: "highlight")
        }
    }
    
    public func removeHighlight(){
        
        if(spriteNode != nil){
            spriteNode!.removeAction(forKey: "highlight")
            spriteNode!.setScale(1)
        }
    }
    
    public func getChatBalloon() -> ChatBalloonView{
        
        return chatBalloon!
        
    }
    
    public func getLeftHand() -> ObjectView?{
        
        return leftHand
        
    }
    
    public func setLeftHand(_ obj: ObjectView?){
        
        leftHand = obj
        
    }
    
    public func getRightHand() -> ObjectView?{
        
        return rightHand
        
    }
    
    public func setRightHand(_ obj: ObjectView?){
        
        rightHand = obj
        
    }

    
    public func getWithLeftHand(object : ObjectType){
        
        let obj : ObjectView?
        
        switch(object){
        case .blank:
            obj = nil
            break
        case .ball:
            obj = Ball()
            break
        case .broomStick:
            obj = BroomStick()
            break
        case .dump:
            obj = Dump()
            break
        case .dirt:
            obj = Dirt()
            break
        case .clothing:
            obj = Clothing()
            break
        case .toy:
            obj = Toy()
            break
        default: obj = nil
        }
        
        if(obj != nil){
            let sceneX = 32
            let sceneY = -16
            
            leftHand = obj
            leftHand!.draw().size = CGSize(width: Int(Double(Config.BLOCK_WIDTH)/1.5), height: Int(Double(Config.BLOCK_HEIGHT)/1.5))
            
            
            
            leftHand!.draw().position = CGPoint(x: sceneX, y: sceneY)
            leftHand!.draw().zPosition = CGFloat(4)
            spriteNode!.addChild(leftHand!.draw())
        }
        
    }
    
    public func getWithRightHand(object : ObjectType){
        
        let obj : ObjectView?
        
        switch(object){
        case .blank:
            obj = nil
            break
        case .ball:
            obj = Ball()
            break
        case .broomStick:
            obj = BroomStick()
            break
        case .dump:
            obj = Dump()
            break
        case .dirt:
            obj = Dirt()
            break
        case .clothing:
            obj = Clothing()
            break
        case .toy:
            obj = Toy()
            break
        default: obj = nil
        }

        if(obj != nil){
            let sceneX = -16
            let sceneY = 0 
            rightHand = obj
            rightHand!.draw().size = CGSize(width: Int(Double(Config.BLOCK_WIDTH)/1.5), height: Int(Double(Config.BLOCK_HEIGHT)/1.5))
            
            rightHand!.draw().position = CGPoint(x: sceneX, y: sceneY)
            rightHand!.draw().zPosition = CGFloat(4)
            spriteNode!.addChild(rightHand!.draw())
        }
        
    }
    
    public func getName() -> String{
        
        return name
        
    }
    
    public func setName(_ name : String){
     
        self.name = name
        
    }

    public func setLocation(_ location : Location){
        
        self.location = location
        
    }

    public func draw() -> SKSpriteNode {

        if(spriteNode == nil){

            spriteNode = SKSpriteNode(imageNamed: spriteImage)

        }

        return spriteNode!

    }

    public func getLocation() -> Location {

        return location!

    }
    
    public func goTo(cgPoint: CGPoint, tileX: Int, tileY: Int, duration: Double){
        
        let moveTo = SKAction.move(to: cgPoint, duration: duration)
        
        self.location = Location(x : tileX, y : tileY)
        
        self.draw().run(moveTo)

    }

    public func showMessage(imageNamed name: String, seconds: Double){
        
        let chatBalloonSprite = self.getChatBalloon().draw(imageNamed: name)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+seconds){
            
                chatBalloonSprite.alpha = 0.0
            
        }
        
        
    }
    
}
