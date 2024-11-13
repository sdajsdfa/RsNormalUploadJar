import { promptAction, window } from '@kit.ArkUI'
import router from '@ohos.router'
import { CustomDialogExample } from './CustomDialogExample'
@Entry
@Component
struct Index {

  @State currentIndex: number = 0

  //自定义构造器
  @Builder buildTabBar(index:number){
    Column(){
      if(0 == index){
        Image(0 === this.currentIndex?$r('app.media.home_left_down'):$r('app.media.home_left_normal'))
          .width(50)
      }else if(1 == index){
        Image(1 === this.currentIndex?$r('app.media.home_mid_down'): $r('app.media.home_mid_normal'))
          .width(50)
      }else if(2 == index){
        Image(2 === this.currentIndex? $r('app.media.home_right_down'): $r('app.media.home_right_normal'))
          .width(50)
      }
    }
    .border({width:{top:1},color:'#335291FF'})
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear(): void {
    window.getLastWindow(getContext()).then(win=>{
      win.setWindowLayoutFullScreen(true)  // 开启了当前页面的沉浸式模式（开启全屏模式）
    })
  }

  //
  dialog: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample()
  })

  build() {
    Column() {
      // 头部
      Row() {
        Text('岩海传输助手').fontSize(14).fontColor('#FFFFFF')
      }
      .padding({ left: 10, right: 10 , top:30})
      .width('100%')
      .height(60)
      .backgroundColor('#5b73de')
      // 底部Tab导航区
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Column() {
            Button("未连接")
              .fontColor(Color.Blue)
              .fontSize(20)
              .width("80%")
              .height(60)
              .borderWidth(1)
              .backgroundColor("#FFFFFF")
              //.borderRadius(50)
              //.textAlign(TextAlign.Center)
              .onClick(() => {
                this.dialog.open();
                // AlertDialog.show({
                //   title:"弹窗标题",
                //   message:"这是弹窗内容",
                //   autoCancel:false,//点击遮障层时，是否关闭弹窗。默认值：true
                //   alignment: DialogAlignment.Center,//弹窗在竖直方向上的对齐方式。默认值：DialogAlignment.Default
                //   primaryButton: {
                //     value: "取消",
                //     fontColor: '#181818',
                //     action: () => {
                //       promptAction.showToast({message: '取消'});
                //     }
                //   },
                //   cornerRadius:12,//弹窗边框弧度
                //   width:'80%', //弹窗宽度
                //   cancel:()=>{
                //     promptAction.showToast({message: "点击遮障层关闭dialog时的回调"});
                //   }
                // })
              })
          }
          .padding({top:50})
          .width("100%")
          .height("100%")
        }.tabBar(this.buildTabBar(0))

        TabContent() {
          Column() {
            Text("1")
          }
        }.tabBar(this.buildTabBar(1))
        TabContent() {
          Column() {
            List(){
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_server')).width(20)
                  Text("服务器配置")
                    .fontSize(14)
                    .padding({ left: 10})
                  Image($r('app.media.chevron_right')).width(10).margin({ left: 232,right:10})
                }
                .padding({ left: 10, right: 10 })
                .width("100%")
                .height(40)
                .border({ width: { bottom: 1 }, color: '#335291FF' })
              }
              .onClick(() => {
                  router.pushUrl({
                    url: 'pages/TitleBar',
                    params: { title: "服务器配置" }
                     })
              })
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_log')).width(20)
                  Text("传输日志")
                    .fontSize(14)
                    .padding({ left: 10})
                  Image($r('app.media.chevron_right')).width(10).margin({ left: 245 })
                }
                .padding({ left: 10,right:10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_log')).width(20)
                  Text("工程列表")
                    .fontSize(14)
                    .padding({ left: 10})
                  Image($r('app.media.chevron_right')).width(10).margin({ left: 245 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_other')).width(20)
                  Text("接口设置")
                    .fontSize(14)
                    .padding({ left: 10})
                  Image($r('app.media.chevron_right')).width(10).margin({ left: 245 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_delay')).width(20)
                  Text("延迟上传")
                    .fontSize(14)
                    .padding({ left: 10})
                  Text("关闭")
                    .fontSize(10)
                    .margin({ left: 240 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_auto_upload')).width(20)
                  Text("自动上传")
                    .fontSize(14)
                    .padding({ left: 10})
                  Toggle({type: ToggleType.Switch, isOn: false}).margin({ left: 225 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_switch')).width(20)
                  Text("切换版本")
                    .fontSize(14)
                    .padding({ left: 10})
                  Row() {
                    Text("标准版").fontSize(10).margin(10)
                    Image($r('app.media.chevron_right')) .width(10)
                  }
                  .margin({ left: 195})

                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_use')).width(20)
                  Text("使用说明")
                    .fontSize(14)
                    .padding({ left: 10})
                  Image($r('app.media.chevron_right')).width(10).margin({ left: 245 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_clear')).width(20)
                  Text("清除缓存")
                    .fontSize(14)
                    .padding({ left: 10})
                  Text("清除后数据不可恢复").fontSize(10).margin({ left: 168 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_version')).width(20)
                  Text("版本检查")
                    .fontSize(14)
                    .padding({ left: 10})
                  Image($r('app.media.chevron_right')).width(10).margin({ left: 245 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
              ListItem(){
                Row() {
                  Image($r('app.media.home_right_exit')).width(20)
                  Text("退出程序")
                    .fontSize(14)
                    .padding({ left: 10})
                  Image($r('app.media.chevron_right')).width(10).margin({ left: 245 })
                }
                .padding({ left: 10})
                .width("100%")
                .height(40)
                .border({width:{bottom:1},color:'#335291FF'})
              }
            }
          }
          .width("100%")
          .height("100%")
        }.tabBar(this.buildTabBar(2))
      }
      .padding({bottom:60})
      .barHeight(60)
      .onChange(index => {
        this.currentIndex = index;
        //console.log('currentIndex', this.currentIndex)
      })
    }
    .width("100%")
    .height('100%')
  }
}