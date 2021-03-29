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
    
    // 기능테스트를 위해 임시로 추가한 조건 반드시 수정해야 함 -> 정규표현식으로
    func enableCheckForNextPage() -> Bool {
        let conditionForID = infoIDView.inputTextField.text?.count ?? 0
        let conditionForPassWord = infoPasswordView.inputTextField.text?.count ?? 0
        let conditionForDoubleCheckPassWord = dobleCheckPassWordView.inputTextField.text?.count ?? 0
        let conditionForName = nameCheckView.inputTextField.text?.count ?? 0
        return conditionForID>=4 && conditionForPassWord>=4 && conditionForDoubleCheckPassWord>=4 && conditionForName>=4
    }
}

//MARK: -setUp Elements Of StackView
extension MainInfoStackView {
    
    private func setUpIDInfoView() {
        infoIDView.infoLabel.text = "아이디"
        infoIDView.inputTextField.text = " 영문 소문자, 숫자, 특수기호, 5~20자"
        self.addArrangedSubview(infoIDView)
    }

    private func setUpPassWordInfoView() {
        infoPasswordView.infoLabel.text = "비밀번호"
        infoPasswordView.inputTextField.text = " 영문 대/소문자, 숫자, 특수문자, 8~16자"
        self.addArrangedSubview(infoPasswordView)
    }

    private func setUpDoubleCheckInfoView() {
        dobleCheckPassWordView.infoLabel.text = "비밀번호 재확인"
        dobleCheckPassWordView.inputTextField.text = " 같은 비밀번호를 입력해주세요."
        self.addArrangedSubview(dobleCheckPassWordView)
    }
    
    private func setUpnameCheckInfoView() {
        nameCheckView.infoLabel.text = "이름"
        nameCheckView.inputTextField.text = " 이름을 입력해주세요."
        self.addArrangedSubview(nameCheckView)
    }
}
