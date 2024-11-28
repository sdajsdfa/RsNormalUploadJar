/**
 * 服务器对象
 * <p/>
 * 从岩海平台获取的TransFlag
 * 0 岩海UDP
 * 1 新华通
 * 2 上海检测协会
 * 3 岩海API
 * 4 徐州模式
 * 5 广东省建科院原始文件
 * 6 合肥质监站
 * 7 蚌埠质监站
 * 8 安九线
 * 9 郑万高铁河南段
 * 10 武汉铁辰实时上传平台
 */
export default class ServerInfo {
  /**
   * 服务器类型#####
   */
  /**
   * 岩海模式 UDP
   */
  static readonly SERVER_TYPE_RS = 0;

  /**
   * 郑万线-中岩
   */
  static readonly SERVER_TYPE_RSM = 1;
  /**
   * 建科院原始文件-账号密码rocksea
   */
  static readonly SERVER_TYPE_JKY_ORIGIN = 2;
  /**
   * 新华通-账号密码YH001
   */
  static readonly SERVER_TYPE_JKY_XHT = 3;
  /**
   * 郑万线湖北段-无账号密码
   */
  static readonly SERVER_TYPE_ZW_HB = 4;

  /**
   * 中岩宁波-弃用
   */
  static readonly SERVER_TYPE_RSM_NB = 5;
  /**
   * 中岩武汉铁辰--铁四院-仅支持低应变
   */
  static readonly SERVER_TYPE_RSM_TC = 6;
  /**
   * 中岩-西安大学-账号密码whrsm-仅支持低应变
   */
  static readonly SERVER_TYPE_RSM_XA = 7;

  /**
   * 岩海模式 API
   */
  static readonly SERVER_TYPE_RS_API = 8;

  /**
   * 三和模式 webservice 通用接口
   */
  static readonly SERVER_TYPE_SH = 9;

  /**
   * W
   * 洛阳模式 webservice
   */
  static readonly SERVER_TYPE_LY = 10;


  /**
   * 佛山市站
   */
  static readonly  SERVER_TYPE_FOSHAN = 11;

  /**
   * 贵金古高速
   */
  static readonly  SERVER_TYPE_GJG = 12;
  /**
   * 南通交通 江苏中桥模式
   */
  static readonly  SERVER_TYPE_NTJT = 13;

  /**
   * 浙江公路水运云实况（新视窗）
   */
  static readonly  SERVER_TYPE_ZJGLSY = 14;
  /**
   * 三和岩海：太原、潍坊
   */
  static readonly  SERVER_TYPE_SH_RS = 15;

  /**
   * 广州新接口 中软
   */
  static readonly  SERVER_TYPE_GZ_ZR = 16;
  /**
   * 四川鹏业
   */
  static readonly  SERVER_TYPE_SC_PY = 17;

  /**
   * 南宁勘测院平台（沉孔沉渣--中岩平台）
   */
  static readonly  SERVER_TYPE_NNKCY_CKCZ = 18;

  /**
   * 中岩webAPI接口（北京电科院）
   */
  static readonly  SERVER_TYPE_RSM_API = 19;


  /**
   * 武汉中南安全
   */
  static readonly  SERVER_TYPE_ZNAQ = 20;

  /**
   * 厦门交通监管平台（海迈科技）
   */
  static readonly  SERVER_TYPE_XM_HM = 21;

  /**
   * 湖州（智博联）
   */
  static readonly  SERVER_TYPE_HZ_ZBL = 22;

  /**
   * 江门智慧工地(腾晖科技)
   */
  static readonly  SERVER_TYPE_JM_TH = 23;

  /**
   * 315国道信息化平台
   */
  static readonly  SERVER_TYPE_315_ROAD = 24;

  /**
   * 湖南建研 PKPM
   * 实际是用的岩海API 不过请求的路径不一样
   */
  static readonly  SERVER_TYPE_PKPM = 25;

  /**
   * 上海市政公路 （智博联）
   */
  static readonly  SERVER_TYPE_ZBL_SZGL = 26;

  /**
   * 深圳智慧住建
   */
  static readonly  SERVER_TYPE_SHENZHEN_ZHIHUI_ZHUJIAN = 27;


  /**
   * 未知服务器类型
   */
  static readonly  SERVER_TYPE_UNKONWN = -1;

  /**
   * 宁波地基 http
   */
  static readonly  SERVER_TYPE_NINGBO_DIJI = -2;

  /**
   * 杭绍甬桩 http
   */
  static readonly  SERVER_TYPE_HANGSHAO_YONGZHUANG = -3;

  /**
   * 东莞水务 http
   */
  static readonly SERVER_TYPE_SANHE_DONGGUAN_SHUIWU = -4;

  /**
   * 上海拓东 http
   */
  static readonly SERVER_TYPE_SHANGHAI_TUODONG = -5;
  /**
   * 岩海松捷 http
   */
  static readonly SERVER_TYPE_YANHAI_SONGJIE = -6;

  /**
   * 顺德顺融 三和接口 改造自东莞水务
   */
  static readonly  SERVER_TYPE_SANHE_SHUNDE_SHUNRONG = -7;

  /**
   * 苍泰高速
   */
  static readonly SERVER_TYPE_CANG_TAI_GAO_SU = -8;

  /**
   * 服务器类型 默认为岩海
   */
  serverType = ServerInfo.SERVER_TYPE_RS;


