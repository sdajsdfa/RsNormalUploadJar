import TaskInfo from "../viewModel/TaskInfo"
import ServerInfo from "../viewModel/ServerInfo"
import DbUtil from "../common/utils/DbUtil";
import Data from '../viewModel/Data'
import { relationalStore } from "@kit.ArkData";
import { CustomDialogLogin } from "./CustomDialogLogin";
import socket from '@ohos.net.socket';

// 定义自定义弹框

@CustomDialog
export struct CustomDialogSelect {
  //@State isChecked1: boolean = true; // 第一个Toggle的初始状态
  //@State isChecked2: boolean = false; // 第二个Toggle的初始状态
  //@State taskInfo: TaskInfo[] = [];
  @State serverInfo: ServerInfo[] = [];

  // 地区列表
  @State selectList: Array<SelectOption> = []
  // 服务器列表
  @State selectServer: Array<SelectOption> = []

  @State server: ServerInfo[] = []


  @State text: string = ""
  @State index: number = 0
  @State space: number = 8

  @State indexServer: number = 0
  @State textServer: string = ""
  @State arrowPosition: ArrowPosition = ArrowPosition.END

  customDialogLogin: CustomDialogController = new CustomDialogController({
    builder: CustomDialogLogin({
      server: this.server
    }),
    //设置弹框显示方向：在底部，默认居中显示
    alignment: DialogAlignment.Center,
    //点击外部不取消
    autoCancel: true,
  });

  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialogSelect({}),
  })

  onClickOk :(value:string,serverIp:string,dtuPort:string)=>void = ()=>{}

  build() {
    Column(){
      Row(){
        Text('选择服务器')
          .padding({left:20,right:210})
          .fontColor('#FFFFFF')
        Image($r('app.media.magnifyingglass')).width(20)
      }
      .width("100%")
      .height(50)
      .backgroundColor('#5b73de')
      Row(){
        Text("地   区").padding({left:20,right:20})
        Select(this.selectList)
          .selected(this.index)
          .value(this.text)
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .space(this.space)
          .arrowPosition(this.arrowPosition)
          .menuAlign(MenuAlignType.START, {dx:0, dy:0})
          .optionWidth(350)
          .optionHeight(300)
          .onSelect((index:number, text?: string | undefined)=>{
            console.info('Select:' + index)
            this.index = index;
            if(text){
              this.text = text;
            }
            this.selectServer = []
            this.serverInfo = DbUtil.getTaskList1(this.text)
            for(let i = 0; i<this.serverInfo.length;i++){
              this.selectServer.push(new Data(this.serverInfo[i].regionName))
            }
            this.textServer = this.serverInfo[0].regionName
          })
          .width("70%")
          .backgroundColor("#FFFFFF")
      }
      .padding({left:10,right:10,top:10})
      .width("100%")
      Row(){
        Text("服务器").padding({left:20,right:20})
        Select(this.selectServer)
          .selected(this.indexServer)
          .value(this.textServer)
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .space(this.space)
          .arrowPosition(this.arrowPosition)
          .menuAlign(MenuAlignType.START, {dx:0, dy:0})
          .optionWidth(350)
          .optionHeight(300)
          .onSelect((indexServer:number, textServer?: string | undefined)=>{
            console.info('Select:' + indexServer)
            this.indexServer = indexServer;
            if(textServer){
              this.textServer = textServer;
            }
          })
          .width("70%")
          .backgroundColor("#FFFFFF")
      }
      .padding({left:10,right:10,top:10})
      .width("100%")
      Row(){
        Text("确定").fontColor(Color.Blue).fontSize(20).padding({left:60})
          .onClick(() => {
            // console.log("",this.textServer)
            this.server =DbUtil.getTaskList2(this.textServer)

            this.controller.close()
            if(this.server[0].transferFlag==3){
              this.customDialogLogin.open();
            } else {
              let udp = socket.constructUDPSocketInstance();
              udp.bind({address: "0.0.0.0", port: Number(this.server[0].dtuPort), family: 1}).then(() => {
                console.log('bind success');
              }).catch(() => {
                console.log('bind fail');
              });
              //收到消息时的处理
              udp.on("message", async (value) => {
                console.log("12312",value)
                // let msg = buf2String(value.message)
                // let remoteIP = value.remoteInfo.address
                // let remotePort = value.remoteInfo.port.toString()
                // //对端ip地址和端口的字符串形式
                // let remoteAddr = "[" + remoteIP + ":" + remotePort + "]:"
                // let time = await getCurrentTimeString()
                // this.msgHistory += remoteAddr + msg + time + "\r\n"
                // this.scroller.scrollEdge(Edge.Bottom)
              })

              udp.send({data: 'Hello, server!', address: {address: this.server[0].serverIp, port: Number(this.server[0].dtuPort), family: 1}}).then(() => {
                console.log('send success');
              }).catch(() => {
                console.log('send fail');
              });

              this.onClickOk(this.server[0].regionName,this.server[0].serverIp,this.server[0].dtuPort)
            }
          })
        Text("取消").fontColor(Color.Blue).fontSize(20).padding({left:150})
          .onClick(() => { this.controller.close() })
      }
      .padding({top:20})
      .width("100%")
    }
    .width("100%")
    .height("30%")
  }
}
