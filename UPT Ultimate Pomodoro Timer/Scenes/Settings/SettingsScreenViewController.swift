import UIKit
import RxSwift
import RxCocoa

final class SettingsScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var disposeBag: DisposeBag! = DisposeBag()
    
    // MARK: - Private Properties
    
    private let settingsView = SettingsScreenView()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
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

// MARK: - Private Methods

extension SettingsScreenViewController: UICollectionViewDelegate {
    func scroll(to timeElementIndex: Int, animated: Bool = true) {
        let offset = timePickerLayout.contentOffset(for: timeElementIndex)
        settingsView.workingPeriodTimePicker.setContentOffset(offset, animated: animated)
    }
}

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

// MARK: - Constants

private extension SettingsScreenViewController {
    enum NumericConstants {
        
    }
    
    enum StrokeConstants {
        
    }
}

