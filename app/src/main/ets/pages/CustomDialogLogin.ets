import http from '@ohos.net.http'
import systemDateTime from '@ohos.systemDateTime';
import CryptoJS from '@ohos/crypto-js'
import ServerInfo from '../viewModel/ServerInfo';
import { TitleBar } from './TitleBar';

interface From {
  AppId:string;
  AppSecret:string;
  AccountId:string;
  AccountSecret:string;
  Timestamp: number;
  Token: string;
}

// 定义自定义弹框
@CustomDialog
export struct CustomDialogLogin {
  @State server: ServerInfo[] = []
  @State form:From= {
    AppId: 'rocksea',
    AppSecret: '87339549',
    AccountId: '',
    AccountSecret: '',
    Timestamp: 0,
    Token: ''
  }

  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogLogin({}),
  })


  build() {
    Column(){
      Column(){
        Text(this.server[0].regionName+'-账号验证')
          .fontColor('#FFFFFF')
      }
      .width("100%")
      .height(50)
      .backgroundColor('#5b73de')
      .justifyContent(FlexAlign.Center)
      Row(){
        Text("账号").padding({left:20,right:20})
        TextInput({ placeholder: "账号",text:'' }).type(InputType.Normal).width("70%")
          .onChange((v:string)=>{
            this.form.AccountId = v
          })
      }
      .padding({left:10,right:10,top:10})
      .width("100%")
      Row(){
        Text("密码").padding({left:20,right:20})
        TextInput({ placeholder: "密码",text:''  }).type(InputType.Password).width("70%")
          .onChange((v:string)=>{
            this.form.AccountSecret = v
          })
      }
      .padding({left:10,right:10,top:10})
      .width("100%")
      Row(){
        Text("确定").fontColor(Color.Blue).fontSize(20).padding({left:60})
          .onClick(() => {
            this.form.Timestamp = Math.floor(systemDateTime.getTime()/1000)
            this.form.Token = CryptoJS.MD5("87339549"+ this.form.AccountSecret+this.form.Timestamp).toString()
            if(this.form.AccountId == '' || this.form.AccountSecret == ''){
              AlertDialog.show({
                title: '温馨提示',
                message: '用户名或密码不能为空'
              })
              return
            }

            //请求接口
            const httpReq = http.createHttp()
            const serve = httpReq.request('http://data.dj.whjiace.net:80/api/ticket',{
              method: http.RequestMethod.POST,
              header: {
                "Content-Type": "application/json"
              },
              extraData: this.form
            })
            serve.then(res=>{
              console.log(JSON.stringify(res))
              console.log("123124",this.server[0].regionName+this.server[0].serverIp+this.server[0].dtuPort)
              new TitleBar().savaTask(this.server[0].regionName,this.server[0].serverIp,this.server[0].dtuPort)
            })
            this.controller.close()
          })
        Text("取消").fontColor(Color.Blue).fontSize(20).padding({left:150})
          .onClick(() => {
            this.controller.close()
          })
      }
      .padding({top:20})
      .width("100%")
    }
    .width("100%")
    .height("30%")
  }
}