  id: number
  serverIp: string
  dtuPort: string
  regionName: string
  webIp: string
  webPort: string
  flag: number
  webFlag: number
  province: string
  transferFlag: number
  city: string
  proxyType: string
  mark: number
  constructor(id: number, serverIp: string, dtuPort: string, regionName: string, webIp: string, webPort: string, flag: number, webFlag: number, province: string, transferFlag: number, city: string, proxyType: string, mark: number) {
    this.id = id
    this.serverIp = serverIp
    this.dtuPort = dtuPort
    this.regionName = regionName
    this.webIp = webIp
    this.webPort = webPort
    this.flag = flag
    this.webFlag = webFlag
    this.province = province
    this.transferFlag = transferFlag
    this.city = city
    this.proxyType = proxyType
    this.mark = mark
  }

  getRegionNameWithModeForDebug(): string  {
    return this.regionName + "@" + this.getDebugServerTypeName();
  }

  getDebugServerTypeName() : string {
    switch (this.serverType) {
      case ServerInfo.SERVER_TYPE_RS:
        //岩海UDP模式
        return "[岩海UDP]";
      case ServerInfo.SERVER_TYPE_RS_API:
        //岩海API模式
        return "[岩海API]";
      case ServerInfo.SERVER_TYPE_PKPM:
        //PKPM 岩海API模式
        return "[PKPM(岩海API改)]";
      case ServerInfo.SERVER_TYPE_YANHAI_SONGJIE:
        //岩海松捷
        return "[岩海松捷]";
      case ServerInfo.SERVER_TYPE_RSM_XA:
        //与 SERVER_TYPE_RSM 一致
        return "[西安大学(RSM)]";
    //这里不能加break；
      case ServerInfo.SERVER_TYPE_RSM:
        //郑万线
        return "[郑万线(RSM)]";
      case ServerInfo.SERVER_TYPE_JKY_ORIGIN:
        //广东省建科院原始文件
        return "[广东省建科院原始文件]";
      case ServerInfo.SERVER_TYPE_JKY_XHT:
        //新华通模式
        return "[新华通]";
      case ServerInfo.SERVER_TYPE_ZW_HB:
        //郑万线湖北段
        return "[郑万湖北段(RSM)]";

      case ServerInfo.SERVER_TYPE_RSM_TC:
        //武汉铁辰实时上传平台--铁四院
        return "[武汉铁辰-铁四院]";
      case ServerInfo.SERVER_TYPE_SH:
        //三和
        return "[三和WebService]";
      case ServerInfo.SERVER_TYPE_NINGBO_DIJI:
        //宁波地基--从以前的APP整合到这里了
        return "[宁波地基]";
      case ServerInfo.SERVER_TYPE_LY:
        //洛阳接口
        return "[洛阳接口]";
      case ServerInfo.SERVER_TYPE_FOSHAN:
        //佛山质监站（三和定制版-API接口）
        return "[三和特制版接口]";
      case ServerInfo.SERVER_TYPE_HANGSHAO_YONGZHUANG:
        //杭绍甬桩
        return "[杭绍甬桩]";
      case ServerInfo.SERVER_TYPE_GJG:
        //贵金古高速
        return "[贵金古高速]";
      case ServerInfo.SERVER_TYPE_NTJT:
        //南通交通  江苏中桥模式
        return "[南通交通(江苏中桥)]";
      case ServerInfo.SERVER_TYPE_ZJGLSY:
        //浙江公路水运云实况（新视窗）
        return "[浙江公路水运(新视窗)]";
      case ServerInfo.SERVER_TYPE_SANHE_DONGGUAN_SHUIWU:
        //东莞水务
        return "[东莞水务(三和)]";
      case ServerInfo.SERVER_TYPE_SH_RS:
        //三和岩海模式：太原、潍坊
        return "[三和模式(岩海API改)]";
      case ServerInfo.SERVER_TYPE_GZ_ZR:
        //广州中软
        return "[广东中软]";
      case ServerInfo.SERVER_TYPE_SC_PY:
        //四川鹏业
        return "[四川鹏业]";
      case ServerInfo.SERVER_TYPE_NNKCY_CKCZ:
        //南宁勘测院 沉孔沉渣 中岩平台
        return "[南宁勘测院(成孔)(RSM)]";
      case ServerInfo.SERVER_TYPE_RSM_API:
        //北京国电--中岩API
        return "[RSM-API]";
      case ServerInfo.SERVER_TYPE_ZNAQ:
        //中南安全
        return "[中南安全(RSM)]";
      case ServerInfo.SERVER_TYPE_XM_HM:
        //厦门海迈--交通监管
        return "[厦门交通监管(海迈科技)]";
      case ServerInfo.SERVER_TYPE_HZ_ZBL:
        //湖州-智博联
        return "[湖州(智博联)]";
      case ServerInfo.SERVER_TYPE_315_ROAD:
        //315国道
        return "[315国道]";
      case ServerInfo.SERVER_TYPE_JM_TH:
        //江门智慧工地（腾晖科技）
        return "[江门智慧工地(腾晖科技)]";
      case ServerInfo.SERVER_TYPE_SHANGHAI_TUODONG:
        //上海拓东（由岩海API模式改编而成）
        return "[上海拓东(岩海API改)]";
      case ServerInfo.SERVER_TYPE_ZBL_SZGL:
        //上海拓东（由岩海API模式改编而成）
        return "[上海市政公路(ZBL)]";
      case ServerInfo.SERVER_TYPE_SHENZHEN_ZHIHUI_ZHUJIAN:
        //深圳检测中心
        return "[PKPM-深圳智慧住建]";
      case ServerInfo.SERVER_TYPE_SANHE_SHUNDE_SHUNRONG:
        //顺德顺融
        return "[三和-顺德顺融(改自东莞水务)]";
      case ServerInfo.SERVER_TYPE_CANG_TAI_GAO_SU:
        //苍泰高速
        return "[苍泰高速-RSM(改自洛阳接口)]";
      default:
        return "[未知接口]";
    }
  }
}