import TaskInfo from "../viewModel/TaskInfo"
import ServerInfo from "../viewModel/ServerInfo"
import DbUtil from "../common/utils/DbUtil";
import Data from '../viewModel/Data'
import { relationalStore } from "@kit.ArkData";

// 定义自定义弹框
@CustomDialog
export struct CustomDialogExample {
  //@State isChecked1: boolean = true; // 第一个Toggle的初始状态
  //@State isChecked2: boolean = false; // 第二个Toggle的初始状态
  //@State taskInfo: TaskInfo[] = [];

  @State serverInfo: ServerInfo[] = [];

  // 地区列表
  @State selectList: Array<SelectOption> = []
  // 服务器列表
  @State selectServer: Array<SelectOption> = []


  @State text: string = ""
  @State index: number = 0
  @State space: number = 8

  @State indexServer: number = 0
  @State textServer: string = ""
  @State arrowPosition: ArrowPosition = ArrowPosition.END

  controll: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({})
  })

  onClickOk :(value:string,serverIp:string,dtuPort:string)=>void = ()=>{}

  build() {
    Column(){
      Row(){
        Text('选择服务器')
          .padding({left:20})
          .fontColor('#FFFFFF')
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
            let s =DbUtil.getTaskList2(this.textServer)
            this.onClickOk(this.textServer,s[0].serverIp,s[0].dtuPort)
            this.controll.close()
          })
        Text("取消").fontColor(Color.Blue).fontSize(20).padding({left:150})
          .onClick(() => { this.controll.close() })
      }
      .padding({top:20})
      .width("100%")
    }
    .width("100%")
    .height("30%")
  }
}
