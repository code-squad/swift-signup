# swift-signup
스위프트 회원가입 프로젝트

## Step 1 회원가입 화면

- 정규식을 활용하여 입력을 처리한다.

- ID TextField
  - 아이디를 입력하는 중에는 검정색 테두리
  - 아이디 입력이 끝난 후
    - 유효하다면 초록색 테두리
    - 유효하지 않다면 빨간색 테두리
- Password TextField
  - 비밀번호를 초기 입력시 빨간색 테두리
  - 유효한 비밀번호 인경우 초록색 테두리
  - 수정시에도 계속 정규식을 체크하여 테두리 색깔이 변할 수 있음
- 이름은 null값일 수 없다. 반드시 입력해야한다.
  - 입력하지 않은 경우 "필수 입력 항목"이라고 표시되며 빨간색 테두리를 표시한다.

## 고찰♨️

### Q1. 여러개의 textFeild를 다루기 위해서는 tag값을 사용하는 방법 밖에 없을까?

한 화면 내에 여러개의 TextFeild를 가지고 있다. viewController에서는 `UITextFieldDelegate` 프로토콜을 채택하여 `textFieldShouldBeginEditing(textField:)` , `textFieldDidEndEditing(textField:)` 등의 함수를 호출한다. UITextFeild 객체의 delegate에  self(여기서 view controller)를 할당하면, 모든 textField 변수에 대하여 같은 함수들이 호출된다.  

 그러나 각 textField에 입력시, 각기 다른 정규식으로 체크해야하고, 다른 라벨을 띄워 주어야 한다. 

- 접근1) custom TextFeild를 생성한다. 

  ```swift
  class IDTextFeild : UITextField, ValidationCheck {
    func isValid() -> Bool { }
  }
  ```

  ```swift
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      return textField.isValie() // 불가능
  }
  ```

  ```swift
  if let testID = textField as? IDTextField { // 항상 false
      testID.isValid()
  }
  ```

    → 매개변수로 넘어온 값은 `textField`를 상속하고 있는 custom Type의 객체라서 `isValid`함수를 호출 할 수 있을 것이라 예상했지만, 호출 할 수 없었다. delegate를 이용하여 넘어온 매개 변수는 UITextField로써, IDTextFeild가 매개변수로 넘어오더라도 업캐스팅 되어 사용할 수 없는 것 같다. 하지만 downcasting도 불가능 하다.

- 접근2) textField의 tag값을 이용한다.

    → tag값을 이용할 수 있지만, switch case문을 매번 사용해야하므로 코드가 간결하지 않다.

- 접근3) Title Label, TextField, Under Label 3개를 묶어서 하나의 ViewModel로 가지고 있으면 어떨까? 

  - 하나의 ViewController 안에 1개의 viewModel VS 4개의 viewModel
  - ViewModel에서 view에 해당하는 label까지 가지고 있는것이 바람직한가??
  - 여전히 textField delegation에 대한 처리에 대한 고민은 남아있다.
    - AddTarget?!?!?

- 접근4) Notification Center를 이용하여 text field 값이 변경될 때 notification을 보낸다. ✔️
  - TextField도 UIcontrol을 확장하고 있으므로, addTarget이 가능하다.
  
- 접근5) RxSwift에서 사용하는 TextField.rx.text.bind(:to) 처럼 해보기

  - Text(String), valid(Bool)를 가지고 있는 view model을 생성한다.
  - TextField에 text 변화에 대해 view model의 text와 bind한다.
  -  view model의 text가 변경된 경우 
  - validation을 체크하여 valid의 상태를 변경한다.
  - 변경된 valid에 대해서 view controller에게 알린다. (bind과정 필요)
  - lebel을 다시 그린다.


### Q2. UITextField.textDidChangeNotification을 설정했더니, id값이 바뀌었을 때에도 password 도 같이 반응한다. 이를 분리할 수 없을까?

`UITextField`를 상속받고 있는 custom textField class(IDTextFiled)를 생성했다. 목적은 아이디 text field에 값이 변경될 떄 특정 메소드를 호출하는 것이다. `textDidChangeNotification`을 이용하여 적절히 처리하고, 이후 또 다른 custom textField class(PasswordTextFiled)를 생성하였다.

`PasswordTextField.textDidChangeNotification`을 호출할 때에, `IDTextFiled.textDidChangeNotification`이 같이 호출 되는 문제가 발생하였다. `textDidChangeNotification`은 기존 UITextField에서 가지고 있는 상수로 UITextField를 상속받고 있는 모든 클래스에서 동일하게 작동하였던 것 같다.

- 접근1) custom Notification을 만들기
  - post하는 곳을 지정 할 수 없다.
- 접근2) UIControl의 addTarget이용하기 ✔️
  - 원하는 상태, 예를들어 textField가 수정된 상황 (`.editingChanged`)에 대한 selector 함수를 만든다.
  ```swift
  self.addTarget(self,
                 action: #selector(IDTextField.textFieldDidBeginEditing(_:)), 
                 for: .editingChanged)
  ```



