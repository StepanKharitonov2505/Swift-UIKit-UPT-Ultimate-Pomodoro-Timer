import UIKit
import RxSwift
import RxCocoa

final class SettingsScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var disposeBag: DisposeBag! = DisposeBag()
    
    // MARK: - Private Properties
    
    private let settingsView = SettingsScreenView()
    
    var timeElements: [TimePickerElementViewModel] = [
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
    
    private var timePickerLayout: TimePickerSelectorLayout {
        return settingsView.timePickerCollectionView.collectionViewLayout as! TimePickerSelectorLayout
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.timePickerCollectionView.delegate = self
        settingsView.timePickerCollectionView.dataSource = self
        settingsView.timePickerCollectionView.register(TimePickerCollectionViewCell.self, forCellWithReuseIdentifier: "timePickerCell")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let layout = settingsView.timePickerCollectionView.collectionViewLayout as? TimePickerSelectorLayout {
            layout.setupSizeAndInsets(timeElementSize: 50)
        }
    }
}

// MARK: - Private Methods

extension SettingsScreenViewController: UICollectionViewDelegate {
    func scroll(to timeElementIndex: Int, animated: Bool = true) {
        let offset = timePickerLayout.contentOffset(for: timeElementIndex)
        settingsView.timePickerCollectionView.setContentOffset(offset, animated: animated)
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
        return timeElements.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timePickerCell", for: indexPath) as? TimePickerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let timeElementsModel = timeElements[indexPath.row]
        cell.timePickerElement = timeElementsModel
        
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

