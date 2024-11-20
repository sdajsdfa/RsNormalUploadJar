
import router from '@ohos.router'
import TaskInfo from '../viewModel/TaskInfo'
import { CustomDialogExample } from './CustomDialogSelect'
import DbUtil from '../common/utils/DbUtil'
import ServerInfo from '../viewModel/ServerInfo'
import Data from '../viewModel/Data'




@Entry
@Component
export struct TitleBar {

  // @State res: TaskInfo[] = []
  @State res: ServerInfo[] = []
  @State selectList: Array<SelectOption> = []
  @State selectServer: Array<SelectOption> = []

  //自定义弹框
  dialog: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      // taskInfo : this.res,
      serverInfo : this.res,
      selectList : this.selectList,
      selectServer : this.selectServer,
       text : this.res[0].province,
      textServer :  this.res[0].regionName
    }),
    //设置弹框显示方向：在底部，默认居中显示
    alignment: DialogAlignment.Center,
    //点击外部不取消
    autoCancel: false,
  })

  private title: string = ''

  build() {
    Column() {
      Row() {
        Image($r('app.media.arrow_left'))
          .id('back')
          .size({ width: 20, height: '100%' })
          .objectFit(ImageFit.Contain)
          .margin({ left: 10 })
          .fillColor('#FFFFFF')
          .onClick(() => {
            router.back()
          })
        Text("服务器配置").fontColor('#FFFFFF').margin({ left: 100 })

        Image($r('app.media.arrow_clockwise'))
          .id('back')
          .size({ width: 20, height: '100%' })
          .objectFit(ImageFit.Contain)
          .margin({ left: 100 })
          .fillColor('#FFFFFF')
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
        Button("选择").type(ButtonType.Normal).borderRadius(10).backgroundColor('#5b73de')
          .width(80)
          .height(30)
          .margin(140)
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
    }
    .width("100%")
    .height("100%")
  }


}