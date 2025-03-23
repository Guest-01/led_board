# 전광판(`led_board`)

> 휴대폰을 전광판으로 만들어주는 모바일 애플리케이션

| 구글 플레이스토어 | 애플 앱스토어 |
|-|-|
|(배포 준비중)|(배포 준비중)|

## 스크린샷

| 초기화면 | 문구 입력 | 시작하기 |
|-|-|-|
|![Screenshot_20240119_172630](https://github.com/Guest-01/led_board/assets/49602144/efe107be-6735-44e3-ad01-f6893aa21de3)|![Screenshot_20240119_172721](https://github.com/Guest-01/led_board/assets/49602144/a4dc191a-98c1-4d4d-8eba-cd5180cebb5c)|![Screenshot_20240119_172731](https://github.com/Guest-01/led_board/assets/49602144/5b2d63d8-326b-45f6-a7d4-179dd896ab4c)|

## 빌드 방법

### Google AdMob ID

구글 애드몹 광고가 내장되어 있어 애드몹 아이디가 필요합니다. 아래 경로에 입력해줍니다.

`android/local.properties`
```env
admobAppId=YOUR_ADMOB_APP_ID
```

`lib/secrets.dart`
```dart
var adUnitId = "YOUR_AD_UNIT_ID";
```

### Upload Key

구글 플레이스토어에 업로드하기 위해서는 업로드 키로 싸인이 필요합니다. 가지고 있는 혹은 생성한 업로드 키에 대한 정보를 아래 경로에 입력합니다.

`android/key.properties`
```env
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>
```

위 정보가 모두 입력되었으면, 여느 Flutter 앱과 같이 아래 커맨드로 빌드하면 됩니다.

```sh
flutter pub get
flutter build appbundle
```

(작성중)
