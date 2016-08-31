# React Native : 카카오 로그인 (kakao login)
`[카카오 로그인](https://developers.kakao.com/docs)

`<FBLogin />` provides a [React Native][react-native] component wrapping the native [Facebook SDK login button](https://developers.facebook.com/docs/reference/ios/current/class/FBSDKLoginButton/) and [manager](https://developers.facebook.com/docs/reference/ios/current/class/FBSDKLoginManager/).

**Note**: 카카오 로그인 샘플 프로젝트 포함 되어 있고 참조하면 됩니다.

## 사용법


```js
import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
} from 'react-native';

import KakaoLogin from "react-native-kakao-login"

console.log('kakaologin', KakaoLogin)

class exampleKakaoLogin extends Component {
  async login(){
    try{
      var data = await KakaoLogin.login()
      console.log('kakao data', data)
    }catch(e){
      // if(e.code === 'KAKAO_LOGIN_CANCEL'){//사용자가 취소
      // }
      // console.log('kakao error receive......', JSON.stringify(e) )
      console.log('kakao error receive......', e.code )
    }
  }

  async logout(){
      var data = await KakaoLogin.logout()
      console.log('kakao data', data)
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={()=>this.login()}>
          <Text>카카오로그인</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={()=>this.logout()}>
          <Text>카카오로그아웃</Text>
        </TouchableOpacity>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});

AppRegistry.registerComponent('exampleKakaoLogin', () => exampleKakaoLogin);
```

## 설치
* install
```
npm i -S react-native-kakao-login
```

* native setup
```
rnpm link react-native-kakao-login
```

## Copyright and license

MIT license

