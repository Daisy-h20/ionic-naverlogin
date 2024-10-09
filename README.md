# Naver Login Plugin

## Setting Up

### 1. Naver Developers Setup

- **Naver Developers** 사이트에서 설정을 시작합니다.  
  [Naver Developers](https://developers.naver.com/apps/#/list)

#### 1.1 developer 설정

1. Application 등록
2. Apllication에서 API설정 이동하여 이메일 주소 필수 설정
3. Android 패키지이름, IOS 패키지이름 작성 후 IOS URL Scheme까지 작성
4. Application명 / ClientId / Client Secret / URL Scheme 기억하기

---

### 2. Naver Plugin 설정

#### 2.1 Android 설정

- Android 설정 해당 사항이 없습니다. (X)

#### 2.2 iOS 설정

- iOS 설정 해당 사항이 없습니다. (X)

---

## Usage Example

```javascript
let emailObject = await naverLogin
      .naverLogin({
        serviceUrlScheme: ${serviceUrlScheme},
        naverClientId: ${naverClientId},
        naverClientName: ${naverClientName},
        naverClientSecret: ${naverClientSecret},
      })

console.log(emailObject.email);
```
