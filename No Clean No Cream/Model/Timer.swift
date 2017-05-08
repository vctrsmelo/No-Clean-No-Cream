import Foundation

public class Timer{
    
    private var timeLeft = Config.TOTAL_TIME
    
    public init(){
        
        
    }
    
    public func start(){

        nextTime()
        
    }
    
    private func nextTime(){
        
        if(timeLeft == 0){
         
            NotificationCenter.default.post(name: Notification.Name("GAME_OVER"), object: nil)
            
            return
            
        }
        
        if(timeLeft != Config.TOTAL_TIME && timeLeft % 15 == 0){
            
            NotificationCenter.default.post(name: Notification.Name("MOTHER_MESSAGE_SOMETHING"), object: nil)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) {
            
            self.timeLeft -= 1
            
            NotificationCenter.default.post(name: Notification.Name("NEXT_TIME"), object: nil)
            self.nextTime()
            
        }
        
    }
    
    
}
