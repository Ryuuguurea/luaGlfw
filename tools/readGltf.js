const fs=require('fs')
var struct=JSON.parse(fs.readFileSync(process.argv[2],'utf-8'))
let out=process.argv[3]
let buffers=[]
for(let buffer of struct.buffers){
    let sbuffer=Buffer.from(buffer.uri.replace("data:application/octet-stream;base64,",""),'base64')
    let ui= new Uint8Array(sbuffer.length)
    for(let i=0;i<sbuffer.length; i++){
        ui[i]=sbuffer[i]
    }
    buffers.push(ui)
}

for(let mesh of struct.meshes){
    let array=[]
    let obj={
        name:mesh.name,
        attributes:[],
        indices:{

        }
    }
    for(let attribute in mesh.primitives[0].attributes){

        let accessor=struct.accessors[mesh.primitives[0].attributes[attribute]]
        let bufferView=struct.bufferViews[accessor.bufferView]
        let tmp={
            name:attribute,
            type:accessor.type,
            componentType:accessor.componentType
        }
        array.push(getBuffer(bufferView.buffer,bufferView.byteLength,bufferView.byteOffset))
        obj.attributes.push(tmp)
    }
    let indexAccessor=struct.accessors[mesh.primitives[0].indices]
    let indexBufferView=struct.bufferViews[indexAccessor.bufferView]
    array.push(getBuffer(indexBufferView.buffer,indexBufferView.byteLength,indexBufferView.byteOffset))
    obj.indices.type=indexAccessor.type
    obj.indices.componentType=indexAccessor.componentType
    let combine= combineBuffer(array)
    obj.indices.offset=combine.attributes[combine.attributes.length-1].offset
    obj.indices.length=combine.attributes[combine.attributes.length-1].length
    for(let i=0;i<obj.attributes.length;i++){
        obj.attributes[i].offset=combine.attributes[i].offset
        obj.attributes[i].length=combine.attributes[i].length
    }   
    console.log(`导出mesh:${mesh.name}`)
    fs.writeFileSync(out+'/'+mesh.name+'.bin',combine.buffer)
    fs.writeFileSync(out+'/'+mesh.name+'.json',JSON.stringify(obj))
}
function getBuffer(index,length,offset){
    let target = buffers[index].slice(offset,offset+length)
    return target
}
function combineBuffer(array){
    let result={
        buffer:Buffer.concat(array),
        attributes:[]
    }
    let tmp=0
    for(let i of array){
        let obj={
            offset:tmp,
            length:i.length
        }
        result.attributes.push(obj)
        tmp+=i.length
    }
    return result
}
function toLua(json){
    json.replace('')
}