export default class TaskInfo {
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
}