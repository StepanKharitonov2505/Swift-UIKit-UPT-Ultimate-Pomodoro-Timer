import UIKit

public class CheckSmallScreen {
    static func isSmallScreen() -> Bool {
        let currentScreenHeight = UIScreen.main.bounds.size.height
        return currentScreenHeight < 680
    }
}
