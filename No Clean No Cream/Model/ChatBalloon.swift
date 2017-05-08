import Foundation

public class ChatBalloon{
    
    private weak var character : Character?
    private var imageName: String?
    
    public init(character: Character){
        
        self.character = character
        
    }
    
    public func getCharacter() -> Character{
        
        return character!
        
    }
    
    public func getImageName() -> String{
        
        return imageName!
        
    }
    
    public func showMessage(imageName: String){
    
        self.imageName = imageName
    
        NotificationCenter.default.post(name: Notification.Name("SHOW_CHAT_BALLOON_ICON"), object: nil, userInfo: ["chatBalloon" : self])
    
    }
    
    public func showMessage(objectType: ObjectType){
    
        var objectName : String? = nil
        
        switch objectType{
            
            case .ball:
                objectName = "ball"
                break
            
            case .dump:
                objectName = "dump"
                break

            case .clothing:
                objectName = "clothing"
                break
            
            case .dirt:
                objectName = "dirt"
                break
            
            case .broomStick:
                objectName = "broomStick"
                break
            
            case .toy:
                objectName = "toy"
                break
            
            case .blank:
                break
        }
        
        if(objectName == nil){
            
            print("[Error] objectType for Chat Balloon is undefined")
            return
            
        }
        
        imageName = objectName!
        
        NotificationCenter.default.post(name: Notification.Name("SHOW_CHAT_BALLOON_ICON"), object: nil, userInfo: ["chatBalloon" : self])
        
    }
    
}
