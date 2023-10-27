import UIKit

public extension UIColor {
    static func rgb(
        _ r: CGFloat,
        _ g: CGFloat,
        _ b: CGFloat
    ) -> UIColor {
        return UIColor.rgba(r, g, b, 1.0)
    }

    static func rgba(
        _ r: CGFloat,
        _ g: CGFloat,
        _ b: CGFloat,
        _ a: CGFloat
    ) -> UIColor {
        return UIColor(
                    red: r/255.0,
                    green: g/255.0,
                    blue: b/255.0,
                    alpha: a
                )
    }
}
