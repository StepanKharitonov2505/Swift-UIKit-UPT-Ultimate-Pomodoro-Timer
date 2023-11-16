import UIKit
import RxSwift
import RxCocoa

final class SettingsScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var disposeBag: DisposeBag! = DisposeBag()
    
    // MARK: - Private Properties
    
    private let settingsView = SettingsScreenView()
    
    private var selectionWorkingPeriodTimeIndex: Int? {
        didSet {
            configureVisibleCell(.workingPeriod)
        }
    }
    private var selectionShortBreakTimeIndex: Int? {
        didSet {
            configureVisibleCell(.shortBreak)
        }
    }
    private var selectionLongBreakTimeIndex: Int? {
        didSet {
            configureVisibleCell(.longBreak)
        }
    }
    
    private var storageTime: Int {
        return CurrentUser.shared.workingPeriodTime
    }
    
    /// МОК ДАННЫЕ ДЛЯ UI теста
    var workingPeriodTimeElements: [TimePickerElementViewModel] = [
        TimePickerElementViewModel(timeSize: 20),
        TimePickerElementViewModel(timeSize: 21),
        TimePickerElementViewModel(timeSize: 22),
        TimePickerElementViewModel(timeSize: 23),
        TimePickerElementViewModel(timeSize: 24),
        TimePickerElementViewModel(timeSize: 25),
        TimePickerElementViewModel(timeSize: 26),
        TimePickerElementViewModel(timeSize: 27),
        TimePickerElementViewModel(timeSize: 28),
        TimePickerElementViewModel(timeSize: 29),
        TimePickerElementViewModel(timeSize: 30),
        TimePickerElementViewModel(timeSize: 31),
        TimePickerElementViewModel(timeSize: 32),
        TimePickerElementViewModel(timeSize: 33),
        TimePickerElementViewModel(timeSize: 34),
        TimePickerElementViewModel(timeSize: 35),
        TimePickerElementViewModel(timeSize: 36),
        TimePickerElementViewModel(timeSize: 37),
        TimePickerElementViewModel(timeSize: 38),
        TimePickerElementViewModel(timeSize: 39),
        TimePickerElementViewModel(timeSize: 40),
        TimePickerElementViewModel(timeSize: 41),
        TimePickerElementViewModel(timeSize: 42),
        TimePickerElementViewModel(timeSize: 43),
        TimePickerElementViewModel(timeSize: 44),
        TimePickerElementViewModel(timeSize: 45),
        TimePickerElementViewModel(timeSize: 46),
        TimePickerElementViewModel(timeSize: 47),
        TimePickerElementViewModel(timeSize: 48),
        TimePickerElementViewModel(timeSize: 49),
        TimePickerElementViewModel(timeSize: 50),
    ]
    
    var shortBreakTimeElements: [TimePickerElementViewModel] = [
        TimePickerElementViewModel(timeSize: 5),
        TimePickerElementViewModel(timeSize: 6),
        TimePickerElementViewModel(timeSize: 7),
        TimePickerElementViewModel(timeSize: 8),
        TimePickerElementViewModel(timeSize: 9),
        TimePickerElementViewModel(timeSize: 10),
    ]
    
    var longBreakTimeElements: [TimePickerElementViewModel] = [
        TimePickerElementViewModel(timeSize: 20),
        TimePickerElementViewModel(timeSize: 21),
        TimePickerElementViewModel(timeSize: 22),
        TimePickerElementViewModel(timeSize: 23),
        TimePickerElementViewModel(timeSize: 24),
        TimePickerElementViewModel(timeSize: 25),
        TimePickerElementViewModel(timeSize: 26),
        TimePickerElementViewModel(timeSize: 27),
        TimePickerElementViewModel(timeSize: 28),
        TimePickerElementViewModel(timeSize: 29),
        TimePickerElementViewModel(timeSize: 30),
    ]
    
    private var timePickerLayout: TimePickerSelectorLayout {
        return settingsView.workingPeriodTimePicker.collectionViewLayout as! TimePickerSelectorLayout
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializationTimePickerCollections()
        setupInputEvents()
    }

    override func viewDidLayoutSubviews() {
        setupTimePickerCollectionsLayouts()
        
//        settingsView.workingPeriodTimePicker.scrollToItem(
//            at: IndexPath(row: 5, section: 0),
//            at: .centeredHorizontally,
//            animated: false
//        )
//        settingsView.shortBreakTimePicker.scrollToItem(
//            at: IndexPath(row: 4, section: 0),
//            at: .centeredHorizontally,
//            animated: false
//        )
//        settingsView.longBreakTimePicker.scrollToItem(
//            at: IndexPath(row: 3, section: 0),
//            at: .centeredHorizontally,
//            animated: false
//        )
    }
}

