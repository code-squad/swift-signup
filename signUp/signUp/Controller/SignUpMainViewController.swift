import UIKit

class SignUpMainViewController: UIViewController {
    
    private var mainViewTitle: MainTitleLabel!
    private var mainStackView = MainInfoStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainView()
    }
    
    private func setUpMainView() {
        //MainView Background Color
        view.backgroundColor = UIColor.systemGray6
        
        configureTitle()
        
        configureMainStackView()
    }
}


//MARK: -configuration && Setup

extension SignUpMainViewController {
    
    private func configureTitle() {
        mainViewTitle = MainTitleLabel(frame: CGRect(x: 125, y: 60, width: 150, height: 40), title: "회원가입")
        view.addSubview(mainViewTitle)
    }
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    }
}
