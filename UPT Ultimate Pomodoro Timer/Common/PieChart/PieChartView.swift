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
        
        let center = CGPoint(
            x: rect.midX,
            y: rect.midY
        )
        let radius = min(
            rect.width,
            rect.height
        ) / 2
        
        var startAgle: CGFloat = -.pi / 2
        
        for segment in segments {
            let endAngle = startAgle + (2 * .pi * (segment.value / 100))
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(
                withCenter: center,
                radius: radius,
                startAngle: startAgle,
                endAngle: endAngle,
                clockwise: true
            )
            path.close()
            
            segment.color.setFill()
            path.fill()
            
            startAgle = endAngle
        }
    }
    
    private func configureUI() {
        backgroundColor = .clear
    }
}
