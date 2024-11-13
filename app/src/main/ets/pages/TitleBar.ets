
import router from '@ohos.router'
import { relationalStore } from '@kit.ArkData'
import { common } from '@kit.AbilityKit'

@Entry
@Component
export struct TitleBar {
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
          .margin(125)
          .onClick(async ()=>{
            const context = getContext() as common.UIAbilityContext
            const STORE_CONFIG :relationalStore.StoreConfig= {
              name: 'MyApplication.db', // 数据库文件名
              securityLevel: relationalStore.SecurityLevel.S3, // 数据库安全级别
              encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
              //customDir: 'customDir/subCustomDir', // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，'/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
              //isReadOnly: false // 可选参数，指定数据库是否以只读方式打开。该参数默认为false，表示数据库可读可写。该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
            };
            relationalStore.getRdbStore(context, STORE_CONFIG, (err,store) =>{
              if(err){
                console.log('数据初始化失败')
                return
              }
              console.log('数据库连接成功')
            })

            // let db=await relationalStore.getRdbStore(getContext(), {
            //   name: 'MyApplication.db',//数据库文件名
            //   securityLevel: relationalStore.SecurityLevel.S1
            // })
            // console.log("123",db.version)
            // if(db.version===0)//判断数据库是否为初始化数据库
            // {
            //   /*注意INT类型是不能自增的,TEXT普通边长文本,*/
            //   let sql="CREATE TABLE biao_1(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)"
            //   db.executeSql(sql)
            //   db.version=1
            // }else if(db.version===1)
            // {
            //   console.log("没有创建表")
            // }
            // let fid=db.insertSync('biao_1',{//写入成功后会返回写入id
            //   id:1,
            //   name:"老王"
            // })
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