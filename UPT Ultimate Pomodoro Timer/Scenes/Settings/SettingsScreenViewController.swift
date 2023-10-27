import UIKit
import RxSwift
import RxCocoa

final class SettingsScreenViewController: UIViewController {
    
    var disposeBag: DisposeBag! = DisposeBag()
    
    override func loadView() {
        self.view = SettingsScreenView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private Methods

private extension SettingsScreenViewController {
    
}

