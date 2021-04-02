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

## step.2

### URLSession
```swift
import Foundation

class NetworkHandler {
    
    static private var idData = [String]()
    
    static func getData(completion: @escaping ([String]) -> Void) {
            // 세션 생성, 환경설정
            let defaultSession = URLSession(configuration: .default)

            guard let url = URL(string: "https://8r6ruzgzve.execute-api.ap-northeast-2.amazonaws.com/default/SwiftCamp") else {
                print("URL is nil")
                return
            }
        let request = URLRequest(url: url)
        
        let dataTask = defaultSession.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else { return }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            let result = String(data: data, encoding: .utf8) ?? ""
            
            idData = result.components(separatedBy: [",", "[", "\"", " ", "]"]).filter{$0.count > 0}
            completion(idData)
        }
        dataTask.resume()
    }
}
```
#### session
(1). Default Session: 기본적인 session으로 디스크 기반 캐싱을 지원  
(2). Ephemeral Session: 어떠한 데이터도 저장하지 않는 형태의 세션  
(3). Background Session: 앱이 종료된 후에도 통신이 이뤄지는 세션  

#### Task
(1). Data Task: Data 객체를 통해 데이터를 주고받는 Task  
(2). Download Task: Data를 파일형태로 전환 후 다운받는 Task(백그라운드 다운로드 지원)  
(3). Upload Task: Data를 파일형태로 전환 후 업로드하는 Task  

#### escaping closure
- escaping closure 활용하여 메서드 작업이 완료된 후, 데이터를 반환

### UITextFieldDelegate
```swift
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.layer.borderWidth = 1.0
        return true
    }

}
```
- UITextFieldDelegate 객체 생성하여 textfield에 적용
- textfield의 delegate를 delegate 객체가 처리

### 실행화면
<img src="https://user-images.githubusercontent.com/74946802/113122755-e3b00480-924e-11eb-9737-347c8aa17437.gif" width="300" height="600">

## step.3

### DatePicker
```swift
private func setDatePicker() {
    let birthdayTextField = privacyStackView.birthdayInfo.inputTextField
    datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
    datePicker.datePickerMode = .date
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.maximumDate = DateFormatManager.setUpMaxDateRagne()
    datePicker.minimumDate = DateFormatManager.setUpMinDateRange()
    birthdayTextField.inputView = datePicker

    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(datePickerCancelled))
    let done = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(datePickerSelected))
    toolBar.setItems([cancel, flexible, done], animated: false)
    birthdayTextField.inputAccessoryView = toolBar
}
```
- UIDatePicker 활용하여 날짜를 선택하면 생년월일 TextField에 값 입력 구현
- 선택가능한 나이는 15세 ~ 99세로 설정
- ToolBar사용을 의도한 것은 아니었으나, 별도 구현 방법이 떠오르지않아 툴바를 사용하여 구현

#### 실행화면

<img src="https://user-images.githubusercontent.com/74946802/113413037-b56c2980-93f4-11eb-9496-e91d6351e92e.gif" width="300" height="600">
