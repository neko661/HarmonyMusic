
export interface songItemType {
  img: string
  name: string
  author: string
  url: string
  id: string
}


export interface recommendListType {
  img: string
  title: string
  count:string
}
export interface recommendDailyType {
  img: string
  title: string
  type:string
  top:string
  bottom: string
}


// 歌曲列表
export const songs: songItemType[] = [
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg',
    name: '直到世界的尽头',
    author: 'WANDS',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a',
    id: '0000'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.jpg',
    name: '画',
    author: '赵磊',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.mp3',
    id: '0001'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.jpg',
    name: 'Sweet Dreams',
    author: 'TPaul Sax / Eurythmics',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.mp3',
    id: '0002'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.jpg',
    name: '奢香夫人',
    author: '凤凰传奇',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.m4a',
    id: '0003'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.jpg',
    name: '空心',
    author: '光泽',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.mp3',
    id: '0004'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.jpg',
    name: '反转地球',
    author: '潘玮柏',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.mp3',
    id: '0005'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.jpg',
    name: 'No.9',
    author: 'T-ara',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.m4a',
    id: '0006'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.jpg',
    name: '孤独',
    author: 'G.E.M.邓紫棋',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.m4a',
    id: '0007'
  },

  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.jpg',
    name: 'Lose Control',
    author: 'Hedley',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.m4a',
    id: '0008'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.jpg',
    name: '倩女幽魂',
    author: '张国荣',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.m4a',
    id: '0009'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.jpg',
    name: '北京北京',
    author: '汪峰',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.m4a',
    id: '0010'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.jpg',
    name: '苦笑',
    author: '汪苏泷',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.mp3',
    id: '0011'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.jpg',
    name: '一生所爱',
    author: '卢冠廷 / 莫文蔚',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.m4a',
    id: '0012'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.jpg',
    name: '月半小夜曲',
    author: '李克勤',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.mp3',
    id: '0013'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.jpg',
    name: 'Rolling in the Deep',
    author: 'Adele',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.m4a',
    id: '0014'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.jpg',
    name: '海阔天空',
    author: 'Beyond',
    url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.m4a',
    id: '0015'
  },
  {
    img: 'https://cn.bing.com/images/search?view=detailV2&ccid=d84LI1WH&id=F8540EB3E4AFBB558C6760183254736A19293F4D&thid=OIP.d84LI1WHT_vVFuPAXxm2mgHaFh&mediaurl=https%3a%2f%2fts1.tc.mm.bing.net%2fth%2fid%2fR-C.77ce0b2355874ffbd516e3c05f19b69a%3frik%3dTT8pGWpzVDIYYA%26riu%3dhttp%253a%252f%252fwww.gaobei.com%252fupload%252f10001%252farticle%252f2022_03%252f15013930_27xzc2_b.jpg%26ehk%3dSxXN8UsglMczm0ZlnTmg0JbQ0bag%252bqMfSFO6puHrcqU%253d%26risl%3d%26pid%3dImgRaw%26r%3d0&exph=611&expw=820&q=%e5%b0%91%e5%a5%b3%e6%97%b6%e4%bb%a3&FORM=IRPRST&ck=73C9BEBB693E54E0C6AE3F92C33E3C57&selectedIndex=9&itb=0',
    name: '再次重逢的世界',
    author: '少女时代',
    url: 'https://music.163.com/outchain/player?type=2&id=22813978',
    id: '0016'
  }
]

// 轮播图数据
export const swiperList: string[] = [
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner1.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner2.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner3.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner4.png",
  "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner5.png"
]

// 每日推荐数据
export const dailyRecommend: recommendDailyType[] = [
  {
    img: 'https://ts3.tc.mm.bing.net/th/id/OIP-C.rgzT0fyd2ufxrFsVGs8abgHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    type: '每日推荐',
    top: '#660000',
    bottom: '#382e2f'
  },
  {
    img: 'https://ts1.tc.mm.bing.net/th/id/OIP-C.Wy-2j_H3jopRltz7ZMwvVgHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    title: '从 [Nothing on Me] 开启无限漫游',
    type: '私人漫游',
    top: '#382e2f',
    bottom: '#a37862'
  },
  {
    img: 'https://c-ssl.duitang.com/uploads/item/202002/29/20200229175241_bgpdr.jpg',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    type: '华语流行',
    top: '#a37862',
    bottom: '#174847'
  },
  {
    img: 'https://wx1.sinaimg.cn/mw690/008wzyyQgy1hzrayevlblj30u00u0n16.jpg',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    type: '私人雷达',
    top: '#174847',
    bottom: '#174847'
  }
]
// 推荐歌单数据
export const recommendList: recommendListType[] = [
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list1.jpg',
    title: '每日推荐 | 今天从《不得不爱》听起 | 私人雷达',
    count: '270.9万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list2.jpg',
    title: 'Yasuo和更多好听的 | 华语私人雷达 | 回忆8090',
    count: '476.1万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list3.jpg',
    title: 'Trap Remix丨当欧美热单遇上毒性低音',
    count: '186.3万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list4.jpg',
    title: '满级人类进化之路必备BGM | 根本停不下来',
    count: '186.3万'
  },
  {
    img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/list5.jpg',
    title: '认真去聆听这个世界的每一分每一秒 (强烈推荐)',
    count: '362.8万'
  },


]