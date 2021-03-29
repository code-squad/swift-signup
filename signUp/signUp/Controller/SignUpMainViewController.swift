import UIKit

class SignUpMainViewController: UIViewController {
    
    private var mainViewTitle: MainTitleLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMainView()
        
        configureTitle()
    }
    
    private func setUpMainView() {
        view.backgroundColor = UIColor.systemGray6
    }
}


//MARK: -configuration && Setup

extension SignUpMainViewController {
    
    private func configureTitle() {
        mainViewTitle = MainTitleLabel(frame: CGRect(x: 125, y: 60, width: 150, height: 40), title: "회원가입")
        view.addSubview(mainViewTitle)
    }
}
