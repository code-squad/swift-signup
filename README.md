# swift-signup

## Step.1

### 회원가입 MainView 만들기

- 반복되는 View 코드로 구현
- StackView의 SubView로 추가 
  

### 정규표현식

```swift
let conditionForID = infoIDView.inputTextField.text?.getArrayAfterRegex(regex: "[a-z0-9_-]").count ?? 0
let conditionForPassWord = infoPasswordView.inputTextField.text?.getArrayAfterRegex(regex: "[a-zA-Z0-9!@#$%]").count ?? 0
let conditionForName = nameCheckView.inputTextField.text?.getArrayAfterRegex(regex: "[가-힣]").count ?? 0
```

- 정규표현식 활용하여 버튼 활성화 / 비활성화 여부 체크
- 정규표현식은 NSRegularExpression 활용하여 String extension

### 버튼 활성화/비활성화
```swift
enum buttonState {
        case on
        case off
    }
    
var isOn: buttonState = .off {
    didSet {
        enableButton()
    }
}
private func enableButton() {
    switch isOn {
    case .off:
        setTitleColor(.systemGray, for: .normal)
        isEnabled = false
    case .on:
        setTitleColor(.systemGreen, for: .normal)
        isEnabled = true
    }
}
    
```

- Custom 버튼 Class 내부에 위 메서드생성하여 TextField값 바뀔 때마다 on/off 업데이트

### 실행화면
<img src="https://user-images.githubusercontent.com/74946802/112923466-51720880-9149-11eb-9940-c046e6a00b49.gif" width="300" height="600">
