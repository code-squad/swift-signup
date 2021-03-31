# (회원가입 프로젝트)swift-signup
## Major Implementation
### 1. (branch sign-up) 회원가입 초기 화면 구현 2021.03.31 19:54:12
#### Major features
- [x] 회원가입 화면을 구성한다 
- [x] Place holder로 텍스트 필드의 필요 조건을 표시한다
- [x] TextField Delegate를 뷰 컨트롤러 이외의 파일에 모듈화한다.
- [x] 조건에 맞지 않는 입력값을 확인하여 UI에 반영한다.
- [x] 서버에서 아이디 데이터를 받아 아이디 유효성을 검사한다.
- [x] 요구 입력사항 충족시 다음 화면으로 가는 버튼을 활성화 한다.
- [x] 두번째 Scene으로 넘기는 애니메이션을 코드로 구현한다.

#### Study keywords
- TextField Delegate
- Delegate Pattern
- URLSession
- Escaping Closure
- GCD
- CATransition

#### Display
<img src="images/sign-up-rec.gif" width="300"> 

#### 고민과 해결
UserInputValidator에 URLSession을 이용해 서버의 아이디 목록을 파싱해 아이디 중복 여부를 검사하는데 검사가 반영되지 않는 오류가 발생. URLSession은 자체 비동기 실행인 걸 기억해내 completionHandler로 검사가 끝나면 UI를 수정하는 코드가 실행되도록 구현. 여전히 오류가 발생. UI를 수정하는 코드를 `DispatchQueue.main.async`로 구현. 고민해결.

#### 의문점
API POST와 GET의 개념을 아직 잘 모르겠습니다. 일단 간단한 방법으로 아이디 중복검사는 하였지만 API POST와 GET을 자세히 알면 구조화된 정확한 정보와 서버 정보 수정도 되는 걸까라고 예상하고 있습니다. 이쯤에서 첫번째 화면 완성 PR을 보내지만 이 의문에 대해선 계속 고민해보고 알아보겠습니다~.

.gitignore 파일을 추가했는데도 userInterfaceState 파일이 계속 tracking 되고 있습니다. 이전 프로젝트까지 특히 gitignore파일을 추가하지 않아도 해당 파일이 트래킹되는 일은 없었는데 무슨 차이로 이런 일이 생긴지 모르겠습니다. 일단 commit 할 때 해당 파일을 제외하고 있기는 한데 좀 더 근본적인 문제점을 찾아봐야겠습니다.
