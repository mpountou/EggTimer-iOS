import UIKit

class ViewController: UIViewController {

    let eggTimes = [
        "Soft": 3,
        "Medium": 4,
        "Hard": 7
    ]

    var secondsRemaining = 0
    var totalTime = 0
    var timer: Timer?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    @IBAction func onEggSelected(_ sender: UIButton) {
        guard let title = sender.currentTitle,
              let cookingTime = eggTimes[title] else {
            return
        }

        timer?.invalidate()

        totalTime = cookingTime
        secondsRemaining = cookingTime

        titleLabel.text = "Preparing your egg"
        progressBar.progress = 0.0

        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1

            progressBar.progress =
                1.0 - Float(secondsRemaining) / Float(totalTime)

            print("Seconds remaining: \(secondsRemaining)")
        } else {
            timer?.invalidate()
            timer = nil

            titleLabel.text = "Egg ready!"
            progressBar.progress = 1.0
        }
    }

    deinit {
        timer?.invalidate()
    }
}
