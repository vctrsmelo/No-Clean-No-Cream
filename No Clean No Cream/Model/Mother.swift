import Foundation
import SpriteKit

public class Mother{
    
    private var rage : Int
    private var messages = Array<String>()
    private var actualMessage : String
    
    public init(startingRage rage : Int){
        
        self.rage = rage
        actualMessage = ""
        messages = loadMessagesArray()
    }
    
    public init(){
        
        self.rage = Config.INITIAL_RAGE_MOTHER
        actualMessage = ""
        messages = loadMessagesArray()
    }
    
    private func loadMessagesArray() -> Array<String>{
       
        var messagesArrayReturned = Array<String>()
       
        //Mother messages
        //start message
        messagesArrayReturned.append("I'm home! It's better your room to be clean.")
        
        //random messages
        messagesArrayReturned.append("You aren't cleaning it fast now, right?")
        
        messagesArrayReturned.append("What is this noise coming from your room?")
        
        //The shining
        messagesArrayReturned.append("Heeeeere's mommy!")


        return messagesArrayReturned
        
    }
    
    public func saySomething(){
        
        if(messages.count <= 1){
            
            return
            
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(messages.count-1)) + 1)
        actualMessage = messages[randomIndex]
        messages.remove(at: randomIndex)
        say(message: actualMessage)
        
    }
    
    public func sayStartMessage(){
        
        self.actualMessage = messages[0]
        say(message: actualMessage)
        
    }
    
    public func sayGoodFinalMessage(){
        
        self.actualMessage = messages[1]
        say(message: actualMessage)
    }
    
    public func sayBadFinalMessage(){
        
        self.actualMessage = messages[2]
        say(message: actualMessage)
        
    }
    
    public func say(message : String){
        
        actualMessage = message
        NotificationCenter.default.post(name: Notification.Name("MOTHER_MESSAGE"), object: nil, userInfo: ["messageString" : message])

    }
    
    public func getMessage() -> String{
        
        return actualMessage
        
    }
    
    public func getRage() -> Int {
        
        return rage
        
    }
    
    
}
