import Foundation
import SpriteKit

public class ScenarioObjectView: Drawable{
    
    let place: SOPlace
    var organized : Bool

    public init(place: SOPlace){

        self.place = place
        organized = false

    }
    
    public func organizeIt(){
        
        fatalError("ScenarioObjectView: The method organizeit() was not implemented by the scenario object child")

        
    }
    
    public func isOrganized() -> Bool{
        
        return organized
        
    }
    
    public func draw() -> SKSpriteNode {
        
        fatalError("draw(ScenarioObject): The method draw() was not implemented by the scenario object child")

    }
    
}
