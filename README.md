# SignUp App 

- 설계 요구사항에 따라 제작하는 습관기르기
- 일주일간의 프로젝트를 일일 단계로 나눠서 어떻게 작업할지 정하기

| `요일` | `키워드`                                  | `부가 설명`                                                  |
| ------ | ----------------------------------------- | ------------------------------------------------------------ |
| 월요일 | 화면 구성 및 연결                         | 네비게이터를 이용한 이전,다음 화면을 보여주기                |
| 화요일 | 정규 표현식, 네트워크 연결                | 회원가입에 필요한 필수요소 만들기/ 네트워크 연결 테스트 시작 |
| 수요일 | 네트워크 연결 심화, MVC                   | 네트워크 연결 심화 공부하기, 구조화 작업하기                 |
| 목요일 | 앱 심사/제출                              | 앱 제출 테스트하기                                           |
| 금요일 | 버그 수정 및 추가 요구사항 고치기, 회고록 | 밀려있는 잔버그 고치기, 회고록 작성하기.                     |



**나만의 규칙**

- `MVC`에서 V는 코드로 만들지 않고 모두 스토리보드에서 생성하기로 한다. 코드로 뷰만드는 것 없이.

- 회사를 다니는 것처럼 정해진 시간동안 무조건 프로젝트 일하기

- To do/Doing/Done 차트를 이용해보기

  



----

## Step 1 : 화면 구성하기

 2021.03.29

- 각 화면마다 다음 화면으로 어떻게 넘어가는지 구성한다. (`navigation`, `modal`)
- 이번 앱은 `스토리보드`로 작업한다
- `Views`그룹에 해당 화면 4개를 넣는다.(로그인 화면은 따로 그룹이 되어있고 이점은 후에 생각해봐야 할 일)
- 이전 화면/ 다음화면 연결 구성을 `테스트` 하는 습관을 가진다.



### 오늘의 학습내용 😀🥲

- 공부하다보니 버튼을 만들어서 서로 이어지는 과정을 구현하지 못하였다.

- `MVC`에 대해서 헷갈리게 되어 다시금 연습을 하였다. 특히 `View`와 `Controller`

- 중간에 다른길로 샜는데 그것은 Custom `UILabel`을 만드는 일이었다.

  - 요구 명세서에 보면 모든 화면(정책 승인 페이지)에는 해당 타이틀이 존재하고 동일한 위치 및 색상등 공통 attribute가 많은 것을 파악하였다.

  - 따라서 Model에 Custom `UILabel`을 제작하고 모든 컨트롤러에 사용될 수 있게 제작하였다.

  - <img width="200" alt="Screen Shot 2021-03-29 at 11 28 31 PM" src="https://user-images.githubusercontent.com/52390975/112853003-6ae26880-90e7-11eb-8dd7-13ea436ec190.png">

  - 동일한 옵션 = `글자색상`, `배열`, `크기`, `위치`,  `autolayout`

  - 상속받는 옵션 = `텍스트`(enum으로 구현), `view`(각 컨트롤러에 self.view)

  - ```swift
    class SceneTitleLabel: UILabel {
        
        init(text : String) {
            super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            super.text = text
            super.textColor = .green
            super.textAlignment = .center
            super.translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func autoLayOutLabel(view : UIView) {
            super.topAnchor.constraint(equalTo: view.topAnchor
                        ,constant: 100).isActive = true
            super.leftAnchor.constraint(equalTo: view.leftAnchor
                        , constant: 40).isActive = true
            super.rightAnchor.constraint(equalTo: view.rightAnchor
                        , constant: -40).isActive = true
        }
        
    }
    ```

- 각 요일별 step을 내 스스로 작성하다보니 샛길로 많이 샜다. 회사에서 일하듯 내가 하고픈 개발이 있어도 그날의 할 일에 대해 우선권을 두기.



<img width="200" src = https://user-images.githubusercontent.com/52390975/112853044-7170e000-90e7-11eb-868b-3a43f48f21fc.png>
