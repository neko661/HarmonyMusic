import { songItemType } from '../models/music'
import { AVPlayerManager } from '../services/AVPlayerManager'
import emitter from '@ohos.events.emitter'

@Entry
@Component
export struct MinePage {
  @State curIndex:number = 0

  aboutToAppear() {
    // AlertDialog.show({message:'ok'})
    this.curIndex = AVPlayerManager.currentIndex

    emitter.on({eventId:0},(eventData)=>{
      // 当切歌的时候更新索引
      this.curIndex = AVPlayerManager.currentIndex
    })
  }

  build() {
    Column() {
      // 歌曲图片列表区域
      // 注意点：1. 固定Scroll  2. 当Scroll里面的内容超出了Scroll的高度，就会自动出滚动效果
      Scroll() {
        Column() {
          GridRow({ columns: 4 }) {
            ForEach(AVPlayerManager.songs, (item: songItemType, index: number) => {
              GridCol() {

                Stack(){
                  Image(item.img)
                    .height(100)
                  // 判断如果遍历到当前的歌曲信息时，这个歌曲正在播放，则显示跳动音符
                  if(this.curIndex == index ){
                    Image($r('app.media.ic_playing'))
                      .height(50)
                  }
                }
                .onClick(()=>{
                  // 当用户点击一首新歌时，要把AVPlayerManager.currentIndex值改为新歌索引index
                  AVPlayerManager.currentIndex = index
                  // this.curIndex = index
                  // 播放歌曲
                  AVPlayerManager.playMusic(item)
                  // this.curIndex = index
                })
              }
            })
            ForEach(AVPlayerManager.songs, (item: songItemType, index: number) => {
              GridCol() {
                Image(item.img)
                  .height(100)
              }
            })
          }
        }
      }
      // .scrollable(ScrollDirection.Horizontal)  //设置滚动方向 垂直或者水平
      .scrollBar(BarState.Off)  // 关闭滚动条
      .layoutWeight(5)

      // 基本信息
      Column({space:10}) {
        //用户头像
        Stack(){
          Image('https://picx.zhimg.com/v2-a68e4f49a755649dfb60ca75611efef1_1440w.jpg')
            .width(100)
            .height(100)
            .borderRadius(50)
            .objectFit(ImageFit.Cover)
        }
        .margin({top:-50})
        .width(100)
        .height(100)
        .borderRadius(50)
        //我的音乐中文名称
        Row({space:10}){
          Text('我的音乐')
            .fontSize(20)
            .fontColor(Color.White)
            .fontWeight(800)
          Image($r('app.media.ic_vip'))
            .height(30)
        }
        .alignItems(VerticalAlign.Center)

        //我的信息
           Column({space:15}){
             Row({space:10}){
               Row(){
                 Image($r('app.media.ic_girl'))
                   .height(15)
                   .fillColor('#ea136f')
                 Text('女生')
                   .fontColor(Color.White)
                   .fontSize(15)
                   .margin({left:5})
               }
               Text('双子座')
                 .fontColor(Color.White)
                 .fontSize(15)
               Text('广东')
                 .fontColor(Color.White)
                 .fontSize(15)
               Text('歌龄:'+'10年')
                 .fontColor(Color.White)
                 .fontSize(15)
             }
             .alignItems(VerticalAlign.Center)
             Row({space:10}){
                 Text('1'+"关注")
                   .fontColor(Color.White)
                   .fontSize(15)
               Text('100W '+"粉丝")
                 .fontColor(Color.White)
                 .fontSize(15)
               Text('16亿'+'点赞')
                 .fontColor(Color.White)
                 .fontSize(15)
             }
             .alignItems(VerticalAlign.Center)
           }



      }
      .layoutWeight(2)


    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }
}