### Q3. TextField가 생성되기 전에 TextField.text값에 접근하려고 하여 에러 발생

UITextField를 code로 생성했다면 생성되는 시점을 보장 할 수 있다. 그런데 StoryBoard로 생성하여 강제 언랩핑을 하고있으므로 생성 이후 접근하는 것을 보장할수 없어졌다. TextField 생성을 보장하여 생성된 이후에 text에 접근 할 수 있는 방법이 있을까?

```swift
@IBOutlet weak var id: UITextField!
```

```swift
guard let text = textField.text else { return false } // Error
```

- 접근1) textField에 대한 guard let 구문 이용하기

  ```swift
  guard let _ = textField else { return false }
  ```

  error: `Initializer for conditional binding must have Optional type, not 'UITextField'` UITextField는 Optional 타입이 아니므로 `guard let` 구문을 활용할 수 없다.
- 접근2) textField의 text값을 접근하는 내부 메소드를 삭제 할 수 밖에 없다. ✔️

## Step2 keyboard control

- 비밀번호 형태는 *** 형태로 표시한다.
- 비밀번호 입력 값과, 재 확인 입력 값이 같아야 한다.
- 입력할 때에 키보드에서 엔터부분을 Next 역할로 바꾼다.
- 항목입력 후 다음 항목으로 자동으로 넘어간다.
- 마지막 항목까지 입력 하고 return을 누른 경우 키보드가 사라진다.
- 키보드가 화면을 가리지 않도록 한다.
- 모든 항목 입력시에만 다음 버튼이 활성화 된다.
- 모든 항목 조건이 맞을 때만 다음 화면으로 넘어간다.

## Step3 Network 연결

- 확인 버튼을 누르면 네트워크에 연결을 시도한다.
- URLSession에 연결한다.
- id, password 둘다 값이 존재하는 경우 post 메시지를 요청한다.
- get 메소드로 아이디 리스트를 받아 중복을 체크한다.
- 아이디가 중복 된 경우 오류가 리턴된다.

## Step4 개인정보 입력 화면

- Date Picker를 사용한다.
  - 하단에 선택 버튼을 누르면 선택한 날짜를 표시한다.
- Segmented Control을 이용하여 성별을 선택할 수 있다. 
- 이메일 주소
  - 이메일용 키보드를 표시한다.
  - 조건에 부합하지 않을 때 메시지가 출력된다.
  - 조건에 부합하면 메시지는 사라진다.
- 휴대전화
  - 숫자 전용 키보드를 표시한다.
  - 조건에 부합하지 않는 경우 메시지를 출력한다.
- 모든 항목이 조건을 통과하면 다음 버튼이 활성화 된다.
- 이전 버튼을 눌러서 돌아가면 현재 화면에서 입력했던 내용은 사라져도 된다.
- 이전 화면은 입력했던 정보가 남아있어야 한다.

## Step5 개인 정보 수집 및 이용에 대한 안내 화면

- Modal로 개인 정보 수집 및 이용에 대한 안내 화면을 띄운다.
- 내용은 화면 보다 길어야한다.
- 마지막 글까지 스크롤이 되어야한다.
- 동의 버튼과 취소 버튼이 있다.
  - 동의 버튼을 누른 경우, 애니메이션 없이 다음화면으로 이동한다.
  - 취소 버튼을 누른 경우, 지금 화면이 사라지는 애니메이션을 보여주고, 이전 화면으로 돌아간다. 이때, 이전 화면의 정보들은 남아 있어야 한다.

## Step6 관심사 키워드 화면

- 관심사 키워드는  CollectionViewFlowLayout을 적용한다.
- 관심사를 입력하지 않으면 하단에 안내 문구를 표시한다.
  - 최소 3개 이상 선택하도록 한다.
  - 추가할 때마다 개수가 변경되고, 3개 이상 되면 안내 문구가 사라진다.
- 추가하는 관심사 키워드는 아래 영역에 추가한다.
- 키워드 추가시 다음 줄로 넘어갈 수 있다.
- 3줄 이상이 되면 더이상 추가하지 않도록 textFeild를 비활성화 시킨다.
- 키워드마다 x버튼을 추가하고, 누르면 해당 키워드를 삭제한다.
- 완료 버튼은 모든 항목이 조건을 통과하면 활성화 한다.
- 완료를 누르면 가입 신청을 완료한다.
- 만약 이전 버튼을 누르는 경우, 개인 정보 동의 화면이 아니라 개인 정보 입력 화면으로 돌아간다.
- 키보드 엔터 버튼은 관심사 3개를 추가할 때까지는 ADD로 동작
- 3개 이상 추가하고 나면 Done으로 표시하고 완료버튼과 동일하게 동작한다.

## Step7 로그인 화면

