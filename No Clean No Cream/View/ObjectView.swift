import Foundation
import SpriteKit

public class ObjectView: Drawable{

    let spriteImage: String

    public init(spriteImage: String){
        
        self.spriteImage = spriteImage

    }
    
    public func getSpriteImageStringName() -> String{
        
        return spriteImage
        
    }
    
    public func copy() -> ObjectView{
        
        
        fatalError("copy(Object): The method copy() was not implemented by the object child")
        
    }
    
    public func draw() -> SKSpriteNode {
        
        fatalError("draw(Object): The method draw() was not implemented by the object child")
        
    }

}
