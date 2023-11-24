import UIKit

public final class PieChartView: UIView {
    var segments: [PieChartSegment] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let fillColor = UIColor(red: 0.965, green: 0.976, blue: 0.894, alpha: 1.000)
        
        let shapeLayer = CAShapeLayer()
        
        let radian: CGFloat = 30.0 * (.pi/180.0)
        let x = bounds.height/2 * cos(radian)
        let y = bounds.height/2 * sin(radian)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        /// Обход контура по часовой стрелке
        bezierPath.move(to: CGPoint(x: 150, y: 7))
        /// Скругление угла
        bezierPath.addCurve(
            to: CGPoint(x: 157, y: 0.16),
            controlPoint1: CGPoint(x: 150, y: 3.13),
            controlPoint2: CGPoint(x: 153.14, y: -0.02)
        )
        /// Половина внешней дуги
        bezierPath.addCurve(
            to: CGPoint(x: 224.32, y: 19.71),
            controlPoint1: CGPoint(x: 180.63, y: 1.27),
            controlPoint2: CGPoint(x: 203.71, y: 7.95)
        )
        /// Вторая половина внешней дуги
        bezierPath.addCurve(
            to: CGPoint(x: 275.41, y: 67.7),
            controlPoint1: CGPoint(x: 244.93, y: 31.46),
            controlPoint2: CGPoint(x: 262.43, y: 47.92)
        )
        /// Скругление
        bezierPath.addCurve(
            to: CGPoint(x: 273.09, y: 77.21),
            controlPoint1: CGPoint(x: 277.53, y: 70.94),
            controlPoint2: CGPoint(x: 276.41, y: 75.24)
        )
        /// Радиальная линия
        bezierPath.addLine(to: CGPoint(x: 252.86, y: 89.17))
        /// Скругление
        bezierPath.addCurve(
            to: CGPoint(x: 243.08, y: 86.82),
            controlPoint1: CGPoint(x: 249.53, y: 91.14),
            controlPoint2: CGPoint(x: 245.26, y: 90.02)
        )
        /// Половина внутренней дуги
        bezierPath.addCurve(
            to: CGPoint(x: 205.74, y: 52.28),
            controlPoint1: CGPoint(x: 233.45, y: 72.63),
            controlPoint2: CGPoint(x: 220.69, y: 60.81)
        )
        /// Вторая половина внутренней дуги
        bezierPath.addCurve(
            to: CGPoint(x: 157, y: 37.72),
            controlPoint1: CGPoint(x: 190.79, y: 43.75),
            controlPoint2: CGPoint(x: 174.11, y: 38.78)
        )
        /// Скругление
        bezierPath.addCurve(
            to: CGPoint(x: 150, y: 30.5),
            controlPoint1: CGPoint(x: 153.14, y: 37.48),
            controlPoint2: CGPoint(x: 150, y: 34.37)
        )
        /// Радиальная линия
        bezierPath.addLine(to: CGPoint(x: 150, y: 7))
        bezierPath.close()

        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    private func configureUI() {
        backgroundColor = .clear
        layer.masksToBounds = false
    }
}
