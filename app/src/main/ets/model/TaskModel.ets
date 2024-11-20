import relationalStore from '@ohos.data.relationalStore';
import { common } from '@kit.AbilityKit';
import TaskInfo from 'ets/viewModel/TaskInfo';
import fs from '@ohos.file.fs'
import { BusinessError, request, zlib } from '@kit.BasicServicesKit';
import Logger from '../common/utils/Logger';

class TaskModel {
  private rdbStore: relationalStore.RdbStore | undefined
  private tableName: string = 'TASK'

  /**
   * 初始化任务表
   */
  initTaskDB(context: common.UIAbilityContext) {
    // 1. rdb配置
    const config: relationalStore.StoreConfig = {
      name: 'RdbTest.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    // 2. 初始化sql语句
    const sql = `CREATE TABLE IF NOT EXISTS TASK(
                   ID INTEGER PRIMARY KEY AUTOINCREMENT,
                   NAME TEXT NOT NULL,
                   FINISHED bit)`
    // 3. 获取rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore: relationalStore.RdbStore) => {
      if (err) {
        console.log('testTag', '获取rdbStore失败')
        return
      }
        rdbStore.executeSql(sql)
        this.rdbStore = rdbStore
        console.error("testTag","数据库初始化成功")
    })
  }

  /**
   * 查询任务数据
   */
  getTaskList(): Array<TaskInfo> {
    let tasks: TaskInfo[] = []
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    /*构建查询条件*/
    // predicates.equalTo('id','1')
    /*查询数据*/
    if (this.rdbStore !== undefined) {
      let result = this.rdbStore.querySync(predicates, ['ID', 'NAME', 'FINISHED'])
      while (!result.isAtLastRow) { /*循环结果集*/
        result.goToNextRow()
        let id = result.getLong(result.getColumnIndex('ID'))
        let name = result.getString(result.getColumnIndex('NAME'))
        let finished = result.getLong(result.getColumnIndex('FINISHED'))
        let task = new TaskInfo(id, name, !!finished)
        tasks.push(task)
      }
    }
    return tasks;
  }

  /**
   * 添加任务
   */
  addTask(name: string) {
    return this.rdbStore?.insert(this.tableName, { name, finished: false })
  }

  /**
   * 更新任务状态
   */
  updateTaskStatus(id: number, finished: boolean) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    return this.rdbStore?.update({ finished }, predicates)
  }

  /**
   * 删除任务
   */
  delTaskById(id: number) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    return this.rdbStore?.delete(predicates)
  }
}

let taskModel = new TaskModel()

export default taskModel as TaskModel