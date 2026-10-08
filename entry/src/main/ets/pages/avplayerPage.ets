import media from '@ohos.multimedia.media'

@Entry
@Component
struct AvplayerPage {
  @State totalTime:number=0
  @State currentTime:number=0
  @State message: string = 'Hello World'
  avplayer: media.AVPlayer | null = null

  async aboutToAppear() {
    const player = await media.createAVPlayer()
    this.avplayer = player
    player.on("stateChange", (state) => {
      console.log("mylog:播放状态", state)
      if (state == "initialized")
        player.prepare()
      if (state == "prepared")
        player.play()
    })
    player.url="http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.m4a"
    player.on("timeUpdate",(time)=>{
      this.currentTime=time
      this.totalTime=player.duration
    })
  }

  build() {
    Column() {
      Text("total:"+this.totalTime)
      Text("current:"+this.currentTime)
      Button("播放")
        .onClick(async ()=>{
          const player = this.avplayer;
          if (player) {
            await player.reset()
          }
        })


    }

  }
}