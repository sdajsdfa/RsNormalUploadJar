// 定义一个名为 LoadingDialog 的自定义组件，用于显示加载对话框
@Component
export struct LoadingDialog {
  // 定义一个名为 title 的 Prop 属性，用于传递显示在对话框中的标题文字
  @Prop title: string

  // 组件构建方法，负责生成 LoadingDialog 的 UI 结构
  build() {
    // 使用 Stack 布局容器包裹内部元素，便于堆叠和定位
    Stack() {
      // 使用 Column 布局容器垂直排列内部元素
      Column() {
        // 添加一个 LoadingProgress 组件，作为加载动画，设置颜色、宽高
        LoadingProgress()
          .color(Color.White).width(100).height(100)

        // 添加一个 Text 组件，显示标题文字，设置字体大小、颜色、顶部外边距
        // 根据传入的 title 属性值决定其可见性
        Text(this.title)
          .fontSize(18).fontColor(0xffffff).margin({ top: 8 })
          .visibility(this.title ? Visibility.Visible : Visibility.None)
      }
    }
    // 设置 LoadingDialog 组件的整体宽度和高度
    .width("90%")
    .height(180)

    // 设置对话框的背景色为半透明深灰色
    .backgroundColor(0x88000000)

    // 设置对话框的圆角边框，增强视觉效果
    .borderRadius(10)

    // 添加阴影效果，增加立体感
    .shadow({
      radius: 10,
      color: Color.Gray,
      offsetX: 3, // 水平偏移量
      offsetY: 3 // 垂直偏移量
    })
  }
}
