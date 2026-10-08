import request from '@ohos.request';
import fileFs from '@ohos.file.fs';
import fs from '@ohos.file.fs';

interface resultClass {
  fileName: string
  // 必须叫formImages不然卡片收不到
  formImages: Record<string, number>
}

class resultClassModel implements resultClass {
  fileName: string = ''
  formImages: Record<string, number> = {}

  constructor(model: resultClass) {
    this.fileName = model.fileName
    this.formImages = model.formImages
  }
}

export class Http2BufferClass {
  static httpFile: string = ''
  static result: resultClass = new resultClassModel({ fileName: '', formImages: {} })

  static get(httpFile: string, context: Context, callback: (result: resultClass) => void) {
    if (httpFile === Http2BufferClass.httpFile) {
      callback(Http2BufferClass.result)
    } else {
      Http2BufferClass.httpFile = httpFile
      let tempDir = context.getApplicationContext().tempDir;
      let fileName = 'file' + Date.now()
      let tmpFile = tempDir + '/' + fileName;
      request.downloadFile(context, { url: Http2BufferClass.httpFile, filePath: tmpFile })
        .then((task: request.DownloadTask) => {
          task.on('complete', () => {
            let file: fileFs.File | null = null;
            try {
              file = fs.openSync(tmpFile);
            } catch (e) {
              console.error('logData:', `openSync失败`);
            }
            if (file) {
              const formImages: Record<string, number> = {};
              formImages[tmpFile] = file.fd;
              Http2BufferClass.result = new resultClassModel({
                fileName: tmpFile,
                formImages: formImages
              })
              callback(Http2BufferClass.result)
            }
          })
          task.on('fail', () => {
            console.log('logData:', '第一次下载失败')
            request.downloadFile(context, { url: Http2BufferClass.httpFile, filePath: tmpFile })
              .then((task: request.DownloadTask) => {
                task.on('complete', () => {
                  let file: fileFs.File | null = null;
                  try {
                    file = fs.openSync(tmpFile);
                  } catch (e) {
                    console.error('logData:', `openSync失败`);
                  }
                  if (file) {
                    const formImages: Record<string, number> = {};
                    formImages[tmpFile] = file.fd;
                    Http2BufferClass.result = new resultClassModel({
                      fileName: tmpFile,
                      formImages: formImages
                    })
                    callback(Http2BufferClass.result)
                  }
                })
                task.on('fail', () => {
                  console.log('logData:', '第二次下载失败')
                });
              })
          })
        })
    }

  }
}
