import UIKit
import RxSwift

/**
 The view controller responsible for listing all the campaigns. The corresponding view is the `CampaignListingView` and
 is configured in the storyboard (Main.storyboard).
 */
class CampaignListingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let customAlert = CustomAlert()
    
    @IBOutlet
    private(set) weak var typedView: CampaignListingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(typedView != nil)
    }
    
    func loadCampain() -> Void {
        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] campaigns in
                self?.typedView.display(campaigns: campaigns)
                },
                       onError: { [weak self] error in
                        self?.customAlert.showMessage(type: MessageType.error, title: "", subTitle: "There was an error. Please check your internet connection and try again.", buttonTitle: "retry", action: {
                                                guard let `self` = self else { return }
                                                self.loadCampain()
                            })
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load the campaign list and display it as soon as it is available.
        loadCampain()
    }
}
