import media from '@ohos.multimedia.media'
import emitter from '@ohos.events.emitter'
import { songItemType, songItemTypeModel } from '../models/music'
import { EmitEventType, PublishEventType } from '../constants/EventContants'
import { defaultState, PlayStateType } from '../models/playState'
import router from '@ohos.router'
import { PreferencesClass } from './PreferencesClass'
import formProvider from '@ohos.app.form.formProvider'
import formBindingData from '@ohos.app.form.formBindingData'
import { SubscriberClass } from './SubscriberClass'
import { Http2BufferClass } from './Http2Buffer'
import commonEventManager from '@ohos.commonEventManager'

export interface PlayStateData {
  playState: string
}

export default class AVPlayerClass {
  // 1.创建一个播放器
  static player: null | media.AVPlayer = null
  // 当前播放器播放歌曲的时长
  static duration: number = 0
  // 当前播放器播放的时长
  static time: number = 0
  // 当前播放器是否播放
  static isPlay: boolean = false
  // 当前播放器的播放模式
  static playMode: 'auto' | 'repeat' | 'random' = 'auto'
  // 当前播放器的播放列表
  static playList: songItemType[] = []
  // 当前播放的歌曲索引
  static playIndex: number = 0

  // 播放器上记录上下文
  static context:Context|null = null
  // 节流阀表示
  static timer = -1

  // 监听卡片推送过来的ID
  static subscriber = null

