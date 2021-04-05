# swift-signup
## Step-1 회원가입 첫 번째 화면 만들기

<p align="center">
<img width="400" alt="step1" src="https://user-images.githubusercontent.com/45817559/113590903-371abc00-966e-11eb-9136-0202a2f8ba19.gif">
</p>

- 스토리보드로 화면 작성
    - TextField의 KeyType, Button의 Enable 초기 설정 등
- TextField의 Delegate 분리
    - 타입을 만들어 Delegate를 구현해서, ViewController가 Delegate를 직접 채택하지 않도록 함
- ID는 5~20자의 영문 소문자, 숫자와 특수기호(-, _)만 사용 가능
- Password는 8~16자의 영문 대/소문자, 숫자, 특수문자를 조합해야 함
- 이름은 꼭 입력해야 한다.
- 모든 항목이 조건에 부합하면 버튼이 활성화된다.


