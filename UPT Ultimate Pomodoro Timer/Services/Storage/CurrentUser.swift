import Foundation

class CurrentUser {
    
    static let shared = CurrentUser()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    var workingPeriodTime: Int {
        get {
            return defaults.integer(forKey: "workingPeriodTime")
        }
        set {
            return defaults.set(newValue, forKey: "workingPeriodTime")
        }
    }
    
    var shortBreakTime: Int {
        get {
            return defaults.integer(forKey: "shortBreakTime")
        }
        set {
            return defaults.set(newValue, forKey: "shortBreakTime")
        }
    }
    
    var longBreakTime: Int {
        get {
            return defaults.integer(forKey: "longBreakTime")
        }
        set {
            return defaults.set(newValue, forKey: "longBreakTime")
        }
    }
    
    var isNotFirstLaunch: Bool {
        get {
            return defaults.bool(forKey: "notFirstLaunch")
        }
        set {
            return defaults.set(newValue, forKey: "notFirstLaunch")
        }
    }
}
