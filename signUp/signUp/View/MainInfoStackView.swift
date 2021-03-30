import UIKit

class MainInfoStackView: UIStackView {
    
    private(set) var infoIDView = EachInfoView()
    private(set) var infoPasswordView = EachInfoView()
    private(set) var dobleCheckPassWordView = EachInfoView()
    private(set) var nameCheckView = EachInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMainStackView()
        setUpSubViews()
    }
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpMainStackView()
        setUpSubViews()
    }
    
    private func setUpMainStackView() {
        axis = .vertical
        spacing = 10
    }
    
    private func setUpSubViews() {
        setUpIDInfoView()
        setUpPassWordInfoView()
        setUpDoubleCheckInfoView()
        setUpnameCheckInfoView()
    }
}

//MARK: -setUp Elements Of StackView
extension MainInfoStackView {
    
    private func setUpIDInfoView() {
        infoIDView.infoLabel.text = "아이디"
        infoIDView.inputTextField.attributedPlaceholder = NSAttributedString(string: " 영문 소문자, 숫자, 특수기호(_,-), 5~20자")
        self.addArrangedSubview(infoIDView)
    }

    private func setUpPassWordInfoView() {
        infoPasswordView.infoLabel.text = "비밀번호"
        infoPasswordView.inputTextField.attributedPlaceholder = NSAttributedString(string: " 영문 대/소문자, 숫자, 특수문자(!@#$%), 8~16자")
        self.addArrangedSubview(infoPasswordView)
    }

    private func setUpDoubleCheckInfoView() {
        dobleCheckPassWordView.infoLabel.text = "비밀번호 재확인"
        self.addArrangedSubview(dobleCheckPassWordView)
    }
    
    private func setUpnameCheckInfoView() {
        nameCheckView.infoLabel.text = "이름"
        self.addArrangedSubview(nameCheckView)
    }
}

//MARK: -Condition & Regex
extension MainInfoStackView {
    private func conditionForID() -> Bool {
        return checkTextForID(infoIDView.inputTextField.text)
    }
    
    private func conditionForPassWord() -> Bool {
        let password = infoPasswordView.inputTextField.text ?? "a"
        let passwordCheck = dobleCheckPassWordView.inputTextField.text ?? "b"
        return checkTextForPassWord(password) && password == passwordCheck
    }
    
    private func conditionForName() -> Bool {
        return checkTextForName(nameCheckView.inputTextField.text)
    }
    
    private func checkTextForID(_ id: String?) -> Bool {
        let idTest = id?.getArrayAfterRegex(regex: "[a-z0-9_-]").count ?? 0
        return idTest >= 5 && idTest <= 20
    }
    
    private func checkTextForPassWord(_ password: String?) -> Bool {
        let passwordTest = password?.getArrayAfterRegex(regex: "[a-zA-Z0-9!@#$%]").count ?? 0
        return passwordTest >= 8 && passwordTest <= 16
    }
    
    private func checkTextForName(_ name: String?) -> Bool {
        let nameTest = name?.getArrayAfterRegex(regex: "[가-힣]").count ?? 0
        return nameTest >= 2
    }
    
    func enableCheckForNextPage() -> Bool {
        return conditionForID() && conditionForPassWord() && conditionForName()
    }
}
