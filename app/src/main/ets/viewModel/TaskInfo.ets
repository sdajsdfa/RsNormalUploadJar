export default class TaskInfo {
  id: number
  name: string
  finished: boolean

  constructor(id: number, name: string, finished: boolean = false) {
    this.id = id
    this.name = name
    this.finished = finished
  }
}