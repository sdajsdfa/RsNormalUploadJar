// 定义自定义弹框
@CustomDialog
export struct CustomDialogExample {
  //@State isChecked1: boolean = true; // 第一个Toggle的初始状态
  //@State isChecked2: boolean = false; // 第二个Toggle的初始状态

  controll: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({})
  })

  build() {
    Column(){
      Row(){
        Text('仪器连接')
          .fontSize(20)
          .padding(20)
          .fontColor('#FFFFFF')
      }
      .width("100%")
      .height(60)
      .backgroundColor('#5b73de')
      .justifyContent(FlexAlign.Center)

      Row(){
        Text('模式：')
        Radio({ value: 'Radio2', group: 'radioGroup' })
          .checked(true)
        // Toggle({ type: ToggleType.Checkbox, isOn: this.isChecked1 })
        Text('蓝牙').fontColor(Color.Blue)
          .padding({ right: 30 })

       // Toggle({type: ToggleType.Checkbox, isOn: this.isChecked2})
        Radio({ value: 'Radio1', group: 'radioGroup' })
          .checked(false)
        Text('WiFi').fontColor(Color.Blue)
          .padding({ right: 30 })
        Button("搜索").type(ButtonType.Normal).borderRadius(10)
          .width(60)
          .height(30)
      }
      .width("100%")
      .padding({ left: 20, right: 20 ,top:20})
      Row(){
        Text('仪器列表').letterSpacing(4).fontSize(14)
      }
      .padding({ left: 20, right: 20 ,top:30})

      Row(){
        Text('取消').fontColor(Color.Blue).width("100%").textAlign(TextAlign.Center)
          .onClick(() => { this.controll.close() })
      }
      .padding({ top:390})
    }
    .width("100%")
    .height("90%")
  }
}