// MARK: - Private Methods

private extension SettingsScreenViewController {
    func setActiveCellWorkingPeriodTimePicker(_ index: Int) {
        
    }
    
    func setActiveCellShortBreakTimePicker(_ index: Int) {
        
    }
    
    func setActiveCellLongBreakTimePicker(_ index: Int) {
        
    }
    
    func initializationTimePickerCollections() {
        settingsView.workingPeriodTimePicker.delegate = self
        settingsView.workingPeriodTimePicker.dataSource = self
        settingsView.workingPeriodTimePicker.register(TimePickerCollectionViewCell.self, forCellWithReuseIdentifier: "timePickerCell")
        
        settingsView.shortBreakTimePicker.delegate = self
        settingsView.shortBreakTimePicker.dataSource = self
        settingsView.shortBreakTimePicker.register(TimePickerCollectionViewCell.self, forCellWithReuseIdentifier: "timePickerCell")
        
        settingsView.longBreakTimePicker.delegate = self
        settingsView.longBreakTimePicker.dataSource = self
        settingsView.longBreakTimePicker.register(TimePickerCollectionViewCell.self, forCellWithReuseIdentifier: "timePickerCell")
    }
    
    func setupInputEvents() {
        if let layout = settingsView.workingPeriodTimePicker.collectionViewLayout as? TimePickerSelectorLayout {
            layout.timeElementRelay
                .throttle(.milliseconds(350), scheduler: MainScheduler.asyncInstance)
                .filter({ element in
                    element.truncatingRemainder(dividingBy: 0.5) == 0
                })
                .subscribe { element in
                    self.selectionWorkingPeriodTimeIndex = Int(Double(element).rounded(.down))
            }.disposed(by: disposeBag)
        }
        
        if let layout = settingsView.shortBreakTimePicker.collectionViewLayout as? TimePickerSelectorLayout {
            layout.timeElementRelay
                .throttle(.milliseconds(350), scheduler: MainScheduler.asyncInstance)
                .filter({ element in
                    element.truncatingRemainder(dividingBy: 0.5) == 0
                })
                .subscribe { element in
                    self.selectionShortBreakTimeIndex = Int(Double(element).rounded(.down))
            }.disposed(by: disposeBag)
        }
        
        if let layout = settingsView.longBreakTimePicker.collectionViewLayout as? TimePickerSelectorLayout {
            layout.timeElementRelay
                .throttle(.milliseconds(350), scheduler: MainScheduler.asyncInstance)
                .filter({ element in
                    element.truncatingRemainder(dividingBy: 0.5) == 0
                })
                .subscribe { element in
                    self.selectionLongBreakTimeIndex = Int(Double(element).rounded(.down))
            }.disposed(by: disposeBag)
        }
    }
    
    func setupTimePickerCollectionsLayouts() {
        if let layout = settingsView.workingPeriodTimePicker.collectionViewLayout as? TimePickerSelectorLayout {
            layout.setupSizeAndInsets(timeElementSize: 50)
        }
        
        if let layoutShort = settingsView.shortBreakTimePicker.collectionViewLayout as? TimePickerSelectorLayout {
            layoutShort.setupSizeAndInsets(timeElementSize: 50)
        }
        
        if let layoutLong = settingsView.longBreakTimePicker.collectionViewLayout as? TimePickerSelectorLayout {
            layoutLong.setupSizeAndInsets(timeElementSize: 50)
        }
    }
}

// MARK: - Collection Delegate

