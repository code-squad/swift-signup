//
//  ViewController.swift
//  swift-signup
//
//  Created by 박정하 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {
    private var recycleView : UserRegisterForm!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        recycleView = UserRegisterForm.init(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        recycleView = UserRegisterForm.init(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
    }
    override func viewWillAppear(_ animated: Bool) {
        settSignUpView()
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController {
    private func settSignUpView(){
        let recycleViewtitle = UILabel()
        recycleViewtitle.text = "회원가입"
        recycleViewtitle.textColor = .systemGreen
        recycleViewtitle.font = UIFont.boldSystemFont(ofSize: 30)
        recycleViewtitle.sizeToFit()
        recycleViewtitle.frame.origin = CGPoint(x: self.recycleView.frame.size.width / 2 - recycleViewtitle.frame.size.width / 2, y: 30)
        
        let NextButton = UIButton()
        NextButton.setTitle("다음", for: .normal)
        NextButton.setTitleColor(.systemGreen, for: .normal)
        NextButton.layer.borderColor = UIColor.black.cgColor
        NextButton.layer.borderWidth = 0.5
        NextButton.setImage(UIImage(systemName: "chevron.forward.circle.fill"), for: .normal)
        NextButton.tintColor = .systemGreen
        NextButton.frame.size = CGSize(width: 85, height: 44)
        NextButton.frame.origin = CGPoint(x: self.recycleView.frame.width/2 - NextButton.frame.width/2, y: 432)
        
        
        recycleView.addUserRegisterForm(element: UserRegisterFormElement(frame: CGRect(x: 36, y: 91 + (83 * recycleView.currentCount()), width: 302, height: 80), title: "아이디", placeholder: "영문 소문자, 숫자, 특수기호(_,-), 5~20자", posindex: recycleView.currentCount()))
        recycleView.addUserRegisterForm(element: UserRegisterFormElement(frame: CGRect(x: 36, y: 91 + (83 * recycleView.currentCount()), width: 302, height: 80), title: "비밀번호", placeholder: "영문 대/소문자, 숫자, 특수문자(!@#$%) 8~16자", posindex: recycleView.currentCount()))
        recycleView.addUserRegisterForm(element: UserRegisterFormElement(frame: CGRect(x: 36, y: 91 + (83 * recycleView.currentCount()), width: 302, height: 80), title: "비밀번호 재 확인", placeholder: "", posindex: recycleView.currentCount()))
        recycleView.addUserRegisterForm(element: UserRegisterFormElement(frame: CGRect(x: 36, y: 91 + (83 * recycleView.currentCount()), width: 302, height: 80), title: "이름", placeholder: "", posindex: recycleView.currentCount()))
        self.recycleView.addSubview(NextButton)
        self.recycleView.addSubview(recycleViewtitle)
        self.view.addSubview(recycleView)
    }
}

