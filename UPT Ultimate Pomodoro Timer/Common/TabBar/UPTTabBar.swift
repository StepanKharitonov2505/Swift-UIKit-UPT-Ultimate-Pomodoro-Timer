import UIKit
import SnapKit

final class UPTTabBar: UIView {
    
    // MARK: - Activation Control Panel
    
    private let isActiveControlPanel: Bool = false
    
    // MARK: - Internal Properties
    
    var itemTapped: ((_ tab: Int) -> Void)?
    
    // MARK: - Private Prorepties
    
    private var activeItem: Int = 0
    private lazy var controlPanel = makeControlPanel()
    private lazy var tabBarFoundation = makeTabBar()
    private let timerControlPanel = TimerControlPanel()
    private let settingsControlPanel = SettingsControlPanel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(
        menuItems: [UPTTabItem],
        frame: CGRect
    ) {
        self.init(frame: frame)
        configureUI(menuItems)
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - Override SuperMethods
    
    override func didMoveToWindow() {
        switchTab(from: 1, to: 0)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }
}

// MARK: - Private Methods

private extension UPTTabBar {
    
    func configureUI(_ menuItems: [UPTTabItem]) {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        addSubview(tabBarFoundation)
        
        tabBarFoundation.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if isActiveControlPanel {
            addSubview(controlPanel)
            controlPanel.addSubview(timerControlPanel)
            controlPanel.addSubview(settingsControlPanel)
            
            timerControlPanel.isHidden = true
            settingsControlPanel.isHidden = true
            
            controlPanel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(10)
                make.bottom.equalToSuperview()
                make.right.equalToSuperview().inset(10)
                make.height.equalTo(NumericContants.minHeightControlPanel)
            }
            
            timerControlPanel.snp.makeConstraints { make in
                make.top.left.right.equalTo(controlPanel)
                make.height.equalTo(NumericContants.contentControlPanelHeight)
            }
            
            settingsControlPanel.snp.makeConstraints { make in
                make.top.left.right.equalTo(controlPanel)
                make.height.equalTo(NumericContants.contentControlPanelHeight)
            }
        }
        
        for i in 0 ..< menuItems.count {
            let itemWidth = (self.frame.width*NumericContants.tabBarWidthFactor) / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = self.createTabItem(item: menuItems[i])
            itemView.tag = i
            
            tabBarFoundation.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            
            itemView.snp.makeConstraints { make in
                make.height.equalTo(self.snp.height)
                make.top.equalTo(self.snp.top)
                make.width.equalTo(itemWidth)
                make.left.equalTo(self.snp.left).offset(leadingAnchor)
            }
        }
    }
    
    func createTabItem(item: UPTTabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)

        tabBarItem.tag = 11
        itemIconView.tag = 13
        
        itemIconView.image = item.icon!.withRenderingMode(.automatic)
        itemIconView.contentMode = .scaleAspectFit // added to stop stretching
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        itemIconView.snp.makeConstraints { make in
            make.center.equalTo(tabBarItem.snp.center)
            make.height.width.equalTo(NumericContants.sizeImageTabItem)
        }
        
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        
        return tabBarItem
    }
    
    @objc
    func handleTap(_ sender: UIGestureRecognizer) {
        switchTab(
            from: activeItem,
            to: sender.view!.tag
        )
    }
    
    // MARK: TabBar Update Method
    
    func switchTab(
        from: Int,
        to: Int
    ) {
        guard to != from else { return }
        let tabToActive = tabBarFoundation.subviews[to]
        self.itemTapped?(to)
        self.activeItem = to
        let inactiveTab = tabBarFoundation.subviews[from]
        
        UIView.animate(withDuration: NumericContants.tabItemAnimationDuration) {
            tabToActive.viewWithTag(13)?.tintColor = ColorSet
                .TabBarColors
                .tabBarSelectItemTintColor
            inactiveTab.viewWithTag(13)?.tintColor = ColorSet
                .TabBarColors
                .tabBarUnselectItemTintColor
        }
        
        if isActiveControlPanel {
            UIView.animate(withDuration: NumericContants.controlPanelAnimationDuration) { [weak self] in
                guard let self = self else { return }
                if self.controlPanel.frame.height != NumericContants.minHeightControlPanel {
                    self.controlPanel.snp.updateConstraints { make in
                        make.height.equalTo(NumericContants.minHeightControlPanel)
                    }
                    self.layoutIfNeeded()
                } else {
                    if self.activeItem == 0 {
                        self.timerControlPanel.isHidden = false
                        self.settingsControlPanel.isHidden = true
                    } else {
                        self.timerControlPanel.isHidden = true
                        self.settingsControlPanel.isHidden = false
                    }
                    self.controlPanel.snp.updateConstraints { make in
                        make.height.equalTo(NumericContants.maxHeightControlPanel)
                    }
                    self.layoutIfNeeded()
                }
            } completion: { [weak self] _ in
                guard let self = self else { return }
                if self.controlPanel.frame.height == NumericContants.minHeightControlPanel {
                    if self.activeItem == 0 {
                        self.timerControlPanel.isHidden = false
                        self.settingsControlPanel.isHidden = true
                    } else {
                        self.timerControlPanel.isHidden = true
                        self.settingsControlPanel.isHidden = false
                    }
                    UIView.animate(withDuration: NumericContants.controlPanelAnimationDuration) {
                        self.controlPanel.snp.updateConstraints { make in
                            make.height.equalTo(NumericContants.maxHeightControlPanel)
                        }
                        self.layoutIfNeeded()
                    }
                }
            }
        }
    }
}

// MARK: - Factory Methods

private extension UPTTabBar {
    func makeControlPanel() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = NumericContants.cornerRadius
        if #available(iOS 13, *) {
            view.layer.cornerCurve = .continuous
        }
        view.backgroundColor = ColorSet
            .TabBarColors
            .ControlPanelColors
            .controlPanelBackgroundColor
        return view
    }
    
    func makeTabBar() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = NumericContants.cornerRadius
        if #available(iOS 13, *) {
            view.layer.cornerCurve = .continuous
        }
//        view.layer.shadowOffset = .zero
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowRadius = 5
//        view.layer.shadowOpacity = 0.7
        view.clipsToBounds = false
        view.backgroundColor = ColorSet.TabBarColors.tabBarBackgroundColor
        return view
    }
}

// MARK: - Constants

private extension UPTTabBar {
    enum NumericContants {
        static let cornerRadius: CGFloat = 20
        static let minHeightControlPanel: CGFloat = 80
        static let maxHeightControlPanel: CGFloat = 160
        static let sizeImageTabItem: CGFloat = 30
        static let tabItemAnimationDuration: TimeInterval = 0.25
        static let controlPanelAnimationDuration: TimeInterval = 0.15
        static let contentControlPanelHeight: CGFloat = 80
        static let tabBarWidthFactor: Double = 0.7
    }
}
