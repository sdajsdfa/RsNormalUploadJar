import { window } from '@kit.ArkUI'

@Entry
@Component
struct Index {

  @State currentIndex: number = 0

  //自定义构造器
  @Builder buildTabBar(index:number,title:string){
    Column(){
      if(0 == index){
        Image(0 === this.currentIndex?$r('app.media.rectangle_on_rectangle_fill'):$r('app.media.rectangle_on_rectangle'))
          .width(28)
        Text(title)
          .fontSize(12).fontColor(0 === this.currentIndex ? "#1698CE" : "#555")
      }else if(1 == index){
        Image(1 === this.currentIndex?$r('app.media.arrow_right_folder_fill'): $r('app.media.arrow_right_folder_circle'))
          .width(28)
        Text(title)
          .fontSize(12).fontColor(1 === this.currentIndex ? "#1698CE" : "#555")
      }else if(2 == index){
        Image(2 === this.currentIndex? $r('app.media.gearshape_bule'): $r('app.media.gearshape'))
          .width(28)
        Text(title)
          .fontSize(12).fontColor(2 === this.currentIndex ? "#1698CE" : "#555")
      }
    }
    .border({width:{top:1},color:'#555'})
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear(): void {
    window.getLastWindow(getContext()).then(win=>{
      win.setWindowLayoutFullScreen(true)  // 开启了当前页面的沉浸式模式（开启全屏模式）
    })
  }

  build() {
    Column() {
      // 头部
      Row() {
        Text('岩海传输助手').fontSize(12).fontColor('#FFFFFF')
      }
      .padding({ left: 10, right: 10 , top:30})
      .width('100%')
      .height(60)
      .backgroundColor('#5b73de')
      // 底部Tab导航区
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Column() {
            Text("0")
          }
        }.tabBar(this.buildTabBar(0, "传输"))

        TabContent() {
          Column() {
            Text("1")
          }
        }.tabBar(this.buildTabBar(1, "文件"))
        TabContent() {
          Column() {
            List(){
              ListItem(){
                Text("服务器配置")
              }
              ListItem(){
                Text("传输日志")
              }
              ListItem(){
                Text("工程列表")
              }
              ListItem(){
                Text("接口设置")
              }
              ListItem(){
                Text("延迟上传")
              }
              ListItem(){
                Text("自动上传")
              }
            }
          }
          .width("100%")
          .height("100%")
        }.tabBar(this.buildTabBar(2, "设置"))
      }
      .padding({bottom:60})
      .barHeight(60)
      .onChange(index => {
        this.currentIndex = index;
        console.log('currentIndex', this.currentIndex)
      })
    }
    .width("100%")
    .height('100%')
  }
}