  // 2.初始化
  static async init(ctx: Context) {
    AVPlayerClass.context = ctx;
    const preferences:PreferencesClass = new PreferencesClass(ctx)
    // 监听卡片创建的事件
    if (AVPlayerClass.subscriber) {
      SubscriberClass.subscribe(PublishEventType.CARD_PUBLISH,AVPlayerClass.subscriber,(event: string)=>{
        switch (event){
          case 'next':
            AVPlayerClass.next()
            break
          case 'prev':
            AVPlayerClass.previous()
            break
        default:
            preferences.setFormId(event)
          }
        })
      }

    AVPlayerClass.player = await media.createAVPlayer()
    const playState = await preferences.getPlayState()
    playState.isPlay = false
    AVPlayerClass.time = playState.time
    AVPlayerClass.duration = playState.duration
    AVPlayerClass.playIndex = playState.playIndex
    AVPlayerClass.playList = playState.playList
    AVPlayerClass.playMode = playState.playMode
    await preferences.setPlayState(playState)
    
    const player = AVPlayerClass.player;
    player.on('stateChange', (state: media.AVPlayerState) => {
      switch (state) {
        case 'initialized':
          player.prepare()
          break
        case 'prepared':
          player.seek(AVPlayerClass.time)
          break
        case 'completed':
          if (AVPlayerClass.playMode === 'random' && AVPlayerClass.playList.length > 1) {
            let index = 0
            do {
              index = Math.floor(Math.random() * AVPlayerClass.playList.length)
            } while (index === AVPlayerClass.playIndex)
            AVPlayerClass.playIndex = index
          } else if (AVPlayerClass.playMode === 'auto') {
            AVPlayerClass.playIndex++
            AVPlayerClass.playIndex = (AVPlayerClass.playIndex + AVPlayerClass.playList.length) % AVPlayerClass.playList.length
          }
          AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex])
          break
      }
    })
    player.on('durationUpdate', (duration: number) => {
      AVPlayerClass.duration = duration
    })
    player.on('timeUpdate', (time) => {
      if(time!==0 && time!==AVPlayerClass.time){
        AVPlayerClass.time = time
        AVPlayerClass.updateState()
      }
    })
    player.on('seekDone', () => {
      player.play()
      AVPlayerClass.isPlay = true
    })
  }
  // 单曲播放
  static singlePlay(song: songItemType) {
    const isList = AVPlayerClass.playList.some(item => item.id === song.id)
    const player = AVPlayerClass.player;
    if (!player) return;
    
    if (isList) {
      if (song.url === player.url) {
        if (AVPlayerClass.isPlay) {
          AVPlayerClass.changePlay()
        } else {
          player.seek(AVPlayerClass.time)
        }
      }
      else {
        if(player.url === ''){
          player.url = song.url
        }else{
          const index = AVPlayerClass.playList.findIndex(item => item.id === song.id)
          AVPlayerClass.playIndex = index
          AVPlayerClass.changePlay()
        }
      }
    } else {
      AVPlayerClass.playList.unshift(song)
      AVPlayerClass.playIndex = 0
      AVPlayerClass.changePlay()
    }
  }
  // 切换歌曲
  static async changePlay() {
    const player = AVPlayerClass.player;
    if (!player) return;
    await player.reset()
    AVPlayerClass.time = 0
    AVPlayerClass.duration = 0
    player.url = AVPlayerClass.playList[AVPlayerClass.playIndex].url
  }
  // 暂停歌曲
  static async pause() {
    const player = AVPlayerClass.player;
    if (!player) return;
    player.pause()
    AVPlayerClass.isPlay = false
    const playStateData: PlayStateType = {
        img: AVPlayerClass.playList[AVPlayerClass.playIndex].img,
        name: AVPlayerClass.playList[AVPlayerClass.playIndex].name,
        author: AVPlayerClass.playList[AVPlayerClass.playIndex].author,
        time: AVPlayerClass.time,
        duration: AVPlayerClass.duration,
        playMode: AVPlayerClass.playMode,
        isPlay: AVPlayerClass.isPlay,
        url: AVPlayerClass.playList[AVPlayerClass.playIndex].url,
        playList: AVPlayerClass.playList,
        playIndex: AVPlayerClass.playIndex
      };
    const data: PlayStateData = {
      playState: JSON.stringify(playStateData)
    };
    emitter.emit({
      eventId: EmitEventType.UPDATE_STATE
    }, {
      data: data
    })
    const ctx = AVPlayerClass.context;
    if (!ctx) return;
    const preferences:PreferencesClass = new PreferencesClass(ctx)
    await preferences.setPlayState(JSON.parse(data.playState))
  }
  // 切换播放模式
  static changeMode(mode: 'auto' | 'repeat' | 'random') {
    AVPlayerClass.playMode = mode
    AVPlayerClass.updateState()
  }
  // 上一首
  static previous() {
    if (AVPlayerClass.playList.length === 0) {
      return
    }
    if (AVPlayerClass.playMode === 'random' && AVPlayerClass.playList.length > 1) {
      let index = 0
      do {
        index = Math.floor(Math.random() * AVPlayerClass.playList.length)
      } while (index === AVPlayerClass.playIndex)
      AVPlayerClass.playIndex = index
    } else {
      AVPlayerClass.playIndex--
      AVPlayerClass.playIndex = (AVPlayerClass.playIndex + AVPlayerClass.playList.length) % AVPlayerClass.playList.length
    }
    AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex])
  }
  // 下一首
  static next() {
    if (AVPlayerClass.playList.length === 0) {
      return
    }
    if (AVPlayerClass.playMode === 'random' && AVPlayerClass.playList.length > 1) {
      let index = 0
      do {
        index = Math.floor(Math.random() * AVPlayerClass.playList.length)
      } while (index === AVPlayerClass.playIndex)
      AVPlayerClass.playIndex = index
    } else {
      AVPlayerClass.playIndex++
      AVPlayerClass.playIndex = (AVPlayerClass.playIndex + AVPlayerClass.playList.length) % AVPlayerClass.playList.length
    }
    AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex])
  }
  // 删除列表歌曲
  static async remove(index:number){
    const player = AVPlayerClass.player;
    if(AVPlayerClass.playIndex === index){
      if(AVPlayerClass.playList.length>1){
        AVPlayerClass.playList.splice(index,1)
        AVPlayerClass.playIndex = (AVPlayerClass.playIndex+AVPlayerClass.playList.length)%AVPlayerClass.playList.length
        AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex])
      }else{
        if (player) {
          await player.reset()
        }
        AVPlayerClass.playList.splice(index,1)
        AVPlayerClass.isPlay = false
        AVPlayerClass.duration = 0
        AVPlayerClass.time = 0
        const data: PlayStateData = {
          playState: JSON.stringify(defaultState)
        };
        emitter.emit({
          eventId: EmitEventType.UPDATE_STATE
        }, {
          data: data
        })
        const ctx = AVPlayerClass.context;
        if (!ctx) return;
        const preferences:PreferencesClass = new PreferencesClass(ctx)
        await preferences.setPlayState(JSON.parse(data.playState))
        router.back()
      }
    }else{
      if(AVPlayerClass.playIndex>index){
        AVPlayerClass.playIndex--
      }
      AVPlayerClass.playList.splice(index,1)
    }
  }
  // 列表播放
  static listPlay(list:songItemTypeModel[],index:number){
    AVPlayerClass.playList = list
    AVPlayerClass.playIndex = index
    AVPlayerClass.singlePlay(AVPlayerClass.playList[AVPlayerClass.playIndex])
  }
  // 更新页面状态 首选项 卡片
  static async updateState() {
    if(AVPlayerClass.timer === -1){
      console.log('logData:','update')
      const playStateData: PlayStateType = {
          img: AVPlayerClass.playList[AVPlayerClass.playIndex].img,
          name: AVPlayerClass.playList[AVPlayerClass.playIndex].name,
          author: AVPlayerClass.playList[AVPlayerClass.playIndex].author,
          time: AVPlayerClass.time,
          duration: AVPlayerClass.duration,
          playMode: AVPlayerClass.playMode,
          isPlay: AVPlayerClass.isPlay,
          url: AVPlayerClass.playList[AVPlayerClass.playIndex].url,
          playList: AVPlayerClass.playList,
          playIndex: AVPlayerClass.playIndex
        };
      const data: PlayStateData = {
        playState: JSON.stringify(playStateData)
      };
      emitter.emit({
        eventId: EmitEventType.UPDATE_STATE
      }, {
        data
      })
      const ctx = AVPlayerClass.context;
      if (!ctx) return;
      const preferences:PreferencesClass = new PreferencesClass(ctx)
      await preferences.setPlayState(JSON.parse(data.playState))
      const id = await preferences.getFormId()
      Http2BufferClass.get(AVPlayerClass.playList[AVPlayerClass.playIndex].img, ctx,(res)=>{
        formProvider.updateForm(id,formBindingData.createFormBindingData({
          playState:data,
          fileName:res.fileName,
          formImages:res.formImages
        }))
      })
      AVPlayerClass.timer = setTimeout(()=>{
        AVPlayerClass.timer = -1
      },1000)
    }
  }
}