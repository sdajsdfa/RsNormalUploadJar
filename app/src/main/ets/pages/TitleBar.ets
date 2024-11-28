
import router from '@ohos.router'
import TaskInfo from '../viewModel/TaskInfo'
import { CustomDialogSelect } from './CustomDialogSelect'
import DbUtil from '../common/utils/DbUtil'
import ServerInfo from '../viewModel/ServerInfo'
import Data from '../viewModel/Data'
import http from '@ohos.net.http';
import { LoadingDialog } from './LoadingDialog'
import { relationalStore } from '@kit.ArkData'

@Entry
@Component
export struct TitleBar {

  // @State res: TaskInfo[] = []
  @State res: ServerInfo[] = []
  @State selectList: Array<SelectOption> = []
  @State selectServer: Array<SelectOption> = []

  // 定义一个名为 title 的 State 变量，用于存储加载对话框的标题文字
  @State title: string = ''

  // 定义一个名为 isShowLoading 的 State 变量，用于控制 LoadingDialog 是否显示
  @State isShowLoading: boolean = false

  @State textInputValue:string = '安徽地质实验研究所'
  @State serverIp:string = 'http://36.7.120.50/'
  @State dtuPort:string = '5002'

  savaTask(value:string,serverIp:string,dtuPort:string){
    this.serverIp = serverIp
    this.dtuPort = dtuPort
    this.textInputValue = value
    console.log("00000",this.textInputValue)
  }

  //自定义弹框
  dialog: CustomDialogController = new CustomDialogController({
    builder: CustomDialogSelect({
      // taskInfo : this.res,
      serverInfo : this.res,
      selectList : this.selectList,
      selectServer : this.selectServer,
       text : this.res[0].province,
      textServer :  this.res[0].regionName,
      onClickOk:(value:string,serverIp:string,dtuPort:string):void=>this.savaTask(value, serverIp, dtuPort)
    }),
    //设置弹框显示方向：在底部，默认居中显示
    alignment: DialogAlignment.Center,
    //点击外部不取消
    autoCancel: true,
  })

  //private title: string = ''

  build() {
    Column() {
      Row() {
        Image($r('app.media.arrow_left'))
          .id('back')
          .size({ width: 20, height: '100%' })
          .objectFit(ImageFit.Contain)
          .margin({ left: 10,top:10})
          .fillColor('#FFFFFF')
          .onClick(() => {
            router.back()
          })
        Text("服务器配置").fontColor('#FFFFFF').margin({ left: 113 ,top:10})

        Image($r('app.media.arrow_clockwise'))
          .id('back')
          .size({ width: 20, height: '100%' })
          .objectFit(ImageFit.Contain)
          .margin({ left: 110 ,top:10})
          .fillColor('#FFFFFF')
          .onClick(() => {
            let httpRequest = http.createHttp();
            httpRequest.request(
              'http://192.168.10.111:8081/serverlist/queryAllServerlist',
              {
                method:http.RequestMethod.GET,
                header: { 'Content-Type': 'application/json; charset=utf-8' }
              }
            )
              .then(resp=>{
                //console.log("resp=>",JSON.stringify(resp))
                if(resp.responseCode === 200){
                  this.isShowLoading = true
                  this.title = '正在更新服务器信息，请稍等'
                  let predicates = new relationalStore.RdbPredicates('server')
                  DbUtil.delete(predicates)
                  DbUtil.batchInsert('server',JSON.parse(resp.result.toString()))
                  //console.log(JSON.stringify(resp.result.toString()))
                  //this.isShowLoading = false
                  setTimeout(() => {
                    this.isShowLoading = false
                  },3000)
                }
              }).catch(()=>{
                console.log('请求错误err=>',"123")
              })

          })
      }
      .padding({ left: 10, right: 10 , top:20})
      .width('100%')
      .height(60)
      .backgroundColor('#5b73de')

      Column() {
        Row() {
          Text("主服务器").fontColor('#FFFFFF')
          Text("向该服务器上传数据").fontSize(12).fontColor('#FFFFFF').margin({left:10})
        }
        .height(30)
        .width("100%")
        .borderRadius( {
          topRight:15, //右上圆角值为15
          topLeft:15 //左上圆角值为15
        })
        .backgroundColor('#5b73de')
        .padding({left:10})
        Column(){
          Text(this.textInputValue).fontSize(20)
          Text(this.serverIp+":"+this.dtuPort).fontSize(12).padding({top:10})
        }
        .width("100%")
        .height(90)
        .padding({top:40})
        .justifyContent(FlexAlign.Center)
        Button("选择").type(ButtonType.Normal).borderRadius(10).backgroundColor('#5b73de')
          .width(80)
          .height(30)
          .margin(50)
          .onClick(()=>{
            // DbUtil.batchInsert('server',)
            let hashSet = new Array<string>();
            this.res = DbUtil.getTaskList()
            for(let i = 0; i<this.res.length;i++){
              if(this.res[0].province==this.res[i].province){
                this.selectServer.push(new Data(this.res[i].regionName))
              }
              hashSet.push(this.res[i].province)
            }
            hashSet = Array.from(new Set(hashSet))
            for(let i = 0; i<hashSet.length;i++){
              this.selectList.push(new Data(hashSet[i]))
            }
            this.dialog.open();
          })
      }
      .width("95%")
      .height("25%")
      .borderWidth(1)
      .border({width:{bottom:1},color:'#335291FF'})
      .borderRadius(16)
      .margin(10)

      // 实例化 LoadingDialog 组件，传递当前的 title 状态作为标题文字
      // 根据 isShowLoading 状态控制其可见性
      LoadingDialog({ title: this.title })
        .visibility(this.isShowLoading ? Visibility.Visible : Visibility.None)
    }
    .width("100%")
    .height("100%")
  }


}