extension SettingsScreenViewController: UICollectionViewDelegate {
    func scrollTimePicker(
        _ collectionView: UICollectionView,
        to timeElementIndex: Int,
        animated: Bool = true
    ) {
        let offset = timePickerLayout.contentOffset(for: timeElementIndex)
        collectionView.setContentOffset(offset, animated: animated)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if let cell = cell as? TimePickerCollectionViewCell {
            configureCell(
                collectionView,
                cell: cell,
                indexPath: indexPath
            )
        }
    }
}

// MARK: - Collection Data Source

extension SettingsScreenViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == settingsView.workingPeriodTimePicker {
            return workingPeriodTimeElements.count
        }
        
        if collectionView == settingsView.shortBreakTimePicker {
            return shortBreakTimeElements.count
        }
        
        if collectionView == settingsView.longBreakTimePicker {
            return longBreakTimeElements.count
        }
        
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timePickerCell", for: indexPath) as? TimePickerCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView == settingsView.workingPeriodTimePicker {
            let timeElementsModel = workingPeriodTimeElements[indexPath.row]
            cell.timePickerElement = timeElementsModel
        }
        
        if collectionView == settingsView.shortBreakTimePicker {
            let timeElementsModel = shortBreakTimeElements[indexPath.row]
            cell.timePickerElement = timeElementsModel
        }
        
        if collectionView == settingsView.longBreakTimePicker {
            let timeElementsModel = longBreakTimeElements[indexPath.row]
            cell.timePickerElement = timeElementsModel
        }
        
        return cell
    }
}

// MARK: - Configure Cell Methods

private extension SettingsScreenViewController {
    func configureVisibleCell(_ timePickerType: TimePickerType) {
        switch timePickerType {
        case .workingPeriod:
            settingsView.workingPeriodTimePicker.visibleCells.forEach { cell in
                if let cell = cell as? TimePickerCollectionViewCell {
                    let index = settingsView.workingPeriodTimePicker.indexPath(for: cell)
                    self.configureCell(
                        settingsView.workingPeriodTimePicker,
                        cell: cell,
                        indexPath: index!
                    )
                }
            }
        case .shortBreak:
            settingsView.shortBreakTimePicker.visibleCells.forEach { cell in
                if let cell = cell as? TimePickerCollectionViewCell {
                    let index = settingsView.shortBreakTimePicker.indexPath(for: cell)
                    self.configureCell(
                        settingsView.shortBreakTimePicker,
                        cell: cell,
                        indexPath: index!
                    )
                }
            }
        case .longBreak:
            settingsView.longBreakTimePicker.visibleCells.forEach { cell in
                if let cell = cell as? TimePickerCollectionViewCell {
                    let index = settingsView.longBreakTimePicker.indexPath(for: cell)
                    self.configureCell(
                        settingsView.longBreakTimePicker,
                        cell: cell,
                        indexPath: index!
                    )
                }
            }
        }
    }
    
    func configureCell(
        _ collectionView: UICollectionView,
        cell: TimePickerCollectionViewCell,
        indexPath: IndexPath
    ) {
        if collectionView == settingsView.workingPeriodTimePicker {
            if selectionWorkingPeriodTimeIndex != nil {
                if selectionWorkingPeriodTimeIndex == indexPath.row {
                    cell.selectionType = .select
                } else {
                    cell.selectionType = .unselect
                }
            }
        }
        
        if collectionView == settingsView.shortBreakTimePicker {
            if selectionShortBreakTimeIndex != nil {
                if selectionShortBreakTimeIndex == indexPath.row {
                    cell.selectionType = .select
                } else {
                    cell.selectionType = .unselect
                }
            }
        }
        
        if collectionView == settingsView.longBreakTimePicker {
            if selectionLongBreakTimeIndex != nil {
                if selectionLongBreakTimeIndex == indexPath.row {
                    cell.selectionType = .select
                } else {
                    cell.selectionType = .unselect
                }
            }
        }
    }
}

// MARK: - Constants

private extension SettingsScreenViewController {
    enum NumericConstants {
        
    }
    
    enum StrokeConstants {
        
    }
}

