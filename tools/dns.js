const https=require('https')
let array=["github.githubassets.com",
"camo.githubusercontent.com",
"github.map.fastly.net",
"github.global.ssl.fastly.net",
"github.com",
"api.github.com",
"raw.githubusercontent.com",
"user-images.githubusercontent.com",
"favicons.githubusercontent.com"]
array.forEach((url)=>{
    let domain=""
    let splits=url.split("\\.")
    for (var i = 0; i < splits.length; i++) {
        if (i == splits.length - 2) {
          domain += splits[i] + ".";
        }
        if (i == splits.length - 1) {
          domain += splits[i];
        }
    }
    https.get("https://" + domain + ".ipaddress.com/" + url,(res)=>{
        let data=''
        res.on('data',(chunck)=>{
            data+=chunck
        })
        res.on('end',()=>{
            resolve(console.log(data))
        })
        res.on('error',(e)=>{
            console.log(e)
        })
    })

})
