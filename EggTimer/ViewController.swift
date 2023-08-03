import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    // Assuming Soft Egg, Medium Egg, and Hard Egg requires 5 minutes, 7 minutes, 12 minutes respectfully
    let hardness = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var second = 0
    var timeTotal = 0
    var timer = Timer()
    
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        timer.invalidate()
        let status = sender.currentTitle!
        timeTotal = hardness[status]!
        
        progressBar.progress = 0.0
        second = 0
        labelTop.text = status + " Egg"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime(){
        if(second < timeTotal){
            second += 1
            progressBar.progress = Float(second) / Float(timeTotal)
            
            
        }
        
        else{
            timer.invalidate()
            labelTop.text = "Done"
            playSound()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                self.labelTop.text = "How do you like your eggs?"
                self.progressBar.progress = 0.0
            }
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
