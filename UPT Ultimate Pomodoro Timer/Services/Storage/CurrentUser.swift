import Foundation

class CurrentUser {
    
    static let shared = CurrentUser()
    
    private init() {}
    
    var workingPeriodTime: Int {
        get {
            return UserDefaults
                .standard
                .integer(forKey: "workingPeriodTime")
        }
        set {
            return UserDefaults
                .standard
                .set(newValue, forKey: "workingPeriodTime")
        }
    }
    
    var shortBreakTime: Int {
        get {
            return UserDefaults
                .standard
                .integer(forKey: "shortBreakTime")
        }
        set {
            return UserDefaults
                .standard
                .set(newValue, forKey: "shortBreakTime")
        }
    }
    
    var longBreakTime: Int {
        get {
            return UserDefaults
                .standard
                .integer(forKey: "longBreakTime")
        }
        set {
            return UserDefaults
                .standard
                .set(newValue, forKey: "longBreakTime")
        }
    }
    
    var isNotFirstLaunch: Bool {
        get {
            return UserDefaults
                .standard
                .bool(forKey: "notFirstLaunch")
        }
        set {
            return UserDefaults
                .standard
                .set(newValue, forKey: "notFirstLaunch")
        }
    }
}
