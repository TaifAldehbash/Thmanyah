import Foundation

class Debouncer {
    private var timer: Timer?
    
    func debounce(delay: TimeInterval, action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }
}
