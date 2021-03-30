import UIKit

class MainInfoStackView: UIStackView {
    
    private var infoIDView = EachInfoView()
    private var infoPasswordView = EachInfoView()
    private var dobleCheckPassWordView = EachInfoView()
    private var nameCheckView = EachInfoView()
    
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
        infoIDView.inputTextField.text = " 영문 소문자, 숫자, 특수기호(_,-), 5~20자"
        self.addArrangedSubview(infoIDView)
    }

    private func setUpPassWordInfoView() {
        infoPasswordView.infoLabel.text = "비밀번호"
        infoPasswordView.inputTextField.text = " 영문 대/소문자, 숫자, 특수문자(!@#$%), 8~16자"
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
        let conditionForID = infoIDView.inputTextField.text?.getArrayAfterRegex(regex: "[a-z0-9_-]").count ?? 0
        return conditionForID >= 5 && conditionForID <= 20
    }
    
    private func conditionForPassWord() -> Bool {
        let conditionForPassWord = infoPasswordView.inputTextField.text?.getArrayAfterRegex(regex: "[a-zA-Z0-9!@#$%]").count ?? 0
        let conditionForDoubleCheckPassWord = dobleCheckPassWordView.inputTextField.text?.getArrayAfterRegex(regex: "[a-zA-Z0-9!@#$%]").count ?? 0
        let equalTest1 = infoPasswordView.inputTextField.text ?? "a"
        let equalTest2 = dobleCheckPassWordView.inputTextField.text ?? "b"
        return conditionForPassWord >= 8 && conditionForDoubleCheckPassWord <= 16 && equalTest1 == equalTest2
    }
    
    private func conditionForName() -> Bool {
        let conditionForName = nameCheckView.inputTextField.text?.getArrayAfterRegex(regex: "[가-힣]").count ?? 0
        return conditionForName >= 2
    }
    
    func enableCheckForNextPage() -> Bool {
        return conditionForID() && conditionForPassWord() && conditionForName()
    }
}
