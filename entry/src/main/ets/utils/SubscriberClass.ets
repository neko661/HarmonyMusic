import commonEventManager from '@ohos.commonEventManager'
import { PublishEventType } from '../constants/EventContants'

export class SubscriberClass {
  static publishCount: number = 0
  static publish(eventType: PublishEventType, data: string) {
    commonEventManager.publish(eventType, { data }, (err) => {
      if (err) {
        if(SubscriberClass.publishCount<3){
          SubscriberClass.publish(eventType,data)
          SubscriberClass.publishCount++
        }else{
          SubscriberClass.publishCount = 1
        }
      }else{
        SubscriberClass.publishCount = 1
      }
    })
  }

  static subscribe(eventType:PublishEventType,subscriber:commonEventManager.CommonEventSubscriber,callback:(event:string)=>void) {
    commonEventManager.createSubscriber({events:[eventType]},(err,data:commonEventManager.CommonEventSubscriber)=>{
      if(err){
        return console.log('logData:','创建订阅者失败')
      }
      subscriber = data
      if(subscriber){
        commonEventManager.subscribe(subscriber,(err,data:commonEventManager.CommonEventData)=>{
          if(err){
            return console.log('logData:','订阅者事件失败')
          }
          callback(data.data as string)
        })
      }
    })
  }
}