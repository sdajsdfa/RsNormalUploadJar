import { relationalStore } from "@kit.ArkData";

export default class CommonConstants {
  /**
   * 日志TAG
   */
  // APP日志TAG
  static readonly LOGGER_PREFIX: string = "Framework";

  // 数据库操作日志TAG
  static readonly RDB_PREFIX: string = "[RdbTag]";

  /**
   * 数据库配置
   */
  static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name: "Framework.db",
    securityLevel: relationalStore.SecurityLevel.S1
  };
}