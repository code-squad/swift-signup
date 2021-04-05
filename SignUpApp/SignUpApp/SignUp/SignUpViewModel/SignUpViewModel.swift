//
//  SignUpViewModel.swift
//  SignUpApp
//
//  Created by Jun Ho JANG on 2021/03/30.
//

import Foundation

class SignUpViewModel {
    
    let mainTitle = "회원가입"
    let emptyString = " "
    
    let idContent: SignUpInfo = SignUpInfo(title: "아이디", placeholder: "영문 소문자, 숫자, 특수기호(_, -), 5~20자", warning: "이미 사용중인 아이디입니다.")
    let passwordContent: SignUpInfo = SignUpInfo(title: "비밀번호", placeholder: "영문 대/소문자, 숫자, 특수문자(!@#$%) 8~16자", warning: "안전한 비밀번호입니다.")
    let checkPasswordContent: SignUpInfo = SignUpInfo(title: "비밀번호 재확인", placeholder: "", warning: "비밀번호가 일치하지 않습니다.")
    let userNameContent: SignUpInfo = SignUpInfo(title: "이름", placeholder: "", warning: "이름은 필수 입력 항목입니다.")